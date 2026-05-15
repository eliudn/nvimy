vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("my_close_with_q", { clear = true }),
    pattern = {
        "help", "lspinfo", "qf", "notify", "checkhealth",
        "neotest-output", "neotest-summary", "neotest-output-panel",
        "trouble", "man",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf,
            silent = true,
            nowait = true,
        })
    end,
})
