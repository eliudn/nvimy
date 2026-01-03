-- Notificación visual al formatear

local augroup = vim.api.nvim_create_augroup("ConformNotify", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = augroup,
    pattern = "ConformFormatted", -- Evento que lanza conform.nvim al terminar
    callback = function()
        print("test conform")
        -- Usamos la función notify directamente con sus opciones
        ---@module 'snacks'
        Snacks.notify("Código formateado correctamente", {
            level = "info", -- 'info', 'warn', 'error', 'debug', 'trace'
            icon = "󰉼 ",
            title = "Conform",
        })
    end,
})
