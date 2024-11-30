return {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile", "InsertEnter" },
    --event = { "InsertEnter" },
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local kind_icons = {
            Text = "",
            Method = "m",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "",
            Copilot = "",
            Codeium = "",
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
            Robot = "ﮧ",
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
                    elseif require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").accept()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif vim.fn.exists("b:_codeium_completions") ~= 0 then
                        -- accept codeium completion if visible
                        vim.api.nvim_input(vim.fn["codeium#Accept"]())
                        fallback()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                        --luasnip.expand()
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
                    local ELLIPSIS_CHAR = "…"
                    local MAX_LABEL_WIDTH = 50
                    local MIN_LABEL_WIDTH = 50
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)

                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snip]",
                        buffer = "[Buff]",
                        copilot = "[AI]",
                        path = "[Path]",
                    })[entry.source.name]
                    if truncated_label ~= label then
                        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                    elseif string.len(label) < MIN_LABEL_WIDTH then
                        local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
                        vim_item.abbr = label .. padding
                    end
                    return vim_item
                end,
            },
            preselect = cmp.PreselectMode.None,
            completion = { completeopt = "noselect" },
            sources = cmp.config.sources({
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp" },
                { name = "copilot" },
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
            }),
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
