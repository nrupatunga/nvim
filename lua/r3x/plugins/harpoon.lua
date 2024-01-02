return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("harpoon"):setup()
        require("telescope").load_extension("harpoon")
    end,
    keys = {
        {
            "<leader>a",
            function()
                local harpoon = require("harpoon")
                harpoon:list():append()
            end,
            desc = "Harpoon mark",
        },
        {
            "<leader>ho",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Harpoon open",
        },
    },
}
