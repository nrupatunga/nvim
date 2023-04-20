--https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/cmp.lua

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        {
            "zbirenbaum/copilot-cmp",
            after = { "copilot.lua" },
            config = function()
                require("copilot_cmp").setup()
            end,
        },
    },
    config = function()
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local compare = require("cmp.config.compare")

        local kind_icons = {
            Text = "",
            Method = "m",
            Function = "",
            Constructor = "",
            Copilot = "",
            Field = "",
            Variable = "",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "",
        }

        local borderstyle = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        }
        local check_backspace = function()
            local col = vim.fn.col(".") - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        --luasnip.expand_or_jump()
                        luasnip.expand()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    if entry.source.name == "copilot" then
                        vim_item.kind_hl_group = "CmpItemKindCopilot"
                    end
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        buffer = "[Buff]",
                        path = "[Path]",
                        copilot = "[AI]",
                        --signature = "[Sig]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            preselect = cmp.PreselectMode.None,
            completion = { completeopt = "noselect" },
            sources = cmp.config.sources({
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                {
                    name = "buffer",
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                { name = "path" },
                {
                    name = "copilot",
                    -- keyword_length = 0,
                    max_item_count = 3,
                    trigger_characters = {
                        {
                            ".",
                            ":",
                            "(",
                            "'",
                            '"',
                            "[",
                            ",",
                            "#",
                            "*",
                            "@",
                            "|",
                            "=",
                            "-",
                            "{",
                            "/",
                            "\\",
                            "+",
                            "?",
                            " ",
                        },
                    },
                    group_index = 2,
                },
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    compare.offset,
                    compare.exact,
                    -- compare.scopes,
                    compare.score,
                    compare.recently_used,
                    require("copilot_cmp.comparators").prioritize,
                    compare.locality,
                    compare.sort_text,
                    compare.length,
                    compare.order,
                },
            },
            duplicates = {
                nvim_lsp = 1,
                luasnip = 1,
                buffer = 1,
                path = 1,
                signature = 1,
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                completion = borderstyle,
                documentation = borderstyle,
            },
            experimental = {
                ghost_text = false,
                native_menu = false,
            },
        })

        require("luasnip/loaders/from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
    end,
}
