return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    commit = "de72250e054e5e691b9736ee30db72c65d560771",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local startify = require("alpha.themes.startify")

        startify.section.header.val = "neovim"
        startify.section.mru_cwd.val = {
            { type = "padding", val = 1 },
            {
                type = "group",
                val = function()
                    return { startify.mru(0, vim.fn.getcwd(), 5) }
                end,
                opts = { shrink_margin = false },
            },
        }
        startify.section.mru.val = {
            { type = "padding", val = 1 },
            { type = "text", val = "MRU", opts = { hl = "SpecialComment" } },
            { type = "padding", val = 1 },
            {
                type = "group",
                val = function()
                    return { startify.mru(5, "", 5) }
                end,
            },
        }
        startify.nvim_web_devicons.enabled = false
        alpha.setup(startify.config)
    end,
}
