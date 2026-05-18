if not vim.env.KITTY_WINDOW_ID then return end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.fn.system("kitty @ set-spacing padding=0")
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    once = true,
    callback = function()
        vim.fn.system("kitty @ set-spacing padding=10")
    end,
})
