-- ══════════════════════════════════════════════════════════════════════
-- EVA THEMES — Neon Genesis Evangelion
-- Generador de paletas para las tres unidades EVA.
-- Uso: require("eva").apply("eva-00" | "eva-01" | "eva-02")
-- ══════════════════════════════════════════════════════════════════════
local M = {}

-- ── PALETAS ──────────────────────────────────────────────────────────

M.palettes = {

    -- ────────────────────────────────────────────────────────────────
    -- EVA UNIT-00  •  Rei Ayanami  •  Prototipo azul-eléctrico
    -- Cuerpo azul metálico, franjas de advertencia amarillas, estética NERV
    -- ────────────────────────────────────────────────────────────────
    ["eva-00"] = {
        bg      = "#010b19", -- azul-negro profundo
        bg1     = "#021428", -- fondo de paneles/floats
        bg2     = "#052040", -- cursor line / selección
        bg3     = "#0a3060", -- visual / hover
        fg      = "#c8e4ff", -- texto principal (azul pálido)
        fg_dim  = "#3d5a70", -- comentarios

        kw      = "#00b4ff", -- keywords: azul eléctrico (cuerpo EVA)
        kw_fn   = "#00e5e5", -- keyword.function: cian NERV
        fn      = "#4499ff", -- funciones: azul-azure
        fn_call = "#7ab8ff", -- llamadas: azure claro
        teal    = "#00ccbb", -- métodos/propiedades
        teal_b  = "#44ffe8", -- llamadas a métodos (más brillante)
        type    = "#00e87a", -- tipos: verde terminal NERV
        type_b  = "#88ffaa", -- tipos builtin: lima
        string  = "#f5c400", -- strings: amarillo peligro
        number  = "#ffaa33", -- números: ámbar
        bool_   = "#ff8844", -- booleanos: naranja
        const   = "#ff8844", -- constantes: naranja
        param   = "#ff88bb", -- parámetros: rosa
        op      = "#7755ff", -- operadores: púrpura (campo AT)
        delim   = "#1e3a55", -- delimitadores: azul oscuro
        module  = "#88ffaa", -- módulos: lima
        tag     = "#ff4466", -- tags HTML: rojo
        special = "#ff88bb", -- especiales: rosa

        red     = "#ff4466",
        orange  = "#ff8844",
        yellow  = "#f5c400",
        green   = "#00e87a",
        blue    = "#00b4ff",
        purple  = "#7755ff",
        magenta = "#cc44ff",
        cyan    = "#00e5e5",
        pink    = "#ff88bb",
    },

    -- ────────────────────────────────────────────────────────────────
    -- EVA UNIT-01  •  Shinji Ikari  •  Tipo de prueba púrpura-verde
    -- Cuerpo púrpura oscuro, detalles verde neón, energía primordial
    -- ────────────────────────────────────────────────────────────────
    ["eva-01"] = {
        bg      = "#080012", -- negro-púrpura profundo
        bg1     = "#11001e", -- paneles
        bg2     = "#1e0035", -- cursor line
        bg3     = "#2d0050", -- visual
        fg      = "#e8e0ff", -- texto: violeta pálido
        fg_dim  = "#4a3066", -- comentarios

        kw      = "#be5eff", -- keywords: púrpura eléctrico (cuerpo EVA)
        kw_fn   = "#ff22bb", -- keyword.function: magenta caliente
        fn      = "#00ffcc", -- funciones: cian (contraste frío)
        fn_call = "#00ddb3", -- llamadas: teal
        teal    = "#00ddaa", -- métodos
        teal_b  = "#55ffcc", -- llamadas a métodos
        type    = "#39ff14", -- tipos: verde neón (acento EVA-01)
        type_b  = "#aaff55", -- tipos builtin: lima
        string  = "#ffe055", -- strings: amarillo cálido
        number  = "#ff9900", -- números: ámbar
        bool_   = "#ff6600", -- booleanos: naranja
        const   = "#ff6600", -- constantes: naranja
        param   = "#ff88cc", -- parámetros: rosa
        op      = "#5599ff", -- operadores: azul
        delim   = "#3a2255", -- delimitadores: púrpura oscuro
        module  = "#aaff55", -- módulos: lima
        tag     = "#ff4455", -- tags HTML: rojo
        special = "#ff88cc", -- especiales: rosa

        red     = "#ff4455",
        orange  = "#ff6600",
        yellow  = "#ffe055",
        green   = "#39ff14",
        blue    = "#5599ff",
        purple  = "#be5eff",
        magenta = "#ff22bb",
        cyan    = "#00ffcc",
        pink    = "#ff88cc",
    },

    -- ────────────────────────────────────────────────────────────────
    -- EVA UNIT-02  •  Asuka Langley  •  Modelo de producción carmesí
    -- Cuerpo rojo sangre, paneles naranjas, guerrera feroz
    -- ────────────────────────────────────────────────────────────────
    ["eva-02"] = {
        bg      = "#140000", -- negro carmesí profundo
        bg1     = "#200005", -- paneles
        bg2     = "#300008", -- cursor line
        bg3     = "#440010", -- visual
        fg      = "#ffe8dc", -- texto: blanco cálido
        fg_dim  = "#6a3030", -- comentarios

        kw      = "#ff2200", -- keywords: carmesí (cuerpo EVA)
        kw_fn   = "#ff6600", -- keyword.function: naranja (paneles)
        fn      = "#66aaff", -- funciones: azul frío (contraste)
        fn_call = "#00ccff", -- llamadas: cian
        teal    = "#00bbaa", -- métodos
        teal_b  = "#44eedd", -- llamadas a métodos
        type    = "#aadd55", -- tipos: lima (legible sobre rojo)
        type_b  = "#ccff77", -- tipos builtin: lima brillante
        string  = "#ffdd22", -- strings: amarillo brillante
        number  = "#ffaa00", -- números: ámbar
        bool_   = "#ff8844", -- booleanos: naranja-ámbar
        const   = "#ff8844", -- constantes
        param   = "#ff88aa", -- parámetros: rosa
        op      = "#cc44ff", -- operadores: púrpura (campo AT)
        delim   = "#4a2020", -- delimitadores: rojo oscuro
        module  = "#00bbaa", -- módulos: teal (destaca sobre rojo)
        tag     = "#ff5533", -- tags HTML: coral
        special = "#ff88aa", -- especiales: rosa

        red     = "#ff2200",
        orange  = "#ff6600",
        yellow  = "#ffdd22",
        green   = "#44cc77",
        blue    = "#66aaff",
        purple  = "#cc44ff",
        magenta = "#ff2288",
        cyan    = "#00ccff",
        pink    = "#ff88aa",
    },
}

