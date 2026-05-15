return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
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
            "<c-f>",
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
