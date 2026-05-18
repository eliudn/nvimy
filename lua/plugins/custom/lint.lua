return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            php    = { "phpstan" },
            -- Python: sin linter externo — basedpyright cubre type checking y
            -- ruff LSP cubre style/linting en tiempo real. mypy requiere stubs
            -- por proyecto y no escala bien en un laboratorio multi-framework.
        }

        -- Ejecutar linter al guardar y al leer
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                -- Solo lintear si el linter está disponible
                lint.try_lint(nil, { ignore_errors = true })
            end,
        })
    end,
}
