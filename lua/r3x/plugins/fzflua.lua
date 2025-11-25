return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local height = 0.65
        local width = 0.70
        local center_row = (1 - height) / 2
        local center_col = (1 - width) / 2
        require("fzf-lua").setup({
            files = {
                prompt = " ",
                fd_opts = "--color=never --type f --hidden --follow --exclude .git",
            },
            winopts = {
                -- Centered float, Telescope-like footprint
                height = height,
                width = width,
                row = 0.50, -- use center anchor so 0.5/0.5 lands in the middle
                col = 0.50,
                anchor = "CENTER",
                relative = "editor",
                border = "rounded",
                preview = {
                    default = "bat",
                    layout = "flex", -- right when wide, below when narrow
                    vertical = "down:40%",
                    horizontal = "right:50%",
                    flip_columns = 120,
                    hidden = true, -- start hidden for a tighter, centered window
                },
            },
            fzf_opts = {
                ["--layout"] = "reverse-list", -- prompt at top (like Telescope)
                ["--info"] = "inline",
            },
        })
    end,
    keys = {
        {
            "<leader>f",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find files",
        },
        {
            "<leader>F",
            function()
                local fzf = require("fzf-lua")
                if vim.fn.isdirectory(".git") == 1 then
                    fzf.git_files()
                else
                    fzf.files()
                end
            end,
            desc = "Find git files or all",
        },
        {
            "<leader>o",
            function()
                require("fzf-lua").oldfiles({ cwd_only = true })
            end,
            desc = "Recent files",
        },
        {
            "<leader>gr",
            function()
                require("fzf-lua").live_grep_glob()
            end,
            desc = "Live grep",
        },
        {
            "<leader>gw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "Grep word under cursor",
        },
        {
            "<leader>b",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>t",
            function()
                local fzf = require("fzf-lua")
                local supports_symbols = #vim.lsp.get_clients({
                    bufnr = 0,
                    method = "textDocument/documentSymbol",
                }) > 0
                if supports_symbols then
                    return fzf.lsp_document_symbols()
                end
                return fzf.treesitter()
            end,
            desc = "Document symbols",
        },
        {
            "<leader>T",
            function()
                require("fzf-lua").treesitter()
            end,
            desc = "Treesitter symbols",
        },
        {
            "<leader>y",
            function()
                require("fzf-lua").marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "Git status",
        },
        {
            "<leader>gt",
            function()
                require("fzf-lua").git_branches()
            end,
            desc = "Git branches",
        },
        {
            "<leader>k",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "Keymaps",
        },
    },
}
