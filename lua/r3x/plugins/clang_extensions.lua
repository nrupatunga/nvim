return {
    "p00f/clangd_extensions.nvim",
    keys = {
        {
            "<leader>hs",
            function()
                require("lsp-inlayhints").toggle()
            end,
            desc = "Toggle inlay hints",
        },
    },
}
