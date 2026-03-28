-- change leader to comma
vim.g.mapleader = ","
local function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

local u = require("r3x.utils")

-- ── Navigation ──────────────────────────────────────────────────────────

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-a>", "ggVG")

-- ── Buffers ─────────────────────────────────────────────────────────────

keymap("n", "<leader>q", "<cmd>wqa<CR>", { desc = "Save all and quit" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap("n", "<leader>ba", "<cmd>%bd|e#<cr>", { desc = "Close all buffers except current" })

-- ── Clipboard ───────────────────────────────────────────────────────────

keymap("n", "x", '"_x')
keymap("x", "p", '"_dP')
keymap("v", "p", '"_dP')
keymap({ "n", "x" }, "<leader>yy", '"+y', { desc = "Copy to system clipboard" })
keymap({ "n", "x" }, "<leader>pp", '"+p', { desc = "Paste from system clipboard" })

-- ── Copy file references ────────────────────────────────────────────────

-- ,yl → filepath:line (absolute)
keymap("n", "<leader>yl", function()
    u.copy_and_notify(u.format_ref(vim.fn.expand("%:p"), vim.fn.line("."), vim.fn.line(".")))
end, { desc = "Copy filepath:line" })

keymap("x", "<leader>yl", function()
    local l1, l2 = u.get_line_range()
    u.copy_and_notify(u.format_ref(vim.fn.expand("%:p"), l1, l2))
    u.exit_visual()
end, { desc = "Copy filepath:line range" })

-- ,yf → filename:line (basename only)
keymap("n", "<leader>yf", function()
    u.copy_and_notify(u.format_ref(vim.fn.expand("%:t"), vim.fn.line("."), vim.fn.line(".")))
end, { desc = "Copy filename:line" })

keymap("x", "<leader>yf", function()
    local l1, l2 = u.get_line_range()
    u.copy_and_notify(u.format_ref(vim.fn.expand("%:t"), l1, l2))
    u.exit_visual()
end, { desc = "Copy filename:line range" })

-- ── Splits ──────────────────────────────────────────────────────────────

keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- ── Editing ─────────────────────────────────────────────────────────────

keymap("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("i", "jk", "<ESC>")
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")

-- ── Diagnostics ─────────────────────────────────────────────────────────

vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.enable(false)
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
    end
end

keymap("n", "<leader>D", ":call v:lua.toggle_diagnostics()<CR>")

-- ── Misc ────────────────────────────────────────────────────────────────

keymap("n", "<leader>r", "<cmd>Lazy<cr>")
keymap("n", "<leader>hw", "<cmd>ClangdSwitchSourceHeader<cr>")
