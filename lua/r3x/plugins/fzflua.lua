return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
    end,
    keys = {
        {
            "<leader>S",
            "<cmd>lua require('fzf-lua').grep_cword()<cr>",
            desc = "Find word under cursor",
        },
    },
}
