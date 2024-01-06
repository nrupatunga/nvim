return {
    "nyngwang/NeoZoom.lua",
    enabled = true,
    dependencies = { "nyngwang/NeoNoName.lua" }, -- this is only required if you want the `keymap` below.
    config = function()
        require("neo-zoom").setup({
            exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },
            exclude_buftypes = { "terminal" },
        })
        vim.keymap.set("n", "<leader>z", function()
            vim.cmd("NeoZoomToggle")
        end, { silent = true, nowait = true })
    end,
}
