vim.keymap.set("n", "<leader>w", "<CMD>w<cr>", { noremap = true, desc="Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, desc="Quit"})
vim.keymap.set("n", "<leader>x", "<cmd>x<cr>", { noremap = true , desc="No se"})

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })

-- vim.keymap.set("t", "<leader><esc>", "", {noremap= true})
