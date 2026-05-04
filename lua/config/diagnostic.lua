local severity = vim.diagnostic.severity
local icons = {
    [severity.ERROR] = "󰅚",
    [severity.WARN]  = "󰀪",
    [severity.INFO]  = "󰋽",
    [severity.HINT]  = "󰌶",
}
local sign_define = vim.fn.sign_define
sign_define("DiagnosticSignError", { text = "󰅚 ", texthl = "DiagnosticSignError" })
sign_define("DiagnosticSignWarn", { text = "󰀪 ", texthl = "DiagnosticSignWarn" })
sign_define("DiagnosticSignInfo", { text = "󰋽 ", texthl = "DiagnosticSignInfo" })
sign_define("DiagnosticSignHint", { text = "󰌶 ", texthl = "DiagnosticSignHint" })
vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = function(diagnostic)
            return icons[diagnostic.severity] or "●"
        end,
        format = function(diagnostic)
            local msg = diagnostic.message
            if #msg > 60 then
                return msg:sub(1, 57) .. "..."
            end
            return msg
        end
    },
    virtual_lines = false,
    -- virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = function(diagnostic)
            return icons[diagnostic.severity] .. " ", ""
        end
    },
    signs = {
        text = {
            [severity.ERROR] = "󰅚 ",
            [severity.WARN] = "󰀪 ",
            [severity.INFO] = "󰋽 ",
            [severity.HINT] = "󰌶 ",
        },
        numhl = {
            [severity.ERROR] = "ErrorMsg",
            [severity.WARN] = "WarningMsg",
        },
    },
})
_G.DiagnosticToggleLines = function()
    local config = vim.diagnostic.config()
    if config.virtual_lines then
        vim.diagnostic.config({
            virtual_lines = false,
            virtual_text  = {
                spacing = 2,
                source  = "if_many",
                prefix  = function(d) return icons[d.severity] or "●" end,
                format  = function(d)
                    local msg = d.message
                    return #msg > 60 and msg:sub(1, 57) .. "..." or msg
                end,
            },
        })
        vim.notify("Diagnósticos: compacto", vim.log.levels.INFO, { title = "LSP" })
    else
        vim.diagnostic.config({
            virtual_lines = true,
            virtual_text  = false,
        })
        vim.notify("Diagnósticos: detalle completo", vim.log.levels.INFO, { title = "LSP" })
    end
end
