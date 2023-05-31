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
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                --["<C-c>"] = "actions.close",
                ["q"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
                ["<leader>e"] = "actions.toggle",
            },
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
