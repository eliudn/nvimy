-- venv-selector: detecta entornos virtuales y actualiza el path del LSP.
-- Sin este plugin, basedpyright usa el Python del sistema y no resuelve
-- los imports del proyecto (Flask, Django, etc. aparecerían como "no encontrados").
--
-- Por qué "regexp" branch fue la default: resolvió todos los edge cases de detección
-- de Poetry, Pipenv, Conda y uv que el branch original manejaba con código adhoc.
return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
    },
    ft = { "python" },
    opts = {
        -- Busca venvs en el directorio del proyecto y en los padres
        search = true,
        parents = 2,
        -- Nombres de carpeta de venv más comunes
        name = { "venv", ".venv", "env", ".env" },
        -- Detecta también Poetry y uv automáticamente
        auto_refresh = true,
        -- Notifica al cambiar de venv para confirmar que el LSP se actualizó
        notify_user_on_venv_activation = true,
    },
    keys = {
        { "<leader>pv", "<cmd>VenvSelect<cr>",        desc = "Python: Seleccionar venv" },
        { "<leader>pc", "<cmd>VenvSelectCached<cr>",  desc = "Python: Venv anterior" },
    },
}
