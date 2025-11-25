return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",

        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = { "Telescope" },
    keys = {},
    config = function()
        local scope = require("telescope")
        local tactions = require("telescope.actions")
        local trouble = require("trouble.sources.telescope")
        require("telescope").load_extension("live_grep_args")
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopeResults",
            callback = function(ctx)
                vim.api.nvim_buf_call(ctx.buf, function()
                    vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                    vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                end)
            end,
        })

        local function filenameFirst(_, path)
            local tail = vim.fs.basename(path)
            local parent = vim.fs.dirname(path)
            if parent == "." then
                return tail
            end
            return string.format("%s\t\t%s", tail, parent)
        end
        scope.load_extension("fzf")
        scope.setup({
            defaults = {
                file_ignore_patterns = {
                    "%.git$",
                    "%.git[/\\]",
                    "node_modules",
                    "target",
                    "build",
                    "ios",
                    "android",
                    "linux",
                    "macos",
                    "web",
                    "windows",
                    "%.lock$",
                },
                color_devicons = true,
                selection_caret = "󰁕 ",
                prompt_prefix = " ",
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        ["<Tab>"] = tactions.move_selection_next,
                        ["<S-Tab>"] = tactions.move_selection_previous,
                        ["<esc>"] = tactions.close,
                        ["<c-t>"] = trouble.open,
                    },
                    n = {
                        ["<esc>"] = tactions.close,
                        ["dd"] = "delete_buffer",
                        ["<c-t>"] = trouble.open,
                    },
                },
                layout_config = {
                    height = 0.90,
                    width = 0.80,
                    preview_cutoff = 0,
                    horizontal = { preview_width = 0.60 },
                    vertical = { width = 0.55, height = 0.9, preview_cutoff = 0 },
                    prompt_position = "top",
                },
                path_display = { "smart", shorten = { len = 3 } },
                dynamic_preview_title = true,
                wrap_results = true,
            },
            pickers = {
                find_files = {
                    path_display = filenameFirst,
                    hidden = true,
                    prompt_prefix = "  ",
                    find_command = { "fd", "-H" },
                },
                git_files = {
                    path_display = filenameFirst,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
                colorscheme = {
                    enable_preview = true,
                },
            },
        })
    end,
}
