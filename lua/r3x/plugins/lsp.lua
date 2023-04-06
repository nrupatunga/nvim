return {
    {
        "williamboman/mason.nvim",
        event = "BufReadPre",
        opts = {
            ensure_installed = {
                "prettierd",
                "stylua",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "ray-x/lsp_signature.nvim",
            "RRethy/vim-illuminate",
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

            lspconfig["yamlls"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    yaml = {
                        keyOrdering = false,
                    },
                },
            })

            local cap = capabilities
            cap.offsetEncoding = "utf-8"

            lspconfig["clangd"].setup({
                on_attach = on_attach,
                capabilities = cap,
            })

            require("r3x.handlers").setup()
        end,
    },
    -- inlay hints
    {
        "lvimuser/lsp-inlayhints.nvim",
        event = "LspAttach",
        keys = {
            {
                "<leader>lh",
                function()
                    require("lsp-inlayhints").toggle()
                end,
                desc = "Toggle inlay hints",
            },
        },
        opts = {
            inlay_hints = {
                parameter_hints = {
                    show = true,
                    prefix = "<- ",
                    separator = ", ",
                    remove_colon_start = false,
                    remove_colon_end = true,
                },
                type_hints = {
                    show = true,
                    prefix = " » ",
                    separator = ", ",
                    remove_colon_start = false,
                    remove_colon_end = false,
                },
                only_current_line = false,
                labels_separator = "  ", -- gap between type hints and parameter hints
                highlight = "Comment", -- see `:highlight` for more options
            },
        },
    },
    -- code formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
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
                    if client.supports_method("textdocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("bufwritepre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                vim.lsp.buf.formatting_sync()
                            end,
                        })
                    end
                end,
                sources = {
                    formatting.stylua,
                    --formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                    --formatting.black.with({ extra_args = { "--fast" } }),
                    formatting.autopep8,
                    formatting.isort,
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
