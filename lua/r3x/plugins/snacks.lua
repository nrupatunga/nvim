return {
    "folke/snacks.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 1.5 * 1024 * 1024, -- 1.5MB
            line_length = 1000, -- average line length (useful for minified files)
            -- Enable or disable features when big file detected
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
    },
    keys = {
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
    },
}
