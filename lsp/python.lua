---@type vim.lsp.Config
-- basedpyright: type checking + autocompletado
-- Linting de estilo delegado a ruff LSP (lsp/ruff.lua)
-- Formateo delegado a conform.nvim (ruff_format)

local function python_path()
    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    if venv then return venv .. "/bin/python" end
    for _, name in ipairs({ ".venv", "venv", "env", ".env" }) do
        local path = vim.fn.getcwd() .. "/" .. name .. "/bin/python"
        if vim.fn.filereadable(path) == 1 then return path end
    end
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyrightconfig.json",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "uv.lock",
        ".git",
    },
    -- Inyecta pythonPath antes de iniciar el servidor para que resuelva
    -- correctamente los imports del entorno virtual activo.
    before_init = function(_, config)
        config.settings = config.settings or {}
        config.settings.python = { pythonPath = python_path() }
    end,
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                -- "openFilesOnly" es más rápido; "workspace" es más completo
                diagnosticMode = "openFilesOnly",
                -- "standard" cubre la mayoría de proyectos sin ser invasivo
                typeCheckingMode = "standard",
            },
        },
    },
}
