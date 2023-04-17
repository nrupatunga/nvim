return {
    "goolord/alpha-nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local startify = require("alpha.themes.startify")

        startify.section.header.val = {}
	startify.section.mru.val = { { type = "padding", val = 0 } }
        startify.nvim_web_devicons.enabled = false
        alpha.setup(startify.config)
    end,
}
