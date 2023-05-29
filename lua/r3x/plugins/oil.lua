return {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>e", "<cmd>Oil --float<CR>", desc = "Oil toggle" },
    },
    config = function()
        require("oil").setup({
            float = {
                -- Padding around the floating window
                padding = 0,
                max_width = 30,
                max_height = 30,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
            },
        })
    end,
}
