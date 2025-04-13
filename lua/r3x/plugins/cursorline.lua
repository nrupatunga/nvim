return {
    "yamatsum/nvim-cursorline",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvim-cursorline").setup({
            cursorline = {
                enable = true,
                timeout = 500, -- ms before line is highlighted
                number = false, -- also highlight line number?
            },
            cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true }, --
            },
        })
    end,
}
