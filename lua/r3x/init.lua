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

-- Enhanced blink.cmp menu colors with better contrast and vibrancy
local function set_blink_transparent()
    -- Main menu colors - improved contrast and readability
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#e0e6f7", bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#7aa2f7", bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#3d59a1", fg = "#ffffff", bold = true })

    -- Documentation window colors - enhanced readability
    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "#c0caf5", bg = "#16161e" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#7aa2f7", bg = "NONE" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { bg = "#2d3f76" })

    -- Source labels with enhanced visibility
    vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "#7dcfff", italic = true, bold = true })

    -- Kind icons with improved color palette and better differentiation
    vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = "#9d7cd8", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#bb9af7", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#7dcfff", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = "#e0af68", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = "#73daca", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#73daca", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = "#9ece6a", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = "#e0af68", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#9d7cd8", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = "#2ac3de", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = "#73daca", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = "#e0af68", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = "#bb9af7", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = "#f7768e", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = "#89ddff", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = "#e0af68", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKindCopilot", { fg = "#9ece6a", bold = true })

    -- Label and description colors - enhanced contrast
    vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#9aa5ce", italic = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = "#565f89" })

    -- Enhanced scrollbar
    vim.api.nvim_set_hl(0, "BlinkCmpScrollBar", { bg = "#2d3f76", fg = "#7aa2f7" })

    -- Signature help with better visibility
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { fg = "#c0caf5", bg = "#16161e" })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#7aa2f7", bg = "NONE" })

    -- Float window enhancements
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "NONE" })
end

-- Apply immediately
set_blink_transparent()

-- Reapply on colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_blink_transparent,
})
