return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "NvimTreeToggle" },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>" , desc = 'NvimTree toggle'},
    },
    opts = {
        view = {
            adaptive_size = true,
            width = 30,
            number = false,
            side = "right",
            relativenumber = false,
            signcolumn = "no",
            hide_root_folder = false,
            mappings = {
                list = {
                    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                    { key = "<C-e>", action = "edit_in_place" },
                    { key = { "O" }, action = "edit_no_picker" },
                    { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
                    { key = "<C-v>", action = "vsplit" },
                    { key = "<C-x>", action = "split" },
                    { key = "<C-t>", action = "tabnew", silent = "true" },
                    { key = "<", action = "prev_sibling" },
                    { key = ">", action = "next_sibling" },
                    { key = "P", action = "parent_node" },
                    { key = "<BS>", action = "close_node" },
                    { key = "<Tab>", action = "preview" },
                    { key = "K", action = "first_sibling" },
                    { key = "J", action = "last_sibling" },
                    { key = "I", action = "toggle_git_ignored" },
                    { key = "h", action = "toggle_dotfiles" }, --
                    { key = "R", action = "refresh" },
                    { key = "a", action = "create" },
                    { key = "d", action = "remove" },
                    { key = "D", action = "trash" },
                    { key = "r", action = "rename" },
                    { key = "<C-r>", action = "full_rename" },
                    { key = "x", action = "cut" },
                    { key = "c", action = "copy" },
                    { key = "p", action = "paste" },
                    { key = "y", action = "copy_name" },
                    { key = "Y", action = "copy_path" },
                    { key = "gy", action = "copy_absolute_path" },
                    { key = "[c", action = "prev_git_item" },
                    { key = "]c", action = "next_git_item" },
                    { key = "-", action = "dir_up" },
                    { key = "s", action = "system_open" },
                    { key = "q", action = "close" },
                    { key = "g?", action = "toggle_help" },
                    { key = "W", action = "collapse_all" },
                    { key = "S", action = "search_node" },
                    { key = "<C-k>", action = "toggle_file_info" },
                    { key = ".", action = "run_file_command" },
                },
            },
            float = {
                enable = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 120,
                    height = 35,
                    row = 5,
                    col = 85,
                },
            },
        },

        update_focused_file = {
            enable = true,
            update_cwd = true,
        },

        renderer = {
            root_folder_modifier = ":t",
            indent_markers = {
                enable = true,
            },
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "S",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
            special_files = {
                "Cargo.toml",
                "Makefile",
                "README.md",
                "go.mod",
            },
        },
        filters = {
            dotfiles = true,
            custom = { "node_modules" },
        },
        actions = {
            use_system_clipboard = true,
        },
        modified = {
            enable = true,
        },
        diagnostics = {
            enable = true,
            show_on_dirs = false,
            debounce_delay = 450,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
    },
}
