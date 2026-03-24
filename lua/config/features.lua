return {
    lsp = {
        lua_ls     = true,
        phpactor   = true,
        ts_ls      = false,  -- desactivado: vtsls cubre JS/TS/Vue sin conflictos
        vue_ls     = true,
        vtsls      = true,
        emmet      = true,
        tailwindcss = true,  -- habilitado: detecta proyectos por tailwind.config.*
        eslint     = true,   -- habilitado: fix automático al guardar
        texlab     = true,
    }
}
