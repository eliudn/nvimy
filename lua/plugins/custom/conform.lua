return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            -- Ruff reemplaza black + isort: un solo binario, criterios consistentes.
            -- ruff_organize_imports primero: ordena imports antes de formatear el resto.
            python           = { "ruff_organize_imports", "ruff_format" },
            lua              = { "stylua" },
            php              = { "php_cs_fixer" },
            blade            = { "blade_formatter" },
            vue              = { "prettier" },
            javascript       = { "prettier" },
            typescript       = { "prettier" },
            javascriptreact  = { "prettier" },
            typescriptreact  = { "prettier" },
            json             = { "prettier" },
            jsonc            = { "prettier" },
            css              = { "prettier" },
            html             = { "prettier" },
            markdown         = { "prettier" },
        },
        format_on_save = function (bufnr)
            if vim.b[bufnr].autoformat == false then return end
            return { timeout_ms = 500, lsp_fallback = true}

        end
    },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true },
                    function()
                        vim.api.nvim_exec_autocmds("User", {
                            pattern = "ConformFormatted",
                        })
                    end
                )
            end,
            mode = "",
            desc = "Formatear buffer",
        },
    },
}
