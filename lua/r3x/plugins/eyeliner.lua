return {
    "jinh0/eyeliner.nvim",
    config = function()
        require("eyeliner").setup({
            highlight_on_key = true, -- show highlights only after keypress
            dim = false, -- dim all other characters if set to true (recommended!)
        })
    end,
}
