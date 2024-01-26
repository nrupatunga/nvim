return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        local telescope = require("telescope")

        local function add_file()
            harpoon:list():append()
            vim.notify = require("notify")
            vim.notify(" Marked file")
        end

        harpoon:setup()
        telescope.load_extension("harpoon")
        vim.keymap.set("n", "<leader>a", add_file, { desc = "harpoon mark" })
        vim.keymap.set("n", "<leader>ho", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), {
                border = "rounded",
                title_pos = "center",
                ui_width_ratio = 0.3,
            })
        end, { desc = "harpoon toggle menu" })
        vim.keymap.set("n", "<leader>d", function()
            harpoon:list():next({
                ui_nav_wrap = true,
            })
        end)
    end,
}
