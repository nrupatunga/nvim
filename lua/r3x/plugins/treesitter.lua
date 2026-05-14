return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre" },
        build = ":TSUpdate",
        config = function()
            -- NOTE: Markdown injection workaround for Neovim 0.12-dev + nvim-treesitter.
            -- See ~/.config/nvim/queries/markdown/injections.scm (remove once upstream fixes land).
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cuda",
                    "cpp",
                    "css",
                    "dart",
                    "dockerfile",
                    "fish",
                    "go",
                    "graphql",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "llvm",
                    "lua",
                    "make",
                    "markdown",
                    "prisma",
                    "proto",
                    "python",
                    "rust",
                    "scss",
                    "sql",
                    "toml",
                    "tsx",
                    "typescript",
                    "yaml",
                },
                autotag = { enable = true },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-space>",
                        node_incremental = "<c-space>",
                        scope_incremental = "<c-s>",
                        node_decremental = "<c-backspace>",
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = { "BufReadPre" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sn"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>sp"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        ["]o"] = "@loop.*",
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                    goto_next = {
                        ["]d"] = "@conditional.outer",
                    },
                    goto_previous = {
                        ["[d"] = "@conditional.outer",
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        opts = {},
    },
}
