return {
    {
        "scrooloose/nerdcommenter",
        event = "BufReadPre",
    },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },
    {
        "edr3x/better-escape.nvim",
        event = "BufReadPre",
        opts = {
            --mapping = { "jk", "kj", "JK", "KJ", "jK", "kJ", "Jk", "Kj" },
            mapping = { "jk" },
            timeout = vim.o.timeoutlen,
            clear_empty_lines = false,
            keys = "<Esc>",
        },
    },
    {
        "folke/persistence.nvim",
        lazy = false,
        opts = {},
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
        },
    },
    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    },
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },
}