-- ── GENERADOR DE HIGHLIGHTS ──────────────────────────────────────────

function M.apply(name)
    local p = M.palettes[name]
    if not p then
        vim.notify("EVA: paleta '" .. name .. "' no encontrada", vim.log.levels.ERROR)
        return
    end

    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
    vim.g.colors_name = name
    vim.o.background  = "dark"

    local function hl(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Terminal (0-15)
    vim.g.terminal_color_0  = p.bg
    vim.g.terminal_color_1  = p.red
    vim.g.terminal_color_2  = p.green
    vim.g.terminal_color_3  = p.yellow
    vim.g.terminal_color_4  = p.blue
    vim.g.terminal_color_5  = p.magenta
    vim.g.terminal_color_6  = p.cyan
    vim.g.terminal_color_7  = p.fg
    vim.g.terminal_color_8  = p.fg_dim
    vim.g.terminal_color_9  = p.red
    vim.g.terminal_color_10 = p.type_b
    vim.g.terminal_color_11 = p.string
    vim.g.terminal_color_12 = p.fn
    vim.g.terminal_color_13 = p.purple
    vim.g.terminal_color_14 = p.teal
    vim.g.terminal_color_15 = p.fg

    -- ── UI BASE ───────────────────────────────────────────────
    hl("Normal", { fg = p.fg, bg = p.bg })
    hl("NormalNC", { fg = p.fg, bg = p.bg })
    hl("NormalFloat", { fg = p.fg, bg = p.bg1 })
    hl("FloatBorder", { fg = p.cyan, bg = p.bg1 })
    hl("FloatTitle", { fg = p.cyan, bg = p.bg1, bold = true })
    hl("EndOfBuffer", { fg = p.delim, bg = p.bg })
    hl("CursorLine", { bg = p.bg2 })
    hl("CursorLineNr", { fg = p.kw, bold = true })
    hl("Cursor", { fg = p.bg, bg = p.fg })
    hl("CursorIM", { fg = p.bg, bg = p.fg })
    hl("LineNr", { fg = p.delim })
    hl("SignColumn", { fg = p.delim, bg = p.bg })
    hl("ColorColumn", { bg = p.bg1 })
    hl("WinSeparator", { fg = p.delim })
    hl("VertSplit", { fg = p.delim })
    hl("FoldColumn", { fg = p.delim, bg = p.bg })
    hl("Folded", { fg = p.fg_dim, bg = p.bg1, italic = true })
    hl("Conceal", { fg = p.delim })
    hl("NonText", { fg = p.delim })
    hl("SpecialKey", { fg = p.delim })
    hl("Whitespace", { fg = p.delim })
    hl("Directory", { fg = p.blue, bold = true })
    hl("Title", { fg = p.kw, bold = true })
    hl("Question", { fg = p.green })
    hl("MoreMsg", { fg = p.cyan })
    hl("ModeMsg", { fg = p.fg, bold = true })
    hl("ErrorMsg", { fg = p.red, bold = true })
    hl("WarningMsg", { fg = p.yellow, bold = true })

    -- ── STATUSLINE ────────────────────────────────────────────
    hl("StatusLine", { fg = p.fg, bg = p.bg1 })
    hl("StatusLineNC", { fg = p.fg_dim, bg = p.bg1 })

    -- ── TABLINE ──────────────────────────────────────────────
    hl("TabLine", { fg = p.fg_dim, bg = p.bg1 })
    hl("TabLineSel", { fg = p.kw, bg = p.bg, bold = true })
    hl("TabLineFill", { bg = p.bg })

    -- ── SYNTAX BASE ───────────────────────────────────────────
    hl("Comment", { fg = p.fg_dim, italic = true })
    hl("String", { fg = p.string })
    hl("Character", { fg = p.string })
    hl("Number", { fg = p.number })
    hl("Float", { fg = p.number })
    hl("Boolean", { fg = p.bool_, bold = true })
    hl("Constant", { fg = p.const, bold = true })
    hl("Function", { fg = p.fn })
    hl("Identifier", { fg = p.fg })
    hl("Statement", { fg = p.kw, bold = true })
    hl("Keyword", { fg = p.kw, bold = true })
    hl("Conditional", { fg = p.kw, bold = true })
    hl("Repeat", { fg = p.kw, bold = true })
    hl("Label", { fg = p.tag })
    hl("Operator", { fg = p.op })
    hl("Exception", { fg = p.red, bold = true })
    hl("Include", { fg = p.fn, italic = true })
    hl("Define", { fg = p.magenta })
    hl("Macro", { fg = p.magenta })
    hl("PreProc", { fg = p.magenta })
    hl("PreCondit", { fg = p.magenta })
    hl("Type", { fg = p.type })
    hl("StorageClass", { fg = p.kw_fn })
    hl("Structure", { fg = p.type, bold = true })
    hl("Typedef", { fg = p.type })
    hl("Special", { fg = p.special })
    hl("SpecialChar", { fg = p.green })
    hl("Tag", { fg = p.tag })
    hl("Delimiter", { fg = p.delim })
    hl("SpecialComment", { fg = p.fg_dim, italic = true })
    hl("Debug", { fg = p.orange })
    hl("Underlined", { underline = true })
    hl("Ignore", { fg = p.delim })
    hl("Error", { fg = p.red, bold = true })
    hl("Todo", { fg = p.yellow, bold = true })

    -- ── TREESITTER — KEYWORDS ─────────────────────────────────
    hl("@keyword", { fg = p.kw, bold = true })
    hl("@keyword.function", { fg = p.kw_fn, bold = true })
    hl("@keyword.return", { fg = p.red, bold = true })
    hl("@keyword.operator", { fg = p.op })
    hl("@keyword.import", { fg = p.fn, italic = true })
    hl("@keyword.exception", { fg = p.red, bold = true })
    hl("@keyword.conditional", { fg = p.kw, bold = true })
    hl("@keyword.repeat", { fg = p.kw, bold = true })
    hl("@keyword.coroutine", { fg = p.kw_fn, italic = true })
    hl("@keyword.modifier", { fg = p.kw, italic = true })
    hl("@keyword.type", { fg = p.type, bold = true })
    hl("@keyword.debug", { fg = p.orange, bold = true })
    hl("@keyword.directive", { fg = p.magenta })

    -- ── TREESITTER — FUNCIONES ────────────────────────────────
    hl("@function", { fg = p.fn })
    hl("@function.call", { fg = p.fn_call })
    hl("@function.method", { fg = p.teal })
    hl("@function.method.call", { fg = p.teal_b })
    hl("@function.builtin", { fg = p.kw_fn })
    hl("@function.macro", { fg = p.magenta })

    -- ── TREESITTER — VARIABLES ────────────────────────────────
    hl("@variable", { fg = p.fg })
    hl("@variable.builtin", { fg = p.orange, italic = true })
    hl("@variable.parameter", { fg = p.param })
    hl("@variable.parameter.builtin", { fg = p.red, italic = true })
    hl("@variable.member", { fg = p.teal })

    -- ── TREESITTER — TIPOS ────────────────────────────────────
    hl("@type", { fg = p.type })
    hl("@type.builtin", { fg = p.type_b })
    hl("@type.definition", { fg = p.type, bold = true })
    hl("@type.qualifier", { fg = p.kw_fn })

    -- ── TREESITTER — CONSTANTES ───────────────────────────────
    hl("@constant", { fg = p.const, bold = true })
    hl("@constant.builtin", { fg = p.const, bold = true, italic = true })
    hl("@constant.macro", { fg = p.magenta, bold = true })

    -- ── TREESITTER — STRINGS ──────────────────────────────────
    hl("@string", { fg = p.string })
    hl("@string.escape", { fg = p.green })
    hl("@string.special", { fg = p.green })
    hl("@string.special.symbol", { fg = p.special })
    hl("@string.regexp", { fg = p.special })
    hl("@string.documentation", { fg = p.fg_dim, italic = true })

    -- ── TREESITTER — NÚMEROS Y OPERADORES ─────────────────────
    hl("@number", { fg = p.number })
    hl("@number.float", { fg = p.number })
    hl("@boolean", { fg = p.bool_, bold = true })
    hl("@operator", { fg = p.op })
    hl("@character", { fg = p.string })
    hl("@character.special", { fg = p.green })

    -- ── TREESITTER — PUNTUACIÓN ───────────────────────────────
    hl("@punctuation.bracket", { fg = p.cyan })
    hl("@punctuation.delimiter", { fg = p.delim })
    hl("@punctuation.special", { fg = p.special })

    -- ── TREESITTER — MÓDULOS ──────────────────────────────────
    hl("@module", { fg = p.module, italic = true })
    hl("@module.builtin", { fg = p.module })
    hl("@namespace", { fg = p.module, italic = true })

    -- ── TREESITTER — TAGS HTML/JSX ────────────────────────────
    hl("@tag", { fg = p.tag })
    hl("@tag.builtin", { fg = p.tag })
    hl("@tag.attribute", { fg = p.string })
    hl("@tag.delimiter", { fg = p.op })

    -- ── TREESITTER — COMENTARIOS ──────────────────────────────
    hl("@comment", { fg = p.fg_dim, italic = true })
    hl("@comment.documentation", { fg = p.fg_dim, italic = true })
    hl("@comment.error", { fg = p.red, bold = true })
    hl("@comment.warning", { fg = p.yellow, bold = true })
    hl("@comment.todo", { fg = p.yellow, bold = true })
    hl("@comment.note", { fg = p.cyan, bold = true })

    -- ── TREESITTER — VARIOS ───────────────────────────────────
    hl("@attribute", { fg = p.magenta, italic = true })
    hl("@attribute.builtin", { fg = p.magenta })
    hl("@constructor", { fg = p.type })
    hl("@property", { fg = p.teal })
    hl("@label", { fg = p.tag })

    -- ── LSP SEMANTIC HIGHLIGHTS ───────────────────────────────
    hl("@lsp.type.class", { fg = p.type, bold = true })
    hl("@lsp.type.enum", { fg = p.type })
    hl("@lsp.type.enumMember", { fg = p.const })
    hl("@lsp.type.function", { fg = p.fn })
    hl("@lsp.type.interface", { fg = p.type_b })
    hl("@lsp.type.keyword", { fg = p.kw, bold = true })
    hl("@lsp.type.method", { fg = p.teal })
    hl("@lsp.type.namespace", { fg = p.module, italic = true })
    hl("@lsp.type.parameter", { fg = p.param })
    hl("@lsp.type.property", { fg = p.teal })
    hl("@lsp.type.struct", { fg = p.type, bold = true })
    hl("@lsp.type.type", { fg = p.type })
    hl("@lsp.type.typeParameter", { fg = p.type_b })
    hl("@lsp.type.variable", { fg = p.fg })
    hl("@lsp.type.macro", { fg = p.magenta })
    hl("@lsp.type.decorator", { fg = p.magenta, italic = true })
    hl("@lsp.type.builtinType", { fg = p.type_b })
    hl("@lsp.type.lifetime", { fg = p.red, italic = true })
    hl("@lsp.type.selfKeyword", { fg = p.red, italic = true })
    hl("@lsp.type.selfParameter", { fg = p.red, italic = true })
    hl("@lsp.type.comment", { fg = p.fg_dim, italic = true })
    hl("@lsp.typemod.function.async", { fg = p.fn, italic = true })
    hl("@lsp.typemod.method.async", { fg = p.teal, italic = true })
    hl("@lsp.typemod.variable.readonly", { fg = p.const })
    hl("@lsp.typemod.variable.defaultLibrary", { fg = p.const, italic = true })
    hl("@lsp.typemod.function.defaultLibrary", { fg = p.kw_fn })
    hl("@lsp.typemod.type.defaultLibrary", { fg = p.type_b })
    hl("@lsp.typemod.variable.injected", { fg = p.fg })
    hl("@lsp.typemod.function.injected", { fg = p.fn })

    -- ── DIAGNÓSTICOS ──────────────────────────────────────────
    hl("DiagnosticError", { fg = p.red })
    hl("DiagnosticWarn", { fg = p.yellow })
    hl("DiagnosticInfo", { fg = p.blue })
    hl("DiagnosticHint", { fg = p.teal })
    hl("DiagnosticVirtualTextError", { fg = p.red, bg = p.bg1, italic = true })
    hl("DiagnosticVirtualTextWarn", { fg = p.yellow, bg = p.bg1, italic = true })
    hl("DiagnosticVirtualTextInfo", { fg = p.blue, bg = p.bg1, italic = true })
    hl("DiagnosticVirtualTextHint", { fg = p.teal, bg = p.bg1, italic = true })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = p.red })
    hl("DiagnosticUnderlineWarn", { undercurl = true, sp = p.yellow })
    hl("DiagnosticUnderlineInfo", { undercurl = true, sp = p.blue })
    hl("DiagnosticUnderlineHint", { undercurl = true, sp = p.teal })

    -- ── GIT ───────────────────────────────────────────────────
    hl("GitSignsAdd", { fg = p.green })
    hl("GitSignsChange", { fg = p.yellow })
    hl("GitSignsDelete", { fg = p.red })
    hl("DiffAdd", { fg = p.green, bg = p.bg2 })
    hl("DiffChange", { bg = p.bg1 })
    hl("DiffDelete", { fg = p.red })
    hl("DiffText", { fg = p.yellow, bg = p.bg2 })

    -- ── BÚSQUEDA Y SELECCIÓN ──────────────────────────────────
    hl("Search", { fg = p.bg, bg = p.yellow, bold = true })
    hl("IncSearch", { fg = p.bg, bg = p.kw, bold = true })
    hl("CurSearch", { fg = p.bg, bg = p.magenta, bold = true })
    hl("Visual", { bg = p.bg3 })
    hl("VisualNOS", { bg = p.bg3 })
    hl("MatchParen", { fg = p.kw, bg = p.bg3, bold = true })
    hl("Substitute", { fg = p.bg, bg = p.orange, bold = true })

    -- ── PMENU / COMPLETADO ────────────────────────────────────
    hl("Pmenu", { fg = p.fg, bg = p.bg1 })
    hl("PmenuSel", { fg = p.bg, bg = p.kw, bold = true })
    hl("PmenuSbar", { bg = p.bg2 })
    hl("PmenuThumb", { bg = p.purple })
    hl("PmenuExtra", { fg = p.fg_dim })
    hl("PmenuExtraSel", { fg = p.bg, bg = p.kw })

    -- ── BLINK.CMP ─────────────────────────────────────────────
    hl("BlinkCmpMenu", { fg = p.fg, bg = p.bg1 })
    hl("BlinkCmpMenuBorder", { fg = p.cyan, bg = p.bg1 })
    hl("BlinkCmpMenuSelection", { fg = p.bg, bg = p.kw, bold = true })
    hl("BlinkCmpScrollBarThumb", { bg = p.purple })
    hl("BlinkCmpScrollBarGutter", { bg = p.bg1 })
    hl("BlinkCmpLabel", { fg = p.fg })
    hl("BlinkCmpLabelMatch", { fg = p.kw, bold = true })
    hl("BlinkCmpKindFunction", { fg = p.fn })
    hl("BlinkCmpKindMethod", { fg = p.teal })
    hl("BlinkCmpKindConstructor", { fg = p.type })
    hl("BlinkCmpKindKeyword", { fg = p.kw })
    hl("BlinkCmpKindVariable", { fg = p.fg })
    hl("BlinkCmpKindConstant", { fg = p.const })
    hl("BlinkCmpKindModule", { fg = p.module })
    hl("BlinkCmpKindStruct", { fg = p.type })
    hl("BlinkCmpKindClass", { fg = p.type })
    hl("BlinkCmpKindInterface", { fg = p.type_b })
    hl("BlinkCmpKindEnum", { fg = p.type })
    hl("BlinkCmpKindEnumMember", { fg = p.const })
    hl("BlinkCmpKindField", { fg = p.teal })
    hl("BlinkCmpKindProperty", { fg = p.teal })
    hl("BlinkCmpKindText", { fg = p.fg_dim })
    hl("BlinkCmpKindSnippet", { fg = p.special })
    hl("BlinkCmpKindFile", { fg = p.fn })
    hl("BlinkCmpKindFolder", { fg = p.fn })
    hl("BlinkCmpKindColor", { fg = p.special })
    hl("BlinkCmpKindReference", { fg = p.red })
    hl("BlinkCmpKindOperator", { fg = p.op })
    hl("BlinkCmpKindTypeParameter", { fg = p.type_b })

    -- ── TELESCOPE ─────────────────────────────────────────────
    hl("TelescopeBorder", { fg = p.kw })
    hl("TelescopePromptBorder", { fg = p.kw_fn })
    hl("TelescopeResultsBorder", { fg = p.fn })
    hl("TelescopePreviewBorder", { fg = p.type })
    hl("TelescopePromptPrefix", { fg = p.kw })
    hl("TelescopeSelectionCaret", { fg = p.kw_fn })
    hl("TelescopeSelection", { bg = p.bg2 })
    hl("TelescopeMatching", { fg = p.kw, bold = true })
    hl("TelescopeNormal", { fg = p.fg, bg = p.bg1 })
    hl("TelescopePromptNormal", { fg = p.fg, bg = p.bg1 })
    hl("TelescopeResultsNormal", { fg = p.fg, bg = p.bg1 })
    hl("TelescopePreviewNormal", { fg = p.fg, bg = p.bg1 })

    -- ── NOTIFY ────────────────────────────────────────────────
    hl("NotifyERRORBorder", { fg = p.red })
    hl("NotifyWARNBorder", { fg = p.yellow })
    hl("NotifyINFOBorder", { fg = p.blue })
    hl("NotifyDEBUGBorder", { fg = p.fg_dim })
    hl("NotifyTRACEBorder", { fg = p.purple })
    hl("NotifyERRORIcon", { fg = p.red })
    hl("NotifyWARNIcon", { fg = p.yellow })
    hl("NotifyINFOIcon", { fg = p.blue })
    hl("NotifyERRORTitle", { fg = p.red, bold = true })
    hl("NotifyWARNTitle", { fg = p.yellow, bold = true })
    hl("NotifyINFOTitle", { fg = p.blue, bold = true })

    -- ── WHICH-KEY ─────────────────────────────────────────────
    hl("WhichKey", { fg = p.kw })
    hl("WhichKeyGroup", { fg = p.kw_fn, bold = true })
    hl("WhichKeyDesc", { fg = p.fg })
    hl("WhichKeySeparator", { fg = p.delim })
    hl("WhichKeyBorder", { fg = p.delim, bg = p.bg1 })
    hl("WhichKeyNormal", { bg = p.bg1 })
    hl("WhichKeyValue", { fg = p.fg_dim })

    -- ── TREESITTER CONTEXT ────────────────────────────────────
    hl("TreesitterContext", { bg = p.bg1 })
    hl("TreesitterContextLineNumber", { fg = p.fg_dim, bg = p.bg1 })

    -- ── SNACKS DASHBOARD ──────────────────────────────────────
    hl("SnacksDashboardHeader", { fg = p.kw, bold = true })
    hl("SnacksDashboardKey", { fg = p.string, bold = true })
    hl("SnacksDashboardDesc", { fg = p.fg })
    hl("SnacksDashboardIcon", { fg = p.fn })
    hl("SnacksDashboardFooter", { fg = p.fg_dim, italic = true })
    hl("SnacksDashboardSpecial", { fg = p.kw_fn })

    -- ── WINBAR / BARBECUE ─────────────────────────────────────
    hl("WinBar",                     { fg = p.fg_dim,  bg = p.bg })
    hl("WinBarNC",                   { fg = p.fg_dim,  bg = p.bg })
    hl("NavicText",                  { fg = p.fg_dim,  bg = p.bg })
    hl("NavicSeparator",             { fg = p.delim,   bg = p.bg })
    -- Tipos de símbolos LSP
    hl("NavicIconsFile",             { fg = p.fn,      bg = p.bg })
    hl("NavicIconsModule",           { fg = p.module,  bg = p.bg })
    hl("NavicIconsNamespace",        { fg = p.module,  bg = p.bg })
    hl("NavicIconsPackage",          { fg = p.module,  bg = p.bg })
    hl("NavicIconsClass",            { fg = p.type,    bg = p.bg })
    hl("NavicIconsMethod",           { fg = p.fn,      bg = p.bg })
    hl("NavicIconsProperty",         { fg = p.teal,    bg = p.bg })
    hl("NavicIconsField",            { fg = p.teal,    bg = p.bg })
    hl("NavicIconsConstructor",      { fg = p.fn,      bg = p.bg })
    hl("NavicIconsEnum",             { fg = p.type,    bg = p.bg })
    hl("NavicIconsInterface",        { fg = p.type,    bg = p.bg })
    hl("NavicIconsFunction",         { fg = p.fn,      bg = p.bg })
    hl("NavicIconsVariable",         { fg = p.fg,      bg = p.bg })
    hl("NavicIconsConstant",         { fg = p.const,   bg = p.bg })
    hl("NavicIconsString",           { fg = p.string,  bg = p.bg })
    hl("NavicIconsNumber",           { fg = p.number,  bg = p.bg })
    hl("NavicIconsBoolean",          { fg = p.bool_,   bg = p.bg })
    hl("NavicIconsArray",            { fg = p.kw,      bg = p.bg })
    hl("NavicIconsObject",           { fg = p.kw,      bg = p.bg })
    hl("NavicIconsKey",              { fg = p.kw,      bg = p.bg })
    hl("NavicIconsNull",             { fg = p.fg_dim,  bg = p.bg })
    hl("NavicIconsEnumMember",       { fg = p.const,   bg = p.bg })
    hl("NavicIconsStruct",           { fg = p.type,    bg = p.bg })
    hl("NavicIconsEvent",            { fg = p.special, bg = p.bg })
    hl("NavicIconsOperator",         { fg = p.op,      bg = p.bg })
    hl("NavicIconsTypeParameter",    { fg = p.param,   bg = p.bg })
end

-- ── PERSISTENCIA ─────────────────────────────────────────────────────

function M.save(name)
    local path = vim.fn.stdpath("data") .. "/eva_theme"
    local f = io.open(path, "w")
    if f then
        f:write(name); f:close()
    end
end

function M.load()
    local path = vim.fn.stdpath("data") .. "/eva_theme"
    local f = io.open(path, "r")
    if f then
        local name = f:read("*l")
        f:close()
        if name and name ~= "" then return name end
    end
    return nil
end

return M
