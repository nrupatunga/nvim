return {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    config = function()
        local lspStatus = {
            function()
                local msg = "No LSP detected"
                local buf_ft = vim.bo.filetype
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = " ",
            color = { fg = "#ffffff", bg = "#5c6370" },
        }
        -- Put proper separators and gaps between components in sections
        local colors = {
            blue = "#569cd6",
            green = "#6a9955",
            purple = "#c586c0",
            red1 = "#d16969",
            yellow = "#dcdcaa",
            orange = "#ce9178",
            fg = "#d4d4d4",
            --bg_insert = "#9e5400",
            bg = "#007acc",
            bg_insert = "#007acc",
            --bg = "#3b3b3b",
            --bg_insert = "#3b3b3b",
            bg_visual = "#68217a",
            bg_inactive = "#252525",
            gray1 = "#5c6370",
            gray2 = "#2c323d",
            gray3 = "#3e4452",
            white = "#ffffff",
        }
        local empty = require("lualine.component"):extend()
        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < "x"
                for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
                end
                for id, comp in ipairs(section) do
                    if type(comp) ~= "table" then
                        comp = { comp }
                        section[id] = comp
                    end
                    comp.separator = left and { right = "" } or { left = "" }
                end
            end
            return sections
        end

        -- LuaFormatter on
        local custom_theme = {
            normal = {
                a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
            insert = {
                a = { fg = colors.fg, bg = colors.bg_insert, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg_insert, gui = "bold" },
                c = { fg = colors.fg, bg = colors.bg_insert, gui = "bold" },
            },
            visual = {
                a = { fg = colors.fg, bg = colors.bg_visual, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg_visual, gui = "bold" },
                c = { fg = colors.fg, bg = colors.bg_visual, gui = "bold" },
            },
            command = {
                a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
            },
            replace = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
            inactive = {
                a = { fg = colors.fg, bg = colors.bg },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
        }

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = custom_theme,
                component_separators = "",
                disabled_filetypes = { "alpha", "dashboard", "lazy" },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = process_sections({
                lualine_a = {},
                lualine_b = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = "#ededed", bg = "#5c6370" },
                        left_padding = 2,
                    },
                },
                lualine_c = {
                    { "filename" }, -- Moved filename to center
                },
                lualine_x = {
                    {
                        function()
                            return " "
                        end,
                    }, -- invisible space, acts as filler
                },
                lualine_y = { lspStatus },
                lualine_z = {},
            }),
        })
    end,
}
