return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
                show_end = false,
                include = {
                    node_type = { "*" },
                },
            },
            indent = {
                char = "┆", -- Change the symbol for the indent line
            },
        },
        exclude = {
            filetypes = {
                "man",
                "help",
                "lazy",
                "alpha",
                "aerial",
                "lspinfo",
                "vimwiki",
                "Trouble",
                "NvimTree",
                "startify",
                "dashboard",
                "checkhealth",
                "diagnosticpopup",
                "TelescopePrompt",
                "TelescopeResults",
            },
        },
    },
    {
        event = "BufReadPre",
        "hynek/vim-python-pep8-indent",
    },
}
