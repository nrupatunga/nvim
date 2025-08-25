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
    -- Added recommendations
    { "folke/tokyonight.nvim", lazy = true },
    { "nyoom-engineering/oxocarbon.nvim", lazy = true },
    { "catppuccin/nvim", name = "catppuccin", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = true },
    { "sainnhe/gruvbox-material", lazy = true },
    { "marko-cerovac/material.nvim", lazy = true },
    { "rose-pine/neovim", name = "rose-pine", lazy = true },
    { "AlexvZyl/nordic.nvim", lazy = true },
    { "Shatur/neovim-ayu", lazy = true },
}
