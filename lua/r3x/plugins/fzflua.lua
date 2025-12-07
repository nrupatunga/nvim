return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
        {
            "<leader>f",
            function()
                require("fzf-lua").files({
                    cwd = vim.fn.getcwd(),
                    previewer = false,
                    winopts = { height = 0.35, width = 0.45 },
                })
            end,
            desc = "Find files",
        },
        {
            "<leader>F",
            function()
                require("fzf-lua").git_files({
                    previewer = false,
                    winopts = { height = 0.35, width = 0.45 },
                })
            end,
            desc = "Find git files",
        },
        {
            "<leader>o",
            function()
                require("fzf-lua").oldfiles({
                    cwd_only = true,
                    previewer = false,
                    winopts = { height = 0.35, width = 0.45 },
                })
            end,
            desc = "Recent files",
        },
        {
            "<leader>y",
            function()
                require("fzf-lua").marks({
                    previewer = false,
                    winopts = { height = 0.35, width = 0.45 },
                })
            end,
            desc = "Show marks",
        },
        {
            "<leader>t",
            function()
                require("fzf-lua").lsp_document_symbols({
                    winopts = { height = 0.6, width = 0.6, preview = { layout = "vertical" } },
                })
            end,
            desc = "Document symbols",
        },
        {
            "<leader>gr",
            function()
                require("fzf-lua").live_grep({
                    winopts = { height = 0.9, width = 0.8, preview = { layout = "horizontal" } },
                })
            end,
            desc = "Live grep",
        },
        {
            "<leader>gw",
            function()
                require("fzf-lua").grep_cword({
                    winopts = { height = 0.9, width = 0.8, preview = { layout = "horizontal" } },
                })
            end,
            desc = "Grep word under cursor",
        },
        {
            "<leader>b",
            function()
                require("fzf-lua").buffers({
                    previewer = false,
                    winopts = { height = 0.35, width = 0.45 },
                })
            end,
            desc = "List buffers",
        },
        {
            "<leader>T",
            function()
                require("fzf-lua").treesitter({
                    winopts = { height = 0.6, width = 0.6, preview = { layout = "vertical" } },
                })
            end,
            desc = "Treesitter symbols",
        },
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status({
                    winopts = { height = 0.9, width = 0.8, preview = { layout = "horizontal" } },
                })
            end,
            desc = "Git status",
        },
        {
            "<leader>gt",
            function()
                require("fzf-lua").git_branches({
                    winopts = { height = 0.5, width = 0.6 },
                })
            end,
            desc = "Git branches",
        },
        {
            "<leader>k",
            function()
                require("fzf-lua").keymaps({
                    winopts = { height = 0.7, width = 0.7 },
                })
            end,
            desc = "List keymaps",
        },
    },
    config = function()
        local fzf = require("fzf-lua")
        local actions = require("fzf-lua.actions")

        fzf.setup({
            "default-title",
            fzf_colors = true,
            fzf_opts = {
                ["--layout"] = "reverse",
                ["--marker"] = "+",
            },
            winopts = {
                height = 0.85,
                width = 0.80,
                row = 0.35,
                col = 0.50,
                border = "rounded",
                preview = {
                    border = "border",
                    wrap = "nowrap",
                    hidden = "nohidden",
                    vertical = "down:45%",
                    horizontal = "right:50%",
                    layout = "flex",
                    flip_columns = 120,
                    title = true,
                    title_pos = "center",
                    delay = 100,
                },
            },
            keymap = {
                builtin = {
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    ["tab"] = "down",
                    ["shift-tab"] = "up",
                    ["ctrl-j"] = "down",
                    ["ctrl-k"] = "up",
                },
            },
            actions = {
                files = {
                    ["default"] = actions.file_edit,
                    ["ctrl-s"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                    ["ctrl-t"] = actions.file_tabedit,
                },
                buffers = {
                    ["default"] = actions.buf_edit,
                    ["ctrl-s"] = actions.buf_split,
                    ["ctrl-v"] = actions.buf_vsplit,
                    ["ctrl-t"] = actions.buf_tabedit,
                },
            },
            files = {
                prompt = "  ",
                fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude target --exclude build]],
                git_icons = true,
                file_icons = true,
                color_icons = true,
                formatter = "path.filename_first",
            },
            git = {
                files = {
                    prompt = "  ",
                    formatter = "path.filename_first",
                },
                status = {
                    prompt = " ",
                },
                branches = {
                    prompt = " ",
                },
            },
            grep = {
                prompt = "  ",
                input_prompt = "Grep: ",
                rg_opts = [[--column --line-number --no-heading --color=always --smart-case --hidden -g "!.git" -g "!node_modules" -g "!target" -g "!build"]],
            },
            lsp = {
                prompt_postfix = " ",
                symbols = {
                    prompt = "  ",
                },
            },
            buffers = {
                prompt = "  ",
                formatter = "path.filename_first",
                actions = {
                    ["ctrl-x"] = { fn = actions.buf_del, reload = true },
                },
            },
            oldfiles = {
                prompt = "  ",
                formatter = "path.filename_first",
            },
            marks = {
                prompt = "  ",
            },
            keymaps = {
                prompt = "  ",
            },
        })
    end,
}
