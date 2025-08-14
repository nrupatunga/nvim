return {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    -- or if you are using nixos
    -- build = "nix run .#release",
    opts = {
        -- pass here all the options
    },
    keys = {
        {
            "ff",
            function()
                require("fff").find_in_git_root() -- or find_in_git_root() if you only want git files
            end,
            desc = "Find files in git root",
        },
    },
}
