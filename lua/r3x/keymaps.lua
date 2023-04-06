-- change leader to comma
vim.g.mapleader = ","
local function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local opts = { noremap = true, silent = true }
-- move but keep it at the center
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- because im lazy
keymap("n", "<C-a>", "ggVG", opts)
keymap("n", "<leader><ESC>", "<cmd>qa<CR>", opts)

-- buffer
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap("n", "<leader>ba", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but not current one" })

-- avoid vim register for some operations
keymap("n", "x", '"_x', opts)
keymap("x", "p", '"_dP', opts)
keymap({ "n", "x" }, "<leader>yy", '"+y', opts) -- copy to system clipboard
keymap({ "n", "x" }, "<leader>pp", '"+p', opts) -- paste from system clipboard

-- split resize
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- term mode
keymap("t", "<esc>", "<C-\\><C-n>", opts) -- go back to normal mode with <esc> on terminal mode

-- search and replace
keymap("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- easier escape mode from home row keys
keymap("i", "jk", "<ESC>")

-- Better paste
keymap("v", "p", '"_dP')

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- plugin keymaps
-- hop.nvim
keymap("n", "<leader><leader>w", ":HopWord<CR>")
keymap("n", "<leader><leader>b", ":HopWordBC<CR>")
keymap("n", "<leader><leader>p", ":HopPattern<CR>")

-- nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Move text up and down, only works in visual mode, other mode, since
-- xmonad conflicts, we havent mappend it yet
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")

vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.disable()
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
    end
end

keymap("n", "<leader>D", ":call v:lua.toggle_diagnostics()<CR>", { silent = true, noremap = true })
