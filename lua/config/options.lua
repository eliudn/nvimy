
vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.mouse = ""
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.errorbells = false
vim.o.wrap = true
vim.o.swapfile = false
-- vi.mca queo.undofile = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.colorcolumn = "80"
vim.o.termguicolors = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4
vim.o.showmode = false
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
vim.o.conceallevel = 1
vim.o.cmdheight = 0

-- Performance
vim.opt.updatetime = 250  -- Más rápido para autocomandos
vim.opt.timeoutlen = 300  -- Mapeos más rápidos
vim.opt.redrawtime = 1500 -- Para syntax highlighting
vim.opt.ttimeoutlen = 10  -- Salir de modos más rápido

vim.opt.laststatus = 3
vim.opt.smoothscroll = true
-- vim.opt.splitkeepalt = "screen"
-- Búsqueda mejorada
vim.opt.inccommand = "split" -- Preview de sustituciones

local cache_dir = vim.fn.stdpath("cache")

vim.opt.undofile = true
vim.opt.undodir = cache_dir .. "/undo//"
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000

-- Backup
vim.opt.backup = false
vim.opt.writebackup = false
vim.g.vimtex_view_method = "zathura"

-- Socket RPC para MCP server (Claude Code puede conectarse via mcp-neovim-server)
-- pcall para que instancias adicionales no lancen error si /tmp/nvim ya está ocupado
pcall(vim.fn.serverstart, "/tmp/nvim")

-- -- Atrapa cualquier cambio a laststatus y lo restaura a 3 salvo en dashboards.
-- local _ls_disabled = { snacks_dashboard = true, dashboard = true, alpha = true }
-- vim.api.nvim_create_autocmd("OptionSet", {
--     pattern = "laststatus",
--     callback = function()
--         if not _ls_disabled[vim.bo.filetype] and tonumber(vim.v.option_new) ~= 3 then
--             vim.schedule(function() vim.o.laststatus = 3 end)
--         end
--     end,
-- })
-- -- WinEnter cubre el caso de ventanas donde laststatus ya estaba mal antes de cambiar.
-- vim.api.nvim_create_autocmd("WinEnter", {
--     callback = function()
--         if not _ls_disabled[vim.bo.filetype] then
--             vim.schedule(function()
--                 vim.schedule(function()
--                     if vim.o.laststatus ~= 3 then vim.o.laststatus = 3 end
--                 end)
--             end)
--         end
--     end,
-- })

-- nvim-ufo maneja los folds (LSP → indent como fallback, sin treesitter)
vim.opt.foldmethod     = "expr"
vim.opt.foldexpr       = "0"   -- ufo sobreescribe esto en BufReadPost
vim.opt.foldcolumn     = "auto:1"
vim.opt.foldenable     = true
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
