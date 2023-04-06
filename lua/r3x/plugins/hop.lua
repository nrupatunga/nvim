return {
    "phaazon/hop.nvim",
    event = "BufReadPre",
    keys = {
        {
            "<leader><leader>w",
            "<cmd>HopWord<cr>",
        },
        {
            "<leader><leader>b",
            "<cmd>HopWordBC<cr>",
        },
        {
            "<leader><leader>p",
            "<cmd>HopPattern<cr>",
        },
    },
    config = function()
        require("hop").setup()
    end,
}
