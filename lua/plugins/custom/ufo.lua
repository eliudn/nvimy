return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",

    keys = {
        { "zR", function() require("ufo").openAllFolds() end,            desc = "Abrir todos los folds" },
        { "zM", function() require("ufo").closeAllFolds() end,           desc = "Cerrar todos los folds" },
        { "zr", function() require("ufo").openFoldsExceptKinds() end,    desc = "Abrir folds (excepto imports)" },
        { "zm", function() require("ufo").closeFoldsWith() end,          desc = "Cerrar folds por nivel" },
        { "K",  function()
            local ufo = require("ufo")
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover({ border = "rounded" })
            end
        end, desc = "Peek fold / Hover LSP" },
    },

    opts = {
        -- LSP primero, indent como fallback — evita treesitter (crash con blade)
        provider_selector = function()
            return { "lsp", "indent" }
        end,

        -- Preview virtual del contenido plegado al final de la línea
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ("  󰁂 %d líneas"):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0

            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    table.insert(newVirtText, { chunkText, chunk[2] })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if curWidth + chunkWidth < targetWidth then
                        suffix = (" "):rep(targetWidth - curWidth - chunkWidth) .. suffix
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end

            table.insert(newVirtText, { suffix, "UfoFoldedEllipsis" })
            return newVirtText
        end,
    },
}
