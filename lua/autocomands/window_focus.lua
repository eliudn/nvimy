local group = vim.api.nvim_create_augroup("WindowFocus", { clear = true })

vim.api.nvim_create_autocmd("WinLeave", {
    group = group,
    callback = function()
        vim.wo.winhighlight = "Normal:NormalNC,CursorLine:NormalNC"
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
        vim.wo.winhighlight = ""
    end,
})
