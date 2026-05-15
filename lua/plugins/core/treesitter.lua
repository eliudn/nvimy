return { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    event = {"BufReadPre", "BufNewFile"},
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    branch = "master",
    config = function()
        require("nvim-treesitter.install").prefer_git = true

        -- Patch: Neovim 0.12.1 bug — languagetree.lua:901 llama get_range con nodo nil/stale
        -- en injection queries (markdown, html, php, vue). Wrapper defensivo sobre la API pública.
        local orig_get_range = vim.treesitter.get_range
        vim.treesitter.get_range = function(node, source, metadata)
            if not node or not node.range then
                return { 0, 0, 0, 0, 0, 0 }
            end
            return orig_get_range(node, source, metadata)
        end

        -- nvim-treesitter archivado (abr-2026); usamos solo para instalación de parsers,
        -- indent y textobjects. Highlight migrado a API nativa de Neovim 0.12.
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "vim",
                "vimdoc",
                "php",
                "phpdoc",
                "blade",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "vue",
                "sql",
                "graphql",
                "regex",
                "jsdoc",
                "json",
                "json5",
            },
            auto_install = true,

            -- Highlight desactivado en nvim-treesitter.configs: conflicto con Neovim 0.12.
            -- El módulo highlight de nvim-treesitter genera nodos nil en languagetree.lua:215
            -- al procesar injection queries (blade, markdown, html). Neovim 0.12 gestiona
            -- highlighting nativamente via vim.treesitter.start() — ver autocmd abajo.
            highlight = { enable = false },

            indent = { enable = true, disable = { "ruby", "blade" } },

            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                    },
                },
            },
        })

        -- Highlighting nativo Neovim 0.12 con pcall (evita crash en parsers con injections)
        -- blade excluido: injection queries PHP/HTML generan nodos nil en v0.12.1
        local ts_disabled = { blade = true }
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(e)
                local lang = vim.bo[e.buf].filetype
                if ts_disabled[lang] then
                    pcall(vim.treesitter.stop, e.buf)
                    return
                end
                pcall(vim.treesitter.start, e.buf)
            end,
        })

        vim.filetype.add({
            pattern = {
                [".*%.blade%.php"] = {
                    function(_, bufnr)
                        local firstLine = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
                        if vim.startswith(firstLine, "<?php") then
                            return "php"
                        end
                        return "blade"
                    end,
                    { priority = math.huge, name = "blade" },
                },
            },
        })
    end,
}
