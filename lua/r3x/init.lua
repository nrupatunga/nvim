require("r3x.options")
require("r3x.keymaps")
require("r3x.lazy")

--vim.cmd([[colorscheme darkplus]])
vim.cmd([[colorscheme github_dark_high_contrast]])
--vim.cmd([[colorscheme night-owl]])
--vim.cmd([[colorscheme carbonfox]])
if vim.g.colors_name == "github_dark_high_contrast" then
    vim.cmd([[highlight Comment cterm=italic gui=italic guifg=#838383]])
    vim.cmd([[highlight LineNr guifg=#838383]])
end
