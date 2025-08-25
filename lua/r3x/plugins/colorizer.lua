return {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    config = function()
        vim.opt.termguicolors = true
        require("colorizer").setup()
    end,
}
