_G.MyFoldText = function()
    local startline = vim.v.foldstart
    local line = vim.api.nvim_buf_get_lines(0, startline - 1, startline, false)[1]

    -- Limpiar la línea: quitar whitespace inicial
    line = line:gsub("^%s+", "")

    local linecount = vim.v.foldend - vim.v.foldstart + 1
    local suffix = string.format("  ···  %d lines ", linecount)

    -- Calcular padding para alinear el contador a la derecha
    local width = vim.api.nvim_win_get_width(0)
    local padding = width - #line - #suffix - vim.o.foldcolumn - vim.o.numberwidth
    if padding < 1 then padding = 1 end

    return line .. string.rep(" ", padding) .. suffix
end

vim.g.mapleader = " "
vim.g.maplocalleader = "'"

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

-- Foldado con indent (foldexpr de treesitter causaba crashes con blade/injections)
vim.opt.foldmethod = "indent"
-- vim.opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.MyFoldText"
vim.opt.foldcolumn = "1"
vim.opt.foldenable = false  -- zi para activar/desactivar
vim.opt.foldlevel  = 99     -- no colapsar nada al abrir
