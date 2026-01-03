return -- lazy.nvim
{
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            -- Mantenemos las capacidades de LSP
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true, -- barra de búsqueda abajo
            command_palette = true, -- barra de comandos (:) al centro
            long_message_to_split = true,
            inc_rename = false, -- lo manejaremos con Snacks
        },
        -- USAR SNACK PARA NOTIFICACIONES (Muy importante)
        redirect = {
            view = "notify",
            filter = { event = "msg_show" },
        },
    }
}
