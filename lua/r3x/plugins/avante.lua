return {
    "yetone/avante.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = false,
    opts = {
        provider = "copilot",
        cursor_applying_provider = "copilot",
        behaviour = {
            enable_cursor_planning_mode = true,
        },
        providers = {
            openai = {
                model = "gpt-4o",
            },
        },
        windows = {
            width = 40,
            sidebar_header = {
                enabled = true,
                align = "center",
                rounded = true,
            },
            border = "single",
        },
        mappings = {
            ask = "<leader>w",
            toggle = {
                default = "<leader>w",
            },
            submit = {
                normal = "<CR>",
                insert = "<CR>",
            },
        },
    },
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
                keys = {
                    -- suggested keymap
                    { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
