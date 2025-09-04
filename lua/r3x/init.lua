-- Enable Lua module loader cache (Neovim 0.9+)
pcall(function()
    if vim.loader and vim.loader.enable then
        vim.loader.enable()
    end
end)

require("r3x.options")
require("r3x.keymaps")
require("r3x.lazy")

-- Default colorscheme
--vim.cmd([[colorscheme kanagawa-dragon]])
--vim.cmd([[colorscheme vague]])
vim.cmd([[colorscheme github_dark_high_contrast]])
--vim.cmd([[colorscheme gruvbox]])
--vim.cmd([[colorscheme night-owl]])
--vim.cmd([[colorscheme carbonfox]])
--if vim.g.colors_name == "night-owl" then
vim.cmd([[highlight Comment cterm=italic gui=italic guifg=#838383]])
vim.cmd([[highlight LineNr guifg=#838383]])
--end

-- Blink popup/win styling to match lualine command palette
local function set_blink_transparent()
    local function get_hl_hex(name, key)
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
        if not ok or not hl then
            return nil
        end
        local v = hl[key] or hl[(key == "bg") and "background" or "foreground"]
        if type(v) == "number" then
            return string.format("#%06x", v)
        end
        if type(v) == "string" then
            return v
        end
        return nil
    end
    local function lighten(hex, factor)
        if not hex or hex:sub(1, 1) ~= "#" then
            return hex
        end
        local r = tonumber(hex:sub(2, 3), 16)
        local g = tonumber(hex:sub(4, 5), 16)
        local b = tonumber(hex:sub(6, 7), 16)
        r = math.floor(r + (255 - r) * factor)
        g = math.floor(g + (255 - g) * factor)
        b = math.floor(b + (255 - b) * factor)
        return string.format("#%02x%02x%02x", r, g, b)
    end
    local function darken(hex, factor)
        if not hex or hex:sub(1, 1) ~= "#" then
            return hex
        end
        local r = tonumber(hex:sub(2, 3), 16)
        local g = tonumber(hex:sub(4, 5), 16)
        local b = tonumber(hex:sub(6, 7), 16)
        r = math.floor(r * factor)
        g = math.floor(g * factor)
        b = math.floor(b * factor)
        return string.format("#%02x%02x%02x", r, g, b)
    end
    local function blend(bg_hex, fg_hex, ratio)
        if not (bg_hex and fg_hex) then
            return bg_hex
        end
        if bg_hex:sub(1, 1) ~= "#" or fg_hex:sub(1, 1) ~= "#" then
            return bg_hex
        end
        local br = tonumber(bg_hex:sub(2, 3), 16)
        local bg = tonumber(bg_hex:sub(4, 5), 16)
        local bb = tonumber(bg_hex:sub(6, 7), 16)
        local fr = tonumber(fg_hex:sub(2, 3), 16)
        local fg = tonumber(fg_hex:sub(4, 5), 16)
        local fb = tonumber(fg_hex:sub(6, 7), 16)
        local r = math.floor(br * (1 - ratio) + fr * ratio)
        local g = math.floor(bg * (1 - ratio) + fg * ratio)
        local b = math.floor(bb * (1 - ratio) + fb * ratio)
        return string.format("#%02x%02x%02x", r, g, b)
    end

    -- Base colors from current scheme
    local normal_bg = get_hl_hex("Normal", "bg") or "#1a1b26"
    local normal_fg = get_hl_hex("Normal", "fg") or "#c0caf5"

    -- Try to pick the command/active lualine "a" background as accent
    local accent = get_hl_hex("lualine_a_command", "bg")
        or get_hl_hex("lualine_a_normal", "bg")
        or get_hl_hex("StatusLine", "fg") -- fallback to a visible tone
        or "#ff9e64" -- warm orange fallback to match statusline vibe

    -- Force true-black popups for Blink UI
    local menu_bg = "#000000"
    local menu_fg = lighten(normal_fg, 0.18)
    -- Border uses the same warm accent (slightly lightened)
    local border_fg = lighten(accent, 0.10)
    -- Softer selection: blend black with the warm accent
    local select_bg = blend("#000000", accent, 0.28)
    local select_fg = "#ffffff"
    local doc_bg = "#000000"
    local doc_fg = lighten(normal_fg, 0.10)

    -- Main menu
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = menu_fg, bg = menu_bg })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = border_fg, bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = select_bg, fg = select_fg, bold = true })

    -- Documentation window
    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = doc_fg, bg = doc_bg })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = border_fg, bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { bg = blend(doc_bg, accent, 0.14) })

    -- Labels and meta
    vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = lighten(accent, 0.35), italic = true, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = lighten(normal_fg, 0.20), italic = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = darken(normal_fg, 0.65) })

    -- Signature help/borders
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { fg = doc_fg, bg = doc_bg })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = border_fg, bg = "NONE" })

    -- Do not override global FloatBorder to avoid affecting other UIs

    -- Minimal, cohesive kind coloring: use the warm accent for all kinds
    local function set(name, color)
        vim.api.nvim_set_hl(0, name, { fg = color })
    end
    local kinds = {
        "Text",
        "Method",
        "Function",
        "Constructor",
        "Field",
        "Variable",
        "Class",
        "Interface",
        "Module",
        "Property",
        "Unit",
        "Value",
        "Enum",
        "Keyword",
        "Snippet",
        "Color",
        "File",
        "Reference",
        "Folder",
        "EnumMember",
        "Constant",
        "Struct",
        "Event",
        "Operator",
        "TypeParameter",
    }
    for _, k in ipairs(kinds) do
        set("BlinkCmpKind" .. k, lighten(accent, 0.02))
    end
