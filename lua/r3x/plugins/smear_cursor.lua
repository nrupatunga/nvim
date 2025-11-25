return {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
        -- Keep block cursor shape and disable smear while typing
        vertical_bar_cursor_insert_mode = false,
        smear_insert_mode = false,
    },
    config = function(_, opts)
        require("smear_cursor").setup(opts)
    end,
}
