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

-- Set transparent background for blink.nvim after colorscheme loads
local function set_blink_transparent()
    -- Main menu colors with transparency
    vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { fg = '#c8d3f5', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = '#589ed7', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { bg = '#3e68d7', fg = '#ffffff', blend = 15 })
    
    -- Documentation window colors
    vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { fg = '#a9b8e8', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { fg = '#589ed7', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDocCursorLine', { bg = '#2d3f76', blend = 15 })
    
    -- Source labels with nice colors
    vim.api.nvim_set_hl(0, 'BlinkCmpSource', { fg = '#65bcff', italic = true, bg = 'NONE' })
    
    -- Kind icons with beautiful colors for each type
    vim.api.nvim_set_hl(0, 'BlinkCmpKindText', { fg = '#82aaff' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindMethod', { fg = '#c099ff' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindFunction', { fg = '#c099ff' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindConstructor', { fg = '#ffc777' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindField', { fg = '#86e1fc' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindVariable', { fg = '#86e1fc' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindClass', { fg = '#ffc777' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindInterface', { fg = '#ffc777' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindModule', { fg = '#ff966c' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindProperty', { fg = '#86e1fc' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindUnit', { fg = '#c3e88d' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindValue', { fg = '#ff966c' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindEnum', { fg = '#ffc777' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindKeyword', { fg = '#c099ff' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindSnippet', { fg = '#78dce8' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindColor', { fg = '#ff966c' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindFile', { fg = '#82aaff' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindReference', { fg = '#86e1fc' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindFolder', { fg = '#ff966c' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindEnumMember', { fg = '#86e1fc' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindConstant', { fg = '#ff966c' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindStruct', { fg = '#ffc777' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindEvent', { fg = '#ff966c' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindOperator', { fg = '#89ddff' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindTypeParameter', { fg = '#ffc777' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot', { fg = '#c3e88d' })
    
    -- Label and description colors
    vim.api.nvim_set_hl(0, 'BlinkCmpLabel', { fg = '#e4f0fb' })
    vim.api.nvim_set_hl(0, 'BlinkCmpLabelDescription', { fg = '#7a88cf', italic = true })
    vim.api.nvim_set_hl(0, 'BlinkCmpLabelDetail', { fg = '#828bb8' })
    
    -- Scrollbar if visible
    vim.api.nvim_set_hl(0, 'BlinkCmpScrollBar', { bg = '#1e2030', fg = '#589ed7' })
    
    -- Signature help
    vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelp', { fg = '#c8d3f5', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { fg = '#589ed7', bg = 'NONE' })
    
    -- Also set FloatNormal and NormalFloat for better transparency
    vim.api.nvim_set_hl(0, 'FloatNormal', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#589ed7', bg = 'NONE' })
end

-- Apply immediately
set_blink_transparent()

-- Reapply on colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = set_blink_transparent,
})
