# Repository Guidelines

## Project Structure & Modules
- `init.lua`: Entry point; loads `r3x.options`, `r3x.keymaps`, `r3x.lazy`, sets colors and UI highlights.
- `options.lua`: Core Neovim options.
- `keymaps.lua`: Global keymaps (`vim.keymap.set`), leader mappings, UX tweaks.
- `handlers.lua`: LSP/diagnostic UI, autocommands, inlay hints, yank highlight.
- `lazy.lua`: Plugin manager bootstrap/config (lazy.nvim).
- `plugins/`: One file per plugin or feature (e.g., `lsp.lua`, `treesitter.lua`, `telescope.lua`, `lualine.lua`). Keep configs small and focused.

## Develop, Build, Test
- Run locally: `nvim` (this config loads automatically under `lua/r3x`).
- Live-reload a Lua file: `:luafile %` (or `:so %`).
- Plugins: `:Lazy sync` (install/update), `:Lazy check`, `:Lazy log`.
- Health checks: `:checkhealth` (core/plugins). LSP status: `:LspInfo`.
- Headless sanity load: `nvim --headless '+lua require("r3x") print("OK")' +q`.

## Coding Style & Naming
- Lua, 2-space indentation, no tabs. Prefer `local` everywhere.
- File naming: `snake_case.lua` in `plugins/`; module path `r3x.<name>`.
- Keep side effects in `init.lua`; modules should return a table or define functions clearly.
- Keymaps: use `vim.keymap.set` with `desc` and `{ silent = true, noremap = true }`.
- Follow existing patterns in sibling files; keep configs minimal and composable.

## Testing Guidelines
- Manual smoke tests: open files for common languages; verify Treesitter, LSP, formatting, and UI.
- Validate diagnostics/hover/signature popups and yank highlight behavior.
- For plugin edits, test with `:Lazy reload <name>` and check `:messages` for errors.

## Commit & Pull Requests
- Commits: imperative mood, concise scope prefix. Examples: `options: tune indent settings`, `plugins/lsp: add inlay hints`, `keymaps: refine telescope bindings`.
- PRs: clear description, before/after notes or screenshots for UI, linked issues, testing notes, and any migration steps.

## Security & Configuration Tips
- Do not commit secrets or API tokens; read from environment when needed.
- Keep feature configs isolated in `plugins/` to reduce startup impact and ease review.
