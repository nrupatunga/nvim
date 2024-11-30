return {
    "nyngwang/NeoZoom.lua",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    dependencies = { "nyngwang/NeoNoName.lua" }, -- this is only required if you want the `keymap` below.
    config = function()
        require("neo-zoom").setup({
            exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
            exclude_buftypes = { "terminal" },
            winopts = {
                offset = {
                    -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
                    top = 0,
                    left = 0.25,
                    width = 170,
                    height = 0.95,
                },
                -- NOTE: check :help nvim_open_win() for possible border values.
                border = "thicc", -- this is a preset, try it :)
            },
        })
        vim.keymap.set("n", "<leader>z", function()
            vim.cmd("NeoZoomToggle")
        end, { silent = true, nowait = true })
    end,
}
