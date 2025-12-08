return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {
            enabled = true,
            notify = true,
            size = 1.5 * 1024 * 1024,
            line_length = 1000,
            ---@param ctx {buf: number, ft:string}
            setup = function(ctx)
                if vim.fn.exists(":NoMatchParen") ~= 0 then
                    vim.cmd([[NoMatchParen]])
                end
                require("snacks").util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(ctx.buf) then
                        vim.bo[ctx.buf].syntax = ctx.ft
                    end
                end)
            end,
        },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        picker = {
            enabled = true,
            sources = {
                files = {
                    hidden = true,
                    ignored = false,
                },
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                        ["<Tab>"] = { "list_down", mode = { "n", "i" } },
                        ["<S-Tab>"] = { "list_up", mode = { "n", "i" } },
                    },
                },
            },
            layout = {
                preset = "dropdown",
            },
        },
        explorer = { enabled = true },
        indent = { enabled = false }, -- Disable indent guide lines
        input = { enabled = true },
        scope = { enabled = false }, -- Disable scope highlighting
    },
    keys = {
        -- Lazygit
        {
            "<leader>gg",
            function()
                require("snacks").lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gf",
            function()
                require("snacks").lazygit.log_file()
            end,
            desc = "Lazygit Current File History",
        },
        {
            "<leader>gl",
            function()
                require("snacks").lazygit.log()
            end,
            desc = "Lazygit Log (cwd)",
        },
        {
            "<leader>gb",
            function()
                require("snacks").gitbrowse()
            end,
            desc = "git browse",
        },
        -- Snacks Picker (alternative bindings with 's' prefix)
        {
            "<leader>sf",
            function()
                require("snacks").picker.files()
            end,
            desc = "Snacks: Find files",
        },
        {
            "<leader>sg",
            function()
                require("snacks").picker.grep()
            end,
            desc = "Snacks: Grep",
        },
        {
            "<leader>sb",
            function()
                require("snacks").picker.buffers()
            end,
            desc = "Snacks: Buffers",
        },
        {
            "<leader>so",
            function()
                require("snacks").picker.recent()
            end,
            desc = "Snacks: Recent files",
        },
        {
            "<leader>sc",
            function()
                require("snacks").picker.commands()
            end,
            desc = "Snacks: Commands",
        },
        {
            "<leader>sh",
            function()
                require("snacks").picker.help()
            end,
            desc = "Snacks: Help",
        },
        -- Explorer
        {
            "<leader>e",
            function()
                require("snacks").explorer()
            end,
            desc = "File Explorer",
        },
    },
}
