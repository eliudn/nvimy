-- remover espacio en blancos
local trim_group = vim.api.nvim_create_augroup("TrimWhiteSpaceGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = trim_group,
    desc = "remove trailing whitespace",
    callback = function()
        if not vim.bo.binary and vim.bo.buftype == "" then
            local curr_view = vim.fn.winsaveview()
            vim.cmd([[silent! %s/\s\+$//e]])
            vim.fn.winrestview(curr_view)
        end
    end,
    -- command = ":%s/\\s\\+$//e",
})
