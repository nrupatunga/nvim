-- pi-send: Send file references from neovim to pi coding agent
-- Finds pi in any pane of the current tmux session and pastes text into its editor

local function in_tmux()
    return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
end

local function find_pi_pane()
    if not in_tmux() then
        return nil
    end
    local result = vim.fn
        .system([[
      tmux list-panes -s -F '#{window_active} #{pane_active} #{pane_id} #{pane_pid}' \
      | sort -rn -k1,1 -k2,2 \
      | while read wa pa id pid; do
          for p in $pid $(cat /proc/$pid/task/$pid/children 2>/dev/null); do
              c=$(cat /proc/$p/comm 2>/dev/null)
              if [ "$c" = 'pi' ] || [ "$c" = 'π' ]; then echo $id; break 2; fi
          done
      done
    ]])
        :gsub("%s+", "")
    return result ~= "" and result or nil
end

local function send(text)
    local pane = find_pi_pane()
    if not pane then
        vim.notify("No pi pane found in session", vim.log.levels.WARN)
        return
    end
    local tmp = os.tmpname()
    local f = io.open(tmp, "w")
    if f then
        f:write(text)
        f:close()
    end
    vim.fn.system(
        string.format(
            "tmux load-buffer -b pi-ref %s && tmux paste-buffer -b pi-ref -t %s && tmux delete-buffer -b pi-ref && tmux send-keys -t %s \\\\ Enter",
            tmp,
            pane,
            pane
        )
    )
    os.remove(tmp)
end

local function send_current_line()
    local u = require("r3x.utils")
    send(u.format_ref(vim.fn.expand("%:p"), vim.fn.line("."), vim.fn.line(".")))
end

local function floating_input(row, col, callback)
    local buf = vim.api.nvim_create_buf(false, true)
    local parent_win = vim.api.nvim_get_current_win()
    local win_w = vim.api.nvim_win_get_width(parent_win)
    local win_h = vim.api.nvim_win_get_height(parent_win)
    local width = math.min(40, win_w - 4)
    col = math.max(0, math.min(col, win_w - width - 2))
    row = math.max(0, math.min(row, win_h - 3))
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        win = parent_win,
        row = row,
        col = col,
        width = width,
        height = 1,
        style = "minimal",
        border = "rounded",
        title = " Comment (empty to skip) ",
        title_pos = "center",
    })
    vim.bo[buf].buftype = "nofile"
    vim.cmd("startinsert")

    -- grow/shrink the float as the user types, stays centered
    local min_width = width
    vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
        buffer = buf,
        callback = function()
            if not vim.api.nvim_win_is_valid(win) then
                return true
            end
            local line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
            local needed = math.max(min_width, #line + 2)
            local max_width = win_w - 4
            local new_width = math.min(needed, max_width)
            local new_col = math.max(0, math.floor((win_w - new_width) / 2))
            vim.api.nvim_win_set_config(win, {
                relative = "win",
                win = parent_win,
                row = row,
                col = new_col,
                width = new_width,
                height = 1,
            })
        end,
    })

    local function close(submit)
        local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
        local text = (lines[1] or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        vim.api.nvim_buf_delete(buf, { force = true })
        vim.cmd("stopinsert")
        if submit then
            callback(text)
        else
            callback(nil)
        end
    end

    vim.keymap.set("i", "<CR>", function()
        close(true)
    end, { buffer = buf, noremap = true })
    vim.keymap.set("i", "<Esc>", function()
        close(false)
    end, { buffer = buf, noremap = true })
    vim.keymap.set("n", "<Esc>", function()
        close(false)
    end, { buffer = buf, noremap = true })
    vim.keymap.set("n", "q", function()
        close(false)
    end, { buffer = buf, noremap = true })
end

local function send_visual_paste()
    local u = require("r3x.utils")
    local l1, l2 = u.get_line_range()
    local ref = u.format_ref(vim.fn.expand("%:p"), l1, l2)
    u.exit_visual()
    send(ref)
end

local function send_visual_range()
    local u = require("r3x.utils")
    local l1, l2 = u.get_line_range()
    local ref = u.format_ref(vim.fn.expand("%:p"), l1, l2)
    local row = l1
    u.exit_visual()
    vim.schedule(function()
        local win_width = vim.api.nvim_win_get_width(0)
        local input_width = math.min(40, win_width - 4)
        local col = math.floor((win_width - input_width) / 2)
        floating_input(row - vim.fn.line("w0"), col, function(comment)
            if comment == nil then
                return
            end
            if comment ~= "" then
                send(comment .. ": " .. ref)
            else
                send(ref)
            end
        end)
    end)
end

return {
    "r3x/pi-send",
    virtual = true,
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>yc", send_current_line, { noremap = true, silent = true, desc = "Send file:line to pi" })
        vim.keymap.set("x", "<leader>yc", send_visual_range, { noremap = true, silent = true, desc = "Send file:line range to pi (with comment)" })
        vim.keymap.set("n", "<leader>yp", send_current_line, { noremap = true, silent = true, desc = "Send file:line to pi" })
        vim.keymap.set("x", "<leader>yp", send_visual_paste, { noremap = true, silent = true, desc = "Send file:line range to pi (no comment)" })
    end,
}
