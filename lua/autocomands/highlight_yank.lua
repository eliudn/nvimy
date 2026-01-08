-- lua/autocomands/highlight_yank.lua
-- coloriar al copiar y cortar (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        (vim.hl or vim.highlight).on_yank({ higroup = "Visual", timeout = 200 })
    end,
    desc = "Highlight on yank",
})
