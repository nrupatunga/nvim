return {
    -- Active colorscheme: load early
    { "nrupatunga/darkplus.nvim", priority = 1000, lazy = false },

    -- Other colorschemes: lazy so they don't impact startup
    { "ChristianChiarulli/onedark.nvim", lazy = true },
    { "nrupatunga/night-owl.nvim", lazy = true },
    { "projekt0n/github-nvim-theme", lazy = true },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "wuelnerdotexe/vim-enfocado", lazy = true },
    { "vague2k/vague.nvim", lazy = true },
    { "morhetz/gruvbox", lazy = true },
}
