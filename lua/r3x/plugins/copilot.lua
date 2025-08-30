return {
    "nrupatunga/copilot.lua",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "giuxtaposition/blink-cmp-copilot",
    },
    config = function()
        require("copilot").setup({ suggestion = { enabled = false }, panel = { enabled = false } })
    end,
}
