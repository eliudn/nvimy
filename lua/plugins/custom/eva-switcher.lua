-- ══════════════════════════════════════════════════════════════════════
-- EVA THEME SWITCHER
-- Registra el comando :EVA y los keymaps <leader>u0/1/2/c
-- Se carga después de cyberdream (priority < 1000) para poder
-- sobreescribir el colorscheme con la preferencia guardada.
-- ══════════════════════════════════════════════════════════════════════
return {
    name     = "eva-switcher",
    dir      = vim.fn.stdpath("config"),   -- plugin local sin repo externo
    lazy     = false,
    priority = 800,

    config = function()
        local eva = require("eva")

        -- ── Comando :EVA <unit> ────────────────────────────────
        -- Uso: :EVA 00 | :EVA 01 | :EVA 02 | :EVA cp
        vim.api.nvim_create_user_command("EVA", function(args)
            local map = {
                ["00"] = "eva-00",
                ["01"] = "eva-01",
                ["02"] = "eva-02",
                ["cp"] = "cyberdream",
            }
            local scheme = map[args.args]
            if not scheme then
                vim.notify(
                    "EVA: usa :EVA 00 | 01 | 02 | cp",
                    vim.log.levels.WARN
                )
                return
            end
            vim.cmd("colorscheme " .. scheme)
            eva.save(scheme)
        end, {
            nargs = 1,
            complete = function()
                return { "00", "01", "02", "cp" }
            end,
            desc = "Cambiar tema EVA (00/01/02) o Cyberpunk (cp)",
        })

        -- ── Keymaps  <leader>u + unidad (UI / tema) ──────────
        local function switch(scheme)
            return function()
                vim.cmd("colorscheme " .. scheme)
                eva.save(scheme)
                local labels = {
                    ["eva-00"]    = "EVA-00 ■ Rei  (azul)",
                    ["eva-01"]    = "EVA-01 ■ Shinji (púrpura)",
                    ["eva-02"]    = "EVA-02 ■ Asuka (rojo)",
                    ["cyberdream"] = "Cyberpunk",
                }
                vim.notify(labels[scheme] or scheme, vim.log.levels.INFO)
            end
        end

        vim.keymap.set("n", "<leader>u0", switch("eva-00"),    { desc = "Tema EVA-00 (Rei / azul)" })
        vim.keymap.set("n", "<leader>u1", switch("eva-01"),    { desc = "Tema EVA-01 (Shinji / púrpura)" })
        vim.keymap.set("n", "<leader>u2", switch("eva-02"),    { desc = "Tema EVA-02 (Asuka / rojo)" })
        vim.keymap.set("n", "<leader>uc", switch("cyberdream"), { desc = "Tema Cyberpunk" })

        -- ── Restaurar preferencia guardada ────────────────────
        -- (cyberdream ya se aplicó con priority=1000; aquí lo sobreescribimos
        --  solo si el usuario eligió un tema EVA en la sesión anterior)
        local saved = eva.load()
        if saved and saved ~= "cyberdream" then
            vim.cmd("colorscheme " .. saved)
        end
    end,
}
