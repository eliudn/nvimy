---@type vim.lsp.Config
-- ruff LSP: solo diagnosticos de linting
-- El formateo (ruff format) lo maneja conform.nvim para evitar doble paso.
-- Si ruff formateara también vía LSP, conform correría encima y se duplicaría el trabajo.
return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "ruff.toml",
        ".ruff.toml",
        ".git",
    },
    init_options = {
        settings = {
            logLevel = "error",
        },
    },
    -- Desactiva el proveedor de formateo del LSP:
    -- conform.nvim invoca ruff CLI directamente, más predecible y configurable.
    on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
