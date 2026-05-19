return {
    -- nvim-navic: proveedor de contexto LSP para el winbar
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        init = function()
            vim.g.navic_silence = true
        end,
        opts = {
            separator = "  ",
            highlight = true,
            depth_limit = 6,
            lazy_update_context = true, -- updates en CursorHold, no en cada CursorMoved
            lsp = {
                auto_attach = true,
                preference = nil,
            },
        },
    },

    -- barbecue: renderiza el winbar con contexto de navic
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        event = "LspAttach",
        opts = {
            create_autocmd = false, -- deshabilitamos los autocmds internos
            attach_navic = true,   -- navic usa auto_attach propio
            show_dirname = false,
            show_basename = true,
            show_navic = true,
            theme = "auto",
            modifiers = {
                dirname  = ":~:.",
                basename = "",
            },
            symbols = {
                modified  = "●",
                ellipsis  = "…",
                separator = "",
            },
        },
        config = function(_, opts)
            require("barbecue").setup(opts)

            -- Eventos mínimos: no CursorMoved, solo cuando realmente cambia el contexto
            vim.api.nvim_create_autocmd({
                "BufWinEnter",
                "CursorHold",
                "InsertLeave",
                "BufWritePost",
                "LspAttach",
            }, {
                group = vim.api.nvim_create_augroup("barbecue_lazy", { clear = true }),
                callback = function()
                    require("barbecue.ui").update()
                end,
            })
        end,
    },
}
