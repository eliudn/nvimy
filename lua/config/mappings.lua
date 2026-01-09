local map = vim.keymap.set

-- map("n", "<leader>w", "<CMD>w<cr>", { noremap = true, desc="Save" })
-- map("n", "<leader>q", "<cmd>q<cr>", { noremap = true, desc="Quit"})
-- map("n", "<leader>x", "<cmd>x<cr>", { noremap = true , desc="No se"})

map("i", "<C-h>", "<Left>", { noremap = true })
map("i", "<C-j>", "<Down>", { noremap = true })
map("i", "<C-k>", "<Up>", { noremap = true })
map("i", "<C-l>", "<Right>", { noremap = true })

-- vim.keymap.set("t", "<leader><esc>", "", {noremap= true})
-- lua/config/keymaps.lua (agregar a tu archivo actual)


-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Better paste (no sobreescribe registro)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Quick save and quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Split windows
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- Buffers
-- map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
-- map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete other buffers" })

-- Quickfix
-- map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
-- map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })

-- Diagnostic
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
-- map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Better command line
map("c", "<C-a>", "<Home>", { desc = "Go to beginning" })
map("c", "<C-e>", "<End>", { desc = "Go to end" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Increment/decrement
-- map("n", "+", "<C-a>", { desc = "Increment" })
-- map("n", "-", "<C-x>", { desc = "Decrement" })

-- New file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- Copy file path
map("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify("Copied path: " .. path)
end, { desc = "Copy file path" })

-- Copy file name
map("n", "<leader>yn", function()
    local name = vim.fn.expand("%:t")
    vim.fn.setreg("+", name)
    vim.notify("Copied name: " .. name)
end, { desc = "Copy file name" })
