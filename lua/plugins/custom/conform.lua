return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { "stylua" }
        }
    },
    keys = {
        {
            "<leader>f",
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
