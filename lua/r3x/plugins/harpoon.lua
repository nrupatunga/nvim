return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("harpoon"):setup({
            default = {
                get_root_dir = function()
                    local cwd = vim.loop.cwd()
                    local root = vim.fn.system("git rev-parse --show-toplevel")
                    if vim.v.shell_error == 0 and root ~= nil then
                        return string.gsub(root, "\n", "")
                    end
                    return cwd
                end,
            },
        })
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
