require("r3x.options")
require("r3x.keymaps")
require("r3x.lazy")

vim.cmd([[colorscheme darkplus]])
--vim.cmd([[colorscheme vague]])
--vim.cmd([[colorscheme github_dark_high_contrast]])
--vim.cmd([[colorscheme gruvbox]])
--vim.cmd([[colorscheme night-owl]])
--vim.cmd([[colorscheme carbonfox]])
--if vim.g.colors_name == "night-owl" then
vim.cmd([[highlight Comment cterm=italic gui=italic guifg=#838383]])
vim.cmd([[highlight LineNr guifg=#838383]])
--end
