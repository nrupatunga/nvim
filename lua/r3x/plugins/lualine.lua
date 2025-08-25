return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
        -- Smart branch shortener: strip common prefixes and shorten long names
        local function shorten_branch(name)
            if not name or name == "" then
                return ""
            end
            name = name:gsub("^refs/heads/", ""):gsub("^origin/", "")
            name = name:gsub("^(feature|feat|bugfix|fix|hotfix|chore|refactor|release)/", "")
            local max = 20
            if #name <= max then
                return name
            end
            local last = name:match(".*/([^/]+)$")
            if last and #last <= max then
                return "…/" .. last
            end
            return name:sub(1, 12) .. "…" .. name:sub(-7)
        end

        -- LSP status (preserved behavior): show attached client name or fallback
        local lsp_status_comp = {
            function()
                local msg = "No LSP"
                local ft = vim.bo.filetype
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local fts = client.config and client.config.filetypes
                    if (not fts) or vim.tbl_contains(fts, ft) then
                        return client.name
                    end
                end
                return msg
            end,
            icon = " ",
        }

        local function setup_lualine()
            -- Build a uniform theme that uses the command-mode palette for all modes
            local theme_opt = "auto"
            do
                local ok, auto_theme = pcall(require, "lualine.themes.auto")
                local base = nil
                if ok then
                    if type(auto_theme) == "table" then
                        base = auto_theme
                    elseif type(auto_theme) == "function" then
                        -- some versions export a function that returns the theme
                        pcall(function()
                            base = auto_theme()
                        end)
                    end
                end
                if base and type(base) == "table" and base.command then
                    theme_opt = {
                        normal  = base.command,
                        insert  = base.command,
                        visual  = base.command,
                        replace = base.command,
                        command = base.command,
                        inactive = base.inactive or base.normal,
                    }
                end
            end

        -- Pull colors from current highlights to create subtle separation
        local function hl_hex(name, key1, fallback)
            local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
            local val = ok and hl and (hl[key1] or hl[(key1 == 'bg') and 'background' or 'foreground'])
            if type(val) == "number" then
                return string.format("#%06x", val)
            end
            return fallback
        end

        local function darken(hex, factor)
            if not hex or hex:sub(1, 1) ~= "#" then return hex end
            local r = tonumber(hex:sub(2, 3), 16)
            local g = tonumber(hex:sub(4, 5), 16)
            local b = tonumber(hex:sub(6, 7), 16)
            r = math.floor(r * factor)
            g = math.floor(g * factor)
            b = math.floor(b * factor)
            return string.format("#%02x%02x%02x", r, g, b)
        end

        local function lighten(hex, factor)
            if not hex or hex:sub(1, 1) ~= "#" then return hex end
            local r = tonumber(hex:sub(2, 3), 16)
            local g = tonumber(hex:sub(4, 5), 16)
            local b = tonumber(hex:sub(6, 7), 16)
            r = math.floor(r + (255 - r) * factor)
            g = math.floor(g + (255 - g) * factor)
            b = math.floor(b + (255 - b) * factor)
            return string.format("#%02x%02x%02x", r, g, b)
        end

        local function blend(bg_hex, fg_hex, ratio)
            if not (bg_hex and fg_hex) then return bg_hex end
            if bg_hex:sub(1,1) ~= '#' or fg_hex:sub(1,1) ~= '#' then return bg_hex end
            local br = tonumber(bg_hex:sub(2,3),16)
            local bg = tonumber(bg_hex:sub(4,5),16)
            local bb = tonumber(bg_hex:sub(6,7),16)
            local fr = tonumber(fg_hex:sub(2,3),16)
            local fg = tonumber(fg_hex:sub(4,5),16)
            local fb = tonumber(fg_hex:sub(6,7),16)
            local r = math.floor(br * (1-ratio) + fr * ratio)
            local g = math.floor(bg * (1-ratio) + fg * ratio)
            local b = math.floor(bb * (1-ratio) + fb * ratio)
            return string.format("#%02x%02x%02x", r, g, b)
        end

            local bg_active = hl_hex("StatusLine", "bg", "#2b2b2b")
            local bg_alt    = hl_hex("StatusLineNC", "bg", darken(bg_active, 0.85))
            local fg_active = hl_hex("StatusLine", "fg", "#d0d0d0")
            local fg_light  = lighten(fg_active, 0.67) -- requested brightness
            local accent_blue  = hl_hex("Directory", "fg", "#7aa2f7")
            local accent_green = hl_hex("String", "fg", "#9ece6a")
            local subtle_branch_bg  = blend(bg_active, accent_blue, 0.20)
            local subtle_file_bg    = blend(bg_alt,    accent_green, 0.18)

        -- If we built a theme table, apply section-specific backgrounds
            if type(theme_opt) == "table" then
                for _, mode in ipairs({ 'normal', 'insert', 'visual', 'replace', 'command' }) do
                    if theme_opt[mode] then
                        theme_opt[mode].b = theme_opt[mode].b or {}
                        theme_opt[mode].c = theme_opt[mode].c or {}
                        theme_opt[mode].b.bg = bg_active
                        theme_opt[mode].b.fg = fg_light
                        theme_opt[mode].c.bg = bg_alt
                        theme_opt[mode].c.fg = fg_light
                    end
                end
                if theme_opt.inactive then
                    theme_opt.inactive.b = theme_opt.inactive.b or {}
                    theme_opt.inactive.c = theme_opt.inactive.c or {}
                    theme_opt.inactive.b.bg = bg_alt
                    theme_opt.inactive.c.bg = bg_alt
                end
            end

            require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = theme_opt,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = { "alpha", "dashboard", "lazy" },
            },
            sections = {
                -- Minimal: mode letter on the left
                lualine_a = {
                    { "mode", fmt = function(s) return s:sub(1, 1) end, padding = 1 },
                },
                lualine_b = {
                    { "branch", icon = "", fmt = shorten_branch, color = { fg = fg_light, bg = subtle_branch_bg } },
                },
                -- Center: relative filename with modified/readonly symbols
                lualine_c = {
                    {
                        "filename",
                        path = 1, -- relative
                        symbols = { modified = " ●", readonly = " ", unnamed = " [No Name]", newfile = " [New]" },
                        newfile_status = true,
                        color = { fg = fg_light, bg = subtle_file_bg },
                    },
                },
                lualine_x = {},
                lualine_y = { lsp_status_comp },
                -- Right: cursor location
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
            })
        end

        -- Only set up after colorscheme is ready to avoid wrong colors on startup
        if vim.g.colors_name then
            pcall(setup_lualine)
        else
            local grp = vim.api.nvim_create_augroup("LualineSetupOnColorscheme", { clear = true })
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = grp,
                once = true,
                callback = function()
                    pcall(setup_lualine)
                end,
            })
        end
    end,
}
