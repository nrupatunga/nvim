return {
    "rcarriga/nvim-notify",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("notify").setup({
            background_colour = "#1e222a",
        })
    end,
}
