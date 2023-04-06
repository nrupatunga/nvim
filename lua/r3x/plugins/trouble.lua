return {
    {
        "folke/trouble.nvim",
        event = "BufReadPre",
        keys = {
            { "<leader>xt", "<cmd>TroubleToggle<cr>", desc = "Toggle Diagnostics" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Current Buffer Diagnostics" },
            { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "References" },
            { "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "quickfix" },
            { "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "location list" },
        },
        opts = {},
    },
    {
        "edr3x/lsp_lines.nvim",
        keys = {
            {
                "<leader>l",
                function()
                    require("lsp_lines").toggle()
                end,
                desc = "Toggle lsp_lines",
            },
        },
        opts = {},
    },
}
