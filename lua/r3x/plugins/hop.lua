return {
    "phaazon/hop.nvim",
    event = "BufReadPre",
    config = function()
        require("hop").setup()
    end,
}
