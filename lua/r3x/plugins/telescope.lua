return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = { "Telescope find_files" },
    keys = {
        {
            "<leader>f",
            "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
            desc = "Find files",
        },
        {
            "<leader>F",
            "<cmd>lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
            desc = "Find git files",
        },
        {
            "<leader>y",
            "<cmd>lua require'telescope.builtin'.marks(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
            desc = "Shows marks",
        },
        {
            "<leader>t",
            --"<cmd>lua require'telescope.builtin'.lsp_document_symbols(require('telescope.themes').get_dropdown({ previewer = false }), {symbol_width = 200})<cr>",
            "<cmd>lua require'telescope.builtin'.lsp_document_symbols(require('telescope.themes').get_dropdown({ previewer = true, symbol_width=42 }))<cr>",
            desc = "Shows document symbols",
        },
        {
            "<leader>o",
            "<cmd>lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
            desc = "Shows old files opened",
        },
        { "<leader>gr", "<cmd>Telescope live_grep<CR>", desc = "Find texts" },
        { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "List Opened Buffers" },
        { "<leader>T", "<cmd>Telescope treesitter<CR>", desc = "List Treesitter Variables" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
        { "<leader>gt", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
        { "<leader>k", "<cmd>Telescope keymaps<CR>", desc = "List all keymaps" },
    },
    config = function()
        local scope = require("telescope")
        local tactions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")
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
                mappings = {
                    i = {
                        ["<Tab>"] = tactions.move_selection_next,
                        ["<S-Tab>"] = tactions.move_selection_previous,
                        ["<esc>"] = tactions.close,
                        ["<c-t>"] = trouble.open_with_trouble,
                    },
                    n = {
                        ["<esc>"] = tactions.close,
                        ["dd"] = "delete_buffer",
                        ["<c-t>"] = trouble.open_with_trouble,
                    },
                },
                layout_strategy = "vertical",
                --layout_config = { height = 0.95, preview_height = 0.6, preview_cutoff = 0 },
                path_display = { "smart", shorten = { len = 3 } },
                dynamic_preview_title = true,
                wrap_results = true,
            },
            pickers = {
                find_files = { hidden = true },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
        })
    end,
}
