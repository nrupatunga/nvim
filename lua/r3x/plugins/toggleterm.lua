function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

return {
    "akinsho/toggleterm.nvim",
    event = "BufReadPre",
    opts = {
        size = 15,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        vim.cmd("autocmd! TermOpen term://* lua _G.set_terminal_keymaps()")

        -- Set up lazygit inside a toggleterm instance
        local Terminal = require("toggleterm.terminal").Terminal

        function _LAZYGIT_TOGGLE()
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, dir = vim.fn.getcwd() })
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

        function _HTOP_TOGGLE()
            local htop = Terminal:new({ cmd = "htop", hidden = true, dir = vim.fn.getcwd() })
            htop:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>ht", "<cmd>lua _HTOP_TOGGLE()<CR>", { noremap = true, silent = true })

        function _IPYTHON_TOGGLE()
            local python = Terminal:new({ cmd = "ipython", hidden = true, dir = vim.fn.getcwd() })
            python:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>lua _IPYTHON_TOGGLE()<CR>", { noremap = true, silent = true })
    end,
}
