local options = {
    autochdir = false, -- change the directory according to the file opened
    autoread = true,
    autowrite = true,
    backspace = "indent,eol,start", -- https://tinyurl.com/2p8yv2hh
    cindent = true,
    cmdheight = 1, -- command line number of lines
    conceallevel = 0, -- so that `` is visible in markdown file
    cursorline = false, -- cursorline
    fileencoding = "utf-8",
    foldenable = true, -- folding is enabled for codes
    history = 1000,
    hlsearch = true,
    ignorecase = true,
    number = true,
    numberwidth = 4,
    pumheight = 10, -- number of items to show in the pop up menu
    relativenumber = false,
    showcmd = true,
    showmode = false, -- no more --INSERT-- message on the screen
    --signcolumn = "yes", -- signcolumn always, if set to true
    signcolumn = "no", -- signcolumn always, if set to true
    termguicolors = false,
    textwidth = 72,
    updatetime = 300,
    visualbell = true, -- this is for visual flashy display of vim screen, use instead of sound
    wildmenu = true, -- wildmenu for commands, when you press tab it will show some possible commands
    swapfile = false,
    showtabline = 2,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- other commands
vim.cmd("set whichwrap+=<,>,[,],h")
vim.cmd([[set iskeyword+=-]])
vim.cmd("filetype plugin on")
vim.cmd("syntax on") -- syntax highlighting

-- cursor settings, red and white blocks no line cursor
vim.cmd("highlight Cursor guifg=white guibg=red")
vim.cmd("set guicursor+=i:block-Cursor")
vim.cmd("set guicursor=n-v-c:block-Cursor")
vim.cmd("set guicursor+=n-v-c:blinkon0")
vim.cmd("set guicursor+=i:blinkwait20")
vim.cmd("au InsertLeave * hi Cursor guibg=red")
vim.cmd("au InsertEnter * hi Cursor guibg=green")

-- gui configuration
vim.cmd("highlight   Pmenu         ctermfg=0 ctermbg=2")
vim.cmd("highlight   PmenuSel      ctermfg=0 ctermbg=7")
vim.cmd("highlight   PmenuSbar     ctermfg=7 ctermbg=0")
vim.cmd("highlight   PmenuThumb    ctermfg=0 ctermbg=7")

--vim.cmd(
    --[[command! -nargs=0 GoToFile lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer = false }))]]
--)
vim.cmd([[command! -nargs=0 GoToFile lua require("harpoon.ui").nav_file(1)<cr> ]])
vim.cmd([[command! -nargs=0 Grep lua require('telescope.builtin').live_grep()]])
vim.cmd([[command! -nargs=0 SmartGoTo :Telescope smart_goto]])

vim.cmd("hi Search ctermbg=yellow")
vim.cmd("hi Search ctermfg=Red")
vim.lsp.set_log_level("off")
--vim.cmd("set winbar=%f%m")
