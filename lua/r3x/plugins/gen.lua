return {
    "nomnivore/ollama.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    -- Sample keybind for prompting. Note that the <c-u> is important for selections to work properly.
    keys = {
        {
            "<leader>gn",
            ":<c-u>lua require('ollama').prompt()<cr>",
            desc = "ollama prompt",
            mode = { "n", "v" },
        },
    },

    ---@type Ollama.Config
    opts = {
        -- your configuration overrides
        --model = "codellama",
        model = "qwen2.5-coder:1.5b",
    },
}
