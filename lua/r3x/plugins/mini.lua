return {
    "echasnovski/mini.nvim",
    version = false,
    keys = {
        { "<leader>e", "<cmd>lua MiniFiles.open()<CR>", desc = "mini.files toggle" },
    },
    config = function()
        require("mini.files").setup({
            mappings = {
                close = "q",
                go_in = "<cr>",
                go_in_plus = "<cr>",
                go_out = "-",
                go_out_plus = "-",
                reset = "<BS>",
                show_help = "g?",
                synchronize = "<leader>q",
                trim_left = "<",
                trim_right = ">",
            },
        })
    end,
}
