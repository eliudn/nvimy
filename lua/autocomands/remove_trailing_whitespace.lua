-- remover espacio en blancos
vim.api.nvim_create_autocmd("BufWritePre",{
  desc = "remove trailing whitespace",
  command = ":%s/\\s\\+$//e",
})
