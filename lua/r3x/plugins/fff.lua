-- fff.nvim: Fast fuzzy file finder with frecency (recent files automatically prioritized)
return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  keys = {
    {
      "<leader>f",
      function()
        require("fff").find_files()
      end,
      desc = "Find files (fff)",
    },
    {
      "<leader>F",
      function()
        require("fff").find_in_git_root()
      end,
      desc = "Find git files (fff)",
    },
  },
  opts = {
    prompt = "  ",
    title = "Files",
    max_results = 100,
    lazy_sync = false, -- Start indexing immediately for faster first search
    layout = {
      height = 0.35,
      width = 0.45,
      prompt_position = "bottom",
      preview_position = "right",
      preview_size = 0.5,
      show_scrollbar = true,
      path_shorten_strategy = "middle_number",
    },
    preview = {
      enabled = false, -- Match fzf-lua style (no preview for files)
      max_size = 10 * 1024 * 1024,
      line_numbers = true,
      wrap_lines = false,
    },
    keymaps = {
      close = "<Esc>",
      select = "<CR>",
      select_split = "<C-s>",
      select_vsplit = "<C-v>",
      select_tab = "<C-t>",
      move_up = { "<Up>", "<C-k>" },
      move_down = { "<Down>", "<C-j>" },
      preview_scroll_up = "<C-u>",
      preview_scroll_down = "<C-d>",
      toggle_select = "<Tab>",
      send_to_quickfix = "<C-q>",
    },
    frecency = {
      enabled = true, -- Track file open frequency for smart sorting
      db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
    },
    history = {
      enabled = true,
      db_path = vim.fn.stdpath("data") .. "/fff_queries",
      min_combo_count = 3,
      combo_boost_score_multiplier = 100,
    },
    git = {
      status_text_color = true, -- Show git status on filenames
    },
    debug = {
      enabled = false,
      show_scores = false,
    },
  },
}
