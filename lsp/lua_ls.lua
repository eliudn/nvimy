---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".git",
    },
       settings = {
        Lua = {
            runtime = {
                version = "LuaJIT", -- Optimizado para Neovim
            },
            diagnostics = {
                -- 1. SOLUCIÓN A TUS DUDAS: Desactivar undefined-doc-name
                -- disable = { "undefined-doc-name", "missing-fields" },
                globals = { "vim" }, -- Evita avisos de variables globales desconocidas
            },
            workspace = {
                checkThirdParty = false,
                -- 2. RENDIMIENTO: Carga solo lo necesario
                library = {
                    -- vim.env.VIMRUNTIME,
                    -- Agrega aquí rutas específicas si usas librerías externas
                },
            },
            completion = {
                callSnippet = "Replace",
            },
            telemetry = { enable = false },
            -- Mantenemos tus Inlay Hints de la config anterior
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
            },
        },
    },
}
