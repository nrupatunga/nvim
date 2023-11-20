local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = "",
        })
    end

    vim.diagnostic.config({
        virtual_text = true,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        --signs = true,
        --underline = true,
        --virtual_text = {
        --spacing = 5,
        --severity_limit = "Hint",
        --},
        --update_in_insert = true,
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.highlight.on_yank({
                higroup = "IncSearch", -- see `:highlight` for more options
                timeout = 200,
            })
        end,
    })

    -- vim.api.nvim_create_user_command("Fmt", function()
    --     vim.lsp.buf.format()
    -- end, {})

    -- format on save
    --vim.api.nvim_create_autocmd("BufWritePre", {
    --   callback = function()
    --        vim.lsp.buf.format()
    --    end,
    -- })

    -- inlay hints
    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require("lsp-inlayhints").on_attach(client, bufnr)
        end,
    })

    vim.cmd([[autocmd FileType * set formatoptions-=ro]])
end

--local signature_cfg = {
--bind = true,
--hint_enable = false,
--floating_window = true,
--floating_window_above_cur_line = true,
--check_completion_visible = true,
--toggle_key = "<M-t>",
--select_signature_key = "<M-s>",
--handler_opts = {
--border = "rounded",
--},
--}

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({timeout_ms = 5000})<cr>", opts)
    keymap(bufnr, "v", "<leader>lf", "<cmd>lua vim.lsp.buf.format({timeout_ms = 5000})<cr>", opts)
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
    keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
    keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap(bufnr, "n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "lua_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "yamlls" then
        client.server_capabilities.documentFormattingProvider = false
    end

    client.server_capabilities.semanticTokensProvider = nil
    lsp_keymaps(bufnr)

    require("illuminate").on_attach(client)
    --require("lsp_signature").on_attach(signature_cfg, bufnr)
    --require("nvim-navbuddy").attach(client, bufnr)
end

return M
