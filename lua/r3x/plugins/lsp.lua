return {
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            ensure_installed = {
                "prettierd",
                "stylua",
                "clangd",
                "clang-format",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            --"ray-x/lsp_signature.nvim",
            "RRethy/vim-illuminate",
            config = function()
                require("illuminate").configure({
                    providers = {
                        "treesitter",
                        "regex", -- disable LSP completely
                    },
                    delay = 120,
                    under_cursor = false,
                    large_file_cutoff = 2000,
                    large_file_overrides = {
                        providers = { "regex" },
                    },
                    filetypes_denylist = {
                        "dirvish",
                        "fugitive",
                        "alpha",
                        "NvimTree",
                        "lazy",
                        "TelescopePrompt",
                        "DressingSelect",
                        "mason",
                        "", -- unnamed buffers
                    },
                })
            end,
        },
        event = "BufReadPre",
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = require("r3x.handlers").on_attach
            local capabilities = require("r3x.handlers").capabilities
            local opts = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            local servers = {
                "lua_ls",
                "bashls",
                "clangd",
                "jedi_language_server",
                "yamlls",
            }

            for _, server in pairs(servers) do
                if server == "lua_ls" then
                    local sumneko_opts = {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config") .. "/lua"] = true,
                                    },
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    }
                    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
                end
                if server == "jedi_language_server" then
                    local pyright_opts = {
                        settings = {
                            disableOrganizeImports = false,
                            python = {
                                pythonPath = "/home/nthere/anaconda3/bin/python",
                                analysis = {
                                    typeCheckingMode = "off",
                                },
                            },
                        },
                    }
                    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
                end
                if server == "yamlls" then
                    local yaml_opts = {
                        settings = {
                            yaml = {
                                schemas = {
                                    ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
                                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                                },
                                keyOrdering = false,
                            },
                        },
                    }
                    opts = vim.tbl_deep_extend("force", yaml_opts, opts)
                end

                lspconfig[server].setup(opts)
            end

            lspconfig["rust_analyzer"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "rustup", "run", "stable", "rust-analyzer" }, --TODO: `rustup component add rust-analyzer` to install LSP
                settings = {
                    ["rust-analyzer"] = {
                        procMacro = { enable = true },
                        cargo = { allFeatures = true },
                        checkOnSave = true,
                        check = {
                            command = "clippy", --TODO: `rustup component add clippy` to install clippy
                            extraArgs = { "--no-deps" },
                        },
                    },
                },
            })

            local cap = capabilities
            cap.offsetEncoding = "utf-8"

            lspconfig["clangd"].setup({
                on_attach = on_attach,
                capabilities = cap,
                cmd = { "clangd", "--background-index", "--clang-tidy" },
            })

            require("r3x.handlers").setup()
        end,
    },
    -- inlay hints at end of line
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {}, -- required, even if empty
    },
    -- code formatters
    {
        --"jose-elias-alvarez/null-ls.nvim",
        "nvimtools/none-ls.nvim",
        event = "LspAttach",
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            local diagnostics = null_ls.builtins.diagnostics

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            null_ls.setup({
                debug = false,
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("bufwritepre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
                sources = {
                    formatting.stylua,
                    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                    formatting.black.with({ extra_args = { "--fast" } }),
                    --formatting.autopep8,
                    formatting.isort,
                    formatting.clang_format.with({
                        extra_args = { "-style=file:" .. vim.fn.expand("/home/nthere/.clang-format") },
                    }),
                    --diagnostics.flake8,
                },
            })
        end,
    },
    -- code navigation
    --{
    --"SmiteshP/nvim-navbuddy",
    --event = "LspAttach",
    --dependencies = {
    --"SmiteshP/nvim-navic",
    --"MunifTanjim/nui.nvim",
    --},
    --keys = {
    --{
    --"<leader>lt",
    --function()
    --require("nvim-navbuddy").open()
    --end,
    --desc = "Navbuddy open",
    --},
    --},
    --opts = {
    --window = {
    --border = "rounded",
    --size = "80%",
    --position = "50%",
    --},
    --icons = {
    --Namespace = " ",
    --Package = " ",
    --String = " ",
    --Number = " ",
    --Boolean = "◩ ",
    --Array = " ",
    --Object = " ",
    --Key = " ",
    --Null = "ﳠ ",
    --Method = "m ",
    --Function = " ",
    --Constructor = " ",
    --Field = " ",
    --Variable = " ",
    --Class = "ﴯ ",
    --Interface = " ",
    --Module = " ",
    --Property = " ",
    --Enum = " ",
    --File = " ",
    --EnumMember = " ",
    --Constant = " ",
    --Struct = "  ",
    --Event = " ",
    --Operator = " ",
    --TypeParameter = " ",
    --},
    --},
    --},
}
