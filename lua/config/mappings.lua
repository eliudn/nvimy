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
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("i", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Windows
map("n", "<leader>ws", "<C-W>s",  { desc = "Split horizontal" })
map("n", "<leader>wv", "<C-W>v",  { desc = "Split vertical" })
map("n", "<leader>wd", "<C-W>c",  { desc = "Close window" })
map("n", "<leader>we", "<C-W>=",  { desc = "Equalizar ventanas" })
map("n", "<leader>ww", "<C-W>w",  { desc = "Siguiente ventana" })
map("n", "<leader>wH", "<C-W>H",  { desc = "Mover ventana izquierda" })
map("n", "<leader>wJ", "<C-W>J",  { desc = "Mover ventana abajo" })
map("n", "<leader>wK", "<C-W>K",  { desc = "Mover ventana arriba" })
map("n", "<leader>wL", "<C-W>L",  { desc = "Mover ventana derecha" })
-- atajos rápidos mantenidos
map("n", "<leader>-",  "<C-W>s",  { desc = "Split horizontal" })
map("n", "<leader>|",  "<C-W>v",  { desc = "Split vertical" })

-- Buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Alternate buffer" })
map("n", "<leader>bd", function() Snacks.bufdelete() end,       { desc = "Delete buffer" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })

-- Tabs
map("n", "<leader><tab>n", "<cmd>tabnew<cr>",      { desc = "New tab" })
map("n", "<leader><tab>c", "<cmd>tabclose<cr>",    { desc = "Close tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>",     { desc = "Next tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Prev tab" })

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

-- Testing (neotest)
-- map("n", "<leader>tr", function() require("neotest").run.run() end,                             { desc = "Test: Run nearest" })
-- map("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,           { desc = "Test: Run file" })
-- map("n", "<leader>ts", function() require("neotest").run.stop() end,                            { desc = "Test: Stop" })
-- map("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end,         { desc = "Test: Output" })
-- map("n", "<leader>tO", function() require("neotest").output_panel.toggle() end,                 { desc = "Test: Panel toggle" })
-- map("n", "<leader>tS", function() require("neotest").summary.toggle() end,                      { desc = "Test: Summary toggle" })

vim.keymap.set("n", "<leader>md", _G.DiagnosticToggleLines,
    { desc = "Toggle diagnósticos detalle" })

vim.keymap.set("n", "gl", vim.diagnostic.open_float,
    { desc = "Float diagnóstico línea actual" })

vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist,
    { desc = "Diagnósticos → quickfix list" })
