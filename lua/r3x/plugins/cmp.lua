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
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
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
                selection = "manual", -- equivalent to noselect
            },
            ghost_text = {
                enabled = false, -- you had this disabled
            },
        },
        completion = {
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
                            width = { max = 30 },
                            text = function(ctx)
                                local label = ctx.label
                                if string.len(label) > 30 then
                                    return string.sub(label, 1, 27) .. "…"
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
                auto_show = true,
                auto_show_delay_ms = 200,
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
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
        require("blink.cmp").setup(opts)
        require("luasnip/loaders/from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
    end,
}
