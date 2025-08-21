return {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
        "giuxtaposition/blink-cmp-copilot",
    },
    version = "v0.*",
    opts = {
        enabled = function()
            -- Disable in LSP rename contexts (prompt buffers, nofile buffers)
            local buftype = vim.bo.buftype
            if buftype == "prompt" or buftype == "nofile" then
                return false
            end
            return true
        end,
        keymap = {
            preset = "none",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-e>"] = { "cancel", "fallback" },
            ["<C-y>"] = { "accept", "fallback" },
            ["<C-k>"] = { "show_documentation", "hide_documentation", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "normal",
            kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "",
                Copilot = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "🎨",
                File = "📄",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "󰗴",
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
                lsp = {
                    score_offset = 5,
                },
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 15,
                    async = true,
                },
                path = {
                    score_offset = 3,
                },
                snippets = {
                    score_offset = 0,
                },
                buffer = {
                    score_offset = -3,
                },
            },
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            list = {
                selection = { preselect = true, auto_insert = true },
            },
            ghost_text = {
                enabled = false, -- you had this disabled
            },
            menu = {
                border = "rounded",
                winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icons = {
                                    Text = "󰉿",
                                    Method = "󰆧",
                                    Function = "󰊕",
                                    Constructor = "",
                                    Field = "󰜢",
                                    Variable = "󰀫",
                                    Class = "",
                                    Copilot = "",
                                    Interface = "",
                                    Module = "",
                                    Property = "",
                                    Unit = "",
                                    Value = "󰎠",
                                    Enum = "",
                                    Keyword = "",
                                    Snippet = "",
                                    Color = "🎨",
                                    File = "📄",
                                    Reference = "",
                                    Folder = "󰉋",
                                    EnumMember = "",
                                    Constant = "",
                                    Struct = "",
                                    Event = "",
                                    Operator = "",
                                    TypeParameter = "󰗴",
                                }
                                return kind_icons[ctx.kind] or ctx.kind_icon or ""
                            end,
                            highlight = function(ctx)
                                return "BlinkCmpKind" .. ctx.kind
                            end,
                        },
                        label = {
                            width = { max = 40 },
                            text = function(ctx)
                                local label = ctx.label
                                if string.len(label) > 40 then
                                    return string.sub(label, 1, 37) .. "…"
                                end
                                return label
                            end,
                        },
                        source_name = {
                            width = { max = 8 },
                            text = function(ctx)
                                local source_names = {
                                    lsp = "[LSP]",
                                    snippets = "[Snip]",
                                    buffer = "[Buff]",
                                    copilot = "[AI]",
                                    path = "[Path]",
                                }
                                return source_names[ctx.source_name] or "[" .. ctx.source_name .. "]"
                            end,
                            highlight = "BlinkCmpSource",
                        },
                    },
                },
            },
            documentation = {
                auto_show = false,
                window = {
                    border = "rounded",
                    winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                },
            },
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },
        snippets = {
            preset = "luasnip",
        },
        fuzzy = {
            sorts = { "score", "kind", "label" },
        },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
        require("blink.cmp").setup(opts)
        require("luasnip/loaders/from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
        
        -- Set yellow highlight for selected item
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#3c3d00", fg = "#ffffff" })
    end,
}
