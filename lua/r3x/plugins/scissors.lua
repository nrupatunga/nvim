return {
    "chrisgrieser/nvim-scissors",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
        vim.keymap.set({ "n", "x" }, "<leader>sa", function()
            require("scissors").addNewSnippet()
        end)
        vim.keymap.set("n", "<leader>se", function()
            require("scissors").editSnippet()
        end)
    end,
}
