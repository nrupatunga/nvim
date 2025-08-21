return {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    config = function()
        require('fff').setup({
            base_path = vim.fn.getcwd(),
            prompt = '🦁 ',
            title = 'Fast File Finder',
            max_results = 200,
            max_threads = 8,
            layout = {
                height = 0.85,
                width = 0.85,
                prompt_position = 'top',    -- Search bar at top
                preview_position = 'right',
                preview_size = 0.6,  -- Larger preview pane
            },
            preview = {
                enabled = true,
                max_size = 50 * 1024 * 1024,  -- 50MB max file size
                chunk_size = 16384,  -- 16KB chunks for smoother scrolling
                binary_file_threshold = 2048,  -- Better binary detection
                line_numbers = true,  -- Show line numbers in preview
                wrap_lines = false,   -- Keep long lines readable
                show_file_info = true,
                imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit, %b bytes',
                -- Enhanced file-type specific settings
                filetypes = {
                    -- Text/Documentation
                    svg = { wrap_lines = true, line_numbers = false },
                    markdown = { wrap_lines = true, line_numbers = true },
                    text = { wrap_lines = true, line_numbers = true },
                    txt = { wrap_lines = true, line_numbers = true },
                    
                    -- Data formats
                    json = { wrap_lines = false, line_numbers = true },
                    yaml = { wrap_lines = false, line_numbers = true },
                    yml = { wrap_lines = false, line_numbers = true },
                    toml = { wrap_lines = false, line_numbers = true },
                    xml = { wrap_lines = false, line_numbers = true },
                    
                    -- Programming languages
                    lua = { wrap_lines = false, line_numbers = true },
                    python = { wrap_lines = false, line_numbers = true },
                    py = { wrap_lines = false, line_numbers = true },
                    javascript = { wrap_lines = false, line_numbers = true },
                    js = { wrap_lines = false, line_numbers = true },
                    typescript = { wrap_lines = false, line_numbers = true },
                    ts = { wrap_lines = false, line_numbers = true },
                    tsx = { wrap_lines = false, line_numbers = true },
                    jsx = { wrap_lines = false, line_numbers = true },
                    rust = { wrap_lines = false, line_numbers = true },
                    rs = { wrap_lines = false, line_numbers = true },
                    go = { wrap_lines = false, line_numbers = true },
                    c = { wrap_lines = false, line_numbers = true },
                    cpp = { wrap_lines = false, line_numbers = true },
                    cc = { wrap_lines = false, line_numbers = true },
                    cxx = { wrap_lines = false, line_numbers = true },
                    h = { wrap_lines = false, line_numbers = true },
                    hpp = { wrap_lines = false, line_numbers = true },
                    
                    -- Shell/Config
                    sh = { wrap_lines = false, line_numbers = true },
                    bash = { wrap_lines = false, line_numbers = true },
                    zsh = { wrap_lines = false, line_numbers = true },
                    fish = { wrap_lines = false, line_numbers = true },
                    vim = { wrap_lines = false, line_numbers = true },
                    
                    -- Web technologies
                    html = { wrap_lines = false, line_numbers = true },
                    css = { wrap_lines = false, line_numbers = true },
                    scss = { wrap_lines = false, line_numbers = true },
                    sass = { wrap_lines = false, line_numbers = true },
                    
                    -- Logs (wrap for readability)
                    log = { wrap_lines = true, line_numbers = true },
                },
            },
            keymaps = {
                close = '<Esc>',
                select = '<CR>',
                select_split = '<C-s>',
                select_vsplit = '<C-v>',
                select_tab = '<C-t>',
                move_up = { '<Up>', '<C-p>', '<C-k>', '<S-Tab>' },
                move_down = { '<Down>', '<C-n>', '<C-j>', '<Tab>' },
                preview_scroll_up = '<C-u>',
                preview_scroll_down = '<C-d>',
                toggle_debug = '<F2>',
            },
            frecency = {
                enabled = true,
                db_path = vim.fn.stdpath('cache') .. '/fff_nvim',
            },
            debug = {
                enabled = false,
                show_scores = false,
            },
            logging = {
                enabled = true,
                log_file = vim.fn.stdpath('log') .. '/fff.log',
                log_level = 'info',
            },
        })
    end,
    keys = {
        {
            "<leader>f",
            function()
                require("fff").find_files_in_dir(vim.fn.getcwd())
            end,
            desc = "Find files in current directory",
        },
        {
            "<leader>F",
            function()
                require("fff").find_in_git_root()
            end,
            desc = "Find git files",
        },
        --{
            --"<leader>o",
            --function()
                ---- fff.nvim uses frecency for recent files, so we use find_files() with frecency enabled
                --require("fff").find_files()
            --end,
            --desc = "Find recent files (frecency)",
        --},
    },
}
