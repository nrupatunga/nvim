# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration written in Lua, organized as a modular plugin system using the `lazy.nvim` plugin manager. The configuration is structured around the `r3x` namespace.

### Core Structure

- **Entry Point**: `init.lua` - Loads options, keymaps, lazy plugin manager, and sets the colorscheme
- **Plugin Management**: Uses `lazy.nvim` with plugins defined in the `plugins/` directory
- **Modular Design**: Each major feature is separated into its own plugin file

### Key Components

1. **Core Configuration Files**:
   - `options.lua` - Vim options and settings, cursor configuration, GUI settings
   - `keymaps.lua` - Custom key mappings with leader key set to comma (`,`)
   - `handlers.lua` - LSP handlers and capabilities
   - `lazy.lua` - Plugin manager setup and configuration

2. **Plugin Architecture**:
   - All plugins are defined in `plugins/` directory
   - Each plugin file returns a table of plugin specifications
   - Uses lazy loading for performance optimization
   - Plugins are automatically imported via `{ import = "r3x.plugins" }`

### Important Settings

- **Leader Key**: Comma (`,`) 
- **Colorscheme**: darkplus (with several alternatives commented out)
- **Auto Root Detection**: Automatically changes directory to project root based on `.git` or `Makefile`
- **LSP**: Uses mason for LSP management with clangd, prettierd, stylua, clang-format

## Common Development Tasks

### Plugin Management

- **Install/Update Plugins**: `<leader>r` or `:Lazy`
- **Plugin Sync**: Handled automatically by lazy.nvim

### File Navigation

- **Find Files**: `<leader>f` (Telescope with dropdown theme)
- **Find Git Files**: `<leader>F`
- **Harpoon Navigation**: Custom `:GoToFile` command mapped to harpoon
- **Live Grep**: `:Grep` command

### LSP Operations

- **Switch Header/Source**: `<leader>hw` (ClangdSwitchSourceHeader)
- **Toggle Diagnostics**: `<leader>D`
- **Document Symbols**: `<leader>t`

### Code Management

- **Search and Replace**: `<leader>sr` (search/replace word under cursor)
- **Copy to System Clipboard**: `<leader>yy`
- **Paste from System Clipboard**: `<leader>pp`
- **Close Buffer**: `<leader>bd`
- **Close All But Current**: `<leader>ba`

## Key Plugin Categories

- **LSP**: mason.nvim, nvim-lspconfig, clang_extensions
- **Fuzzy Finding**: telescope.nvim with fzf-native
- **Navigation**: harpoon, hop
- **UI**: lualine, dressing, notify, themes
- **Completion**: blink.cmp
- **Git**: diffview, blame, octo
- **AI/Copilot**: copilot, avante, gen
- **Editing**: treesitter, autopairs, mini, scissors

## Testing and Linting

No specific test or lint commands are configured in this Neovim setup. This is a personal editor configuration focused on development workflow rather than project-specific tooling.