end

-- Apply immediately
set_blink_transparent()

-- Reapply on colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_blink_transparent,
})

-- Also reapply once on VimEnter in case lualine defines groups later
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.schedule(set_blink_transparent)
    end,
})

-- Open recent files picker on startup when no file was given
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("OpenRecentOnStart", { clear = true }),
    callback = function()
        if vim.fn.argc() == 0 then
            local bufnr = vim.api.nvim_get_current_buf()
            local empty = (vim.api.nvim_buf_line_count(bufnr) == 1)
                and (vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == "")
            if empty then
                pcall(function()
                    -- Ensure fff is loaded before using its API
                    local ok_lazy, lazy = pcall(require, "lazy")
                    if ok_lazy and lazy and lazy.load then
                        pcall(lazy.load, { plugins = { "fff.nvim" } })
                    end
                    local start = vim.loop.cwd()
                    local dotgit = vim.fs.find(".git", { upward = true, path = start })[1]
                    if dotgit then
                        -- Temporarily filter out certain extensions (e.g., .mp4) for the first startup picker
                        local fff_ok, fff = pcall(require, "fff")
                        if fff_ok then
                            local fp_ok, fp = pcall(require, "fff.file_picker")
                            if fp_ok and fp and type(fp.search_files) == "function" then
                                local orig_search = fp.search_files
                                local pui_ok, pui = pcall(require, "fff.picker_ui")
                                local orig_close = pui_ok and pui and pui.close

                                fp.search_files = function(query, max_results, max_threads, current_file, reverse_order)
                                    local items =
                                        orig_search(query, max_results, max_threads, current_file, reverse_order)
                                    if type(items) ~= "table" then
                                        return items
                                    end
                                    local filtered = {}
                                    local blocked = {
                                        mp4 = true,
                                        ["mp4.mp4"] = true,
                                        mov = true,
                                        mkv = true,
                                        avi = true,
                                        webm = true,
                                        wmv = true,
                                        m4v = true,
                                        mpeg = true,
                                        mpg = true,
                                        ["3gp"] = true,
                                        ogv = true,
                                        flv = true,
                                    }
                                    for _, it in ipairs(items) do
                                        local ext = (it.extension or ""):lower()
                                        if not blocked[ext] then
                                            table.insert(filtered, it)
                                        end
                                    end
                                    return filtered
                                end

                                if pui_ok and orig_close then
                                    pui.close = function(...)
                                        local ret = { orig_close(...) }
                                        -- Restore original search and close when picker is closed
                                        fp.search_files = orig_search
                                        pui.close = orig_close
                                        -- LuaJIT/5.1 compatibility: use global unpack
                                        return unpack(ret)
                                    end
                                end
                            end
                            fff.find_in_git_root()
                        else
                            -- Fallback if fff failed to load
                            pcall(function()
                                local ok_lazy2, lazy2 = pcall(require, "lazy")
                                if ok_lazy2 and lazy2 and lazy2.load then
                                    pcall(lazy2.load, { plugins = { "telescope.nvim" } })
                                end
                                local ok_b, builtin = pcall(require, "telescope.builtin")
                                if ok_b then
                                    builtin.oldfiles({ previewer = false })
                                end
                            end)
                        end
                    else
                        -- Outside Git: avoid indexing huge dirs; show recent files in cwd
                        local ok_lazy, lazy2 = pcall(require, "lazy")
                        if ok_lazy and lazy2 and lazy2.load then
                            pcall(lazy2.load, { plugins = { "telescope.nvim" } })
                        end
                        local ok_b, builtin = pcall(require, "telescope.builtin")
                        if ok_b then
                            local themes_ok, themes = pcall(require, "telescope.themes")
                            local opts = {
                                previewer = false,
                                cwd_only = true,
                                only_cwd = true,
                                initial_mode = "insert",
                                layout_config = { width = 0.45, height = 0.35 },
                            }
                            if themes_ok then
                                opts = themes.get_dropdown(opts)
                            end
                            pcall(builtin.oldfiles, opts)
                        end
                    end
                end)
            end
        end
    end,
})
