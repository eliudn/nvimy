-- ══════════════════════════════════════════════════════════════════════
-- TEMA: Cyberpunk  (tema por defecto)
-- Base: cyberdream.nvim — paleta neon nativa, diseño cyberpunk.
--
-- Temas disponibles (ver eva-switcher.lua):
--   <leader>te0  :EVA 00  →  EVA-00  Rei     azul-eléctrico
--   <leader>te1  :EVA 01  →  EVA-01  Shinji  púrpura-neón
--   <leader>te2  :EVA 02  →  EVA-02  Asuka   carmesí-naranja
--   <leader>tec  :EVA cp  →  Cyberpunk (este tema)
--
-- Paleta cyberdream (dark):
--   bg #16181a  fg #ffffff  grey  #7b8496
--   blue   #5ea1ff  green  #5eff6c  cyan    #5ef1ff
--   red    #ff6e5e  yellow #f1ff5e  magenta #ff5ef1
--   pink   #ff5ea0  orange #ffbd5e  purple  #bd5eff
-- ══════════════════════════════════════════════════════════════════════
return {
    "scottmckendry/cyberdream.nvim",
    lazy    = false,
    priority = 1000,
    opts = {
        transparent     = false,
        italic_comments = true,
        terminal_colors = true,
        cache           = true,

        -- Fondo más profundo que el default (#16181a) para mayor contraste neon
        colors = {
            dark = { bg = "#0d0e17" },
        },

        -- API correcta: overrides en nivel raíz (NO dentro de theme = {})
        overrides = function(c)
            -- Colores custom que extienden la paleta base
            local lime = "#c5ff5e"  -- verde-amarillo neon
            local teal = "#5effd7"  -- cian-verde neon

            return {

                -- ── UI BASE ───────────────────────────────────────────────
                NormalFloat    = { fg = c.fg,    bg = "#111222" },
                FloatBorder    = { fg = c.cyan,  bg = "#111222" },
                FloatTitle     = { fg = c.cyan,  bg = "#111222", bold = true },
                CursorLine     = { bg = "#191b2e" },
                CursorLineNr   = { fg = c.cyan,  bold = true },
                LineNr         = { fg = "#3a3d55" },
                SignColumn     = { bg = "#0d0e17" },
                ColorColumn    = { bg = "#181a2e" },
                WinSeparator   = { fg = c.purple },
                FoldColumn     = { fg = "#3a3d55", bg = "#0d0e17" },
                Folded         = { fg = "#5a607a", bg = "#181a2e", italic = true },
                TabLine        = { fg = "#4a5068", bg = "#111222" },
                TabLineSel     = { fg = c.cyan,  bg = "#0d0e17", bold = true },
                TabLineFill    = { bg = "#0d0e17" },

                -- ── SYNTAX STANDARD ──────────────────────────────────────
                Comment        = { fg = "#48506a", italic = true },
                String         = { fg = c.yellow },
                Number         = { fg = c.orange },
                Float          = { fg = c.orange },
                Boolean        = { fg = c.orange, bold = true },
                Character      = { fg = c.yellow },
                Constant       = { fg = c.orange, bold = true },
                Function       = { fg = c.blue },
                Statement      = { fg = c.cyan,    bold = true },
                Keyword        = { fg = c.cyan,    bold = true },
                Conditional    = { fg = c.cyan,    bold = true },
                Repeat         = { fg = c.cyan,    bold = true },
                Label          = { fg = c.red },
                Operator       = { fg = c.purple },
                Exception      = { fg = c.red,     bold = true },
                Include        = { fg = c.blue,    italic = true },
                Define         = { fg = c.magenta },
                Macro          = { fg = c.magenta },
                PreProc        = { fg = c.magenta },
                Type           = { fg = c.green },
                StorageClass   = { fg = c.cyan },
                Structure      = { fg = c.green,   bold = true },
                Typedef        = { fg = c.green },
                Special        = { fg = c.pink },
                SpecialChar    = { fg = c.green },
                Delimiter      = { fg = "#6272a4" },
                Todo           = { fg = c.yellow,  bold = true },

                -- ── TREESITTER — KEYWORDS ─────────────────────────────────
                ["@keyword"]                = { fg = c.cyan,    bold = true },
                ["@keyword.function"]       = { fg = c.magenta, bold = true },
                ["@keyword.return"]         = { fg = c.red,     bold = true },
                ["@keyword.operator"]       = { fg = c.purple },
                ["@keyword.import"]         = { fg = c.blue,    italic = true },
                ["@keyword.exception"]      = { fg = c.red,     bold = true },
                ["@keyword.conditional"]    = { fg = c.cyan,    bold = true },
                ["@keyword.repeat"]         = { fg = c.cyan,    bold = true },
                ["@keyword.coroutine"]      = { fg = c.magenta, italic = true },

                -- ── TREESITTER — FUNCIONES ────────────────────────────────
                ["@function"]               = { fg = c.blue },
                ["@function.call"]          = { fg = "#7bc5ff" },
                ["@function.method"]        = { fg = teal },
                ["@function.method.call"]   = { fg = "#7bffe8" },
                ["@function.builtin"]       = { fg = c.cyan },
                ["@function.macro"]         = { fg = c.magenta },

                -- ── TREESITTER — VARIABLES ────────────────────────────────
                ["@variable"]                       = { fg = c.fg },
                ["@variable.builtin"]               = { fg = c.orange, italic = true },
                ["@variable.parameter"]             = { fg = c.pink },
                ["@variable.parameter.builtin"]     = { fg = c.red,    italic = true },
                ["@variable.member"]                = { fg = teal },

                -- ── TREESITTER — TIPOS ────────────────────────────────────
                ["@type"]                   = { fg = c.green },
                ["@type.builtin"]           = { fg = lime },
                ["@type.definition"]        = { fg = c.green, bold = true },
                ["@type.qualifier"]         = { fg = c.cyan },

                -- ── TREESITTER — CONSTANTES ───────────────────────────────
                ["@constant"]               = { fg = c.orange, bold = true },
                ["@constant.builtin"]       = { fg = c.orange, bold = true, italic = true },
                ["@constant.macro"]         = { fg = c.magenta, bold = true },

                -- ── TREESITTER — STRINGS ──────────────────────────────────
                ["@string"]                 = { fg = c.yellow },
                ["@string.escape"]          = { fg = c.green },
                ["@string.special"]         = { fg = c.green },
                ["@string.special.symbol"]  = { fg = c.pink },
                ["@string.regexp"]          = { fg = c.pink },
                ["@string.documentation"]   = { fg = "#6a7090", italic = true },

                -- ── TREESITTER — NÚMEROS Y OPERADORES ─────────────────────
                ["@number"]                 = { fg = c.orange },
                ["@number.float"]           = { fg = c.orange },
                ["@boolean"]                = { fg = c.orange, bold = true },
                ["@operator"]               = { fg = c.purple },

                -- ── TREESITTER — PUNTUACIÓN ───────────────────────────────
                ["@punctuation.bracket"]    = { fg = "#8090cc" },
                ["@punctuation.delimiter"]  = { fg = "#5a607a" },
                ["@punctuation.special"]    = { fg = c.pink },

                -- ── TREESITTER — MÓDULOS ──────────────────────────────────
                ["@module"]                 = { fg = lime, italic = true },
                ["@module.builtin"]         = { fg = lime },
                ["@namespace"]              = { fg = lime, italic = true },

                -- ── TREESITTER — TAGS HTML/JSX ────────────────────────────
                ["@tag"]                    = { fg = c.red },
                ["@tag.builtin"]            = { fg = c.red },
                ["@tag.attribute"]          = { fg = c.yellow },
                ["@tag.delimiter"]          = { fg = c.purple },

                -- ── TREESITTER — COMENTARIOS ──────────────────────────────
                ["@comment"]                = { fg = "#48506a", italic = true },
                ["@comment.documentation"]  = { fg = "#5a6888", italic = true },
                ["@comment.error"]          = { fg = c.red,    bold = true },
                ["@comment.warning"]        = { fg = c.yellow, bold = true },
                ["@comment.todo"]           = { fg = c.yellow, bold = true },
                ["@comment.note"]           = { fg = c.cyan,   bold = true },

                -- ── TREESITTER — VARIOS ───────────────────────────────────
                ["@attribute"]              = { fg = c.magenta, italic = true },
                ["@attribute.builtin"]      = { fg = c.magenta },
                ["@constructor"]            = { fg = c.green },
                ["@property"]               = { fg = teal },
                ["@label"]                  = { fg = c.red },

                -- ── LSP SEMANTIC HIGHLIGHTS ───────────────────────────────
                ["@lsp.type.class"]             = { fg = c.green,   bold = true },
                ["@lsp.type.enum"]              = { fg = c.green },
                ["@lsp.type.enumMember"]        = { fg = c.orange },
                ["@lsp.type.function"]          = { fg = c.blue },
                ["@lsp.type.interface"]         = { fg = lime },
                ["@lsp.type.keyword"]           = { fg = c.cyan,    bold = true },
                ["@lsp.type.method"]            = { fg = teal },
                ["@lsp.type.namespace"]         = { fg = lime,      italic = true },
                ["@lsp.type.parameter"]         = { fg = c.pink },
                ["@lsp.type.property"]          = { fg = teal },
                ["@lsp.type.struct"]            = { fg = c.green,   bold = true },
                ["@lsp.type.type"]              = { fg = c.green },
                ["@lsp.type.typeParameter"]     = { fg = lime },
                ["@lsp.type.variable"]          = { fg = c.fg },
                ["@lsp.type.macro"]             = { fg = c.magenta },
                ["@lsp.type.decorator"]         = { fg = c.magenta, italic = true },
                ["@lsp.type.builtinType"]       = { fg = lime },
                ["@lsp.type.lifetime"]          = { fg = c.red,     italic = true },
                ["@lsp.type.selfKeyword"]       = { fg = c.red,     italic = true },
                ["@lsp.type.selfParameter"]     = { fg = c.red,     italic = true },
                ["@lsp.type.comment"]           = { fg = "#48506a", italic = true },
                ["@lsp.typemod.function.async"]          = { fg = c.blue,   italic = true },
                ["@lsp.typemod.method.async"]            = { fg = teal,     italic = true },
                ["@lsp.typemod.variable.readonly"]       = { fg = c.orange },
                ["@lsp.typemod.variable.defaultLibrary"] = { fg = c.orange, italic = true },
                ["@lsp.typemod.function.defaultLibrary"] = { fg = c.cyan },
                ["@lsp.typemod.type.defaultLibrary"]     = { fg = lime },
                ["@lsp.typemod.variable.injected"]       = { fg = c.fg },
                ["@lsp.typemod.function.injected"]       = { fg = c.blue },

                -- ── DIAGNÓSTICOS ──────────────────────────────────────────
                DiagnosticError             = { fg = c.red },
                DiagnosticWarn              = { fg = c.yellow },
                DiagnosticInfo              = { fg = c.blue },
                DiagnosticHint              = { fg = teal },
                DiagnosticVirtualTextError  = { fg = c.red,    bg = "#28131a", italic = true },
                DiagnosticVirtualTextWarn   = { fg = c.yellow, bg = "#28220d", italic = true },
                DiagnosticVirtualTextInfo   = { fg = c.blue,   bg = "#0d1828", italic = true },
                DiagnosticVirtualTextHint   = { fg = teal,     bg = "#0d2820", italic = true },
                DiagnosticUnderlineError    = { undercurl = true, sp = c.red },
                DiagnosticUnderlineWarn     = { undercurl = true, sp = c.yellow },
                DiagnosticUnderlineInfo     = { undercurl = true, sp = c.blue },
                DiagnosticUnderlineHint     = { undercurl = true, sp = teal },

                -- ── GIT ───────────────────────────────────────────────────
                GitSignsAdd         = { fg = c.green },
                GitSignsChange      = { fg = c.yellow },
                GitSignsDelete      = { fg = c.red },

                -- ── BÚSQUEDA Y SELECCIÓN ──────────────────────────────────
                Search              = { fg = "#0d0e17", bg = c.yellow,  bold = true },
                IncSearch           = { fg = "#0d0e17", bg = c.cyan,    bold = true },
                CurSearch           = { fg = "#0d0e17", bg = c.magenta, bold = true },
                Visual              = { bg = "#252060" },
                MatchParen          = { fg = c.cyan, bg = "#252060", bold = true },

                -- ── PMENU / COMPLETADO ────────────────────────────────────
                Pmenu               = { fg = c.fg,   bg = "#111222" },
                PmenuSel            = { fg = "#0d0e17", bg = c.cyan, bold = true },
                PmenuSbar           = { bg = "#1a1c30" },
                PmenuThumb          = { bg = c.purple },

                -- ── BLINK.CMP ─────────────────────────────────────────────
                BlinkCmpMenu              = { fg = c.fg,   bg = "#111222" },
                BlinkCmpMenuBorder        = { fg = c.cyan, bg = "#111222" },
                BlinkCmpMenuSelection     = { fg = "#0d0e17", bg = c.cyan, bold = true },
                BlinkCmpScrollBarThumb    = { bg = c.purple },
                BlinkCmpScrollBarGutter   = { bg = "#111222" },
                BlinkCmpLabel             = { fg = c.fg },
                BlinkCmpLabelMatch        = { fg = c.cyan, bold = true },
                BlinkCmpKindFunction      = { fg = c.blue },
                BlinkCmpKindMethod        = { fg = teal },
                BlinkCmpKindConstructor   = { fg = c.green },
                BlinkCmpKindKeyword       = { fg = c.cyan },
                BlinkCmpKindVariable      = { fg = c.fg },
                BlinkCmpKindConstant      = { fg = c.orange },
                BlinkCmpKindModule        = { fg = lime },
                BlinkCmpKindStruct        = { fg = c.green },
                BlinkCmpKindClass         = { fg = c.green },
                BlinkCmpKindInterface     = { fg = lime },
                BlinkCmpKindEnum          = { fg = c.green },
                BlinkCmpKindEnumMember    = { fg = c.orange },
                BlinkCmpKindField         = { fg = teal },
                BlinkCmpKindProperty      = { fg = teal },
                BlinkCmpKindText          = { fg = "#48506a" },
                BlinkCmpKindSnippet       = { fg = c.pink },
                BlinkCmpKindFile          = { fg = c.blue },
                BlinkCmpKindFolder        = { fg = c.blue },
                BlinkCmpKindColor         = { fg = c.pink },
                BlinkCmpKindReference     = { fg = c.red },
                BlinkCmpKindOperator      = { fg = c.purple },
                BlinkCmpKindTypeParameter = { fg = lime },

                -- ── TELESCOPE ─────────────────────────────────────────────
                TelescopeBorder        = { fg = c.cyan },
                TelescopePromptBorder  = { fg = c.magenta },
                TelescopeResultsBorder = { fg = c.blue },
                TelescopePreviewBorder = { fg = c.green },
                TelescopePromptPrefix  = { fg = c.cyan },
                TelescopeSelectionCaret = { fg = c.magenta },
            }
        end,

        extensions = {
            telescope = true,
            notify    = true,
            mini      = true,
            noice     = true,
            trouble   = true,
        },
    },

    config = function(_, opts)
        require("cyberdream").setup(opts)
        vim.cmd("colorscheme cyberdream")
    end,
}
