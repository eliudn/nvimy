# Investigación: NvChad y LazyVim — Lecciones para tu configuración

> Análisis comparativo de arquitectura, herramientas propias, decisiones de diseño
> y puntos aplicables a tu configuración actual.

---

## Índice

1. [Arquitectura general](#1-arquitectura-general)
2. [Lazy loading: la estrategia de rendimiento central](#2-lazy-loading-la-estrategia-de-rendimiento-central)
3. [LSP: configuración y deduplicación](#3-lsp-configuración-y-deduplicación)
4. [Pipeline de formateo](#4-pipeline-de-formateo)
5. [Sistema de temas y UI](#5-sistema-de-temas-y-ui)
6. [Opciones de rendimiento](#6-opciones-de-rendimiento)
7. [Autocomandos organizados](#7-autocomandos-organizados)
8. [Filosofía de keymaps](#8-filosofía-de-keymaps)
9. [Herramientas propias: por qué las construyeron](#9-herramientas-propias-por-qué-las-construyeron)
10. [Estado actual de tu config vs. buenas prácticas](#10-estado-actual-de-tu-config-vs-buenas-prácticas)
11. [Mejoras priorizadas para implementar](#11-mejoras-priorizadas-para-implementar)

---

## 1. Arquitectura general

### LazyVim — Un solo repositorio, sistema de "extras"

```
~/.config/nvim/
  lua/
    config/
      autocmds.lua       ← grupos de autocomandos
      keymaps.lua        ← namespace <leader>*
      lazy.lua           ← bootstrap + spec glob
      options.lua        ← opciones + perf
    plugins/
      *.lua              ← specs descubiertas automáticamente
    lazyvim/
      util/              ← lsp.lua, format.lua, pick.lua, toggle.lua
      plugins/           ← specs incluidas en el paquete base
  init.lua               ← entry point + chequeo de versión
```

**Por qué así:** LazyVim carga todos los archivos `lua/plugins/*.lua` con un glob pattern —
el usuario solo agrega archivos, nunca toca un array central de imports. Los "extras"
son módulos opcionales que el usuario activa en `lazy.nvim`; esto desacopla features
experimentales (none-ls, snacks_picker) del núcleo sin forks.

### NvChad — Dos repositorios separados

```
~/.config/nvim/   ← STARTER (lo que el usuario versiona)
  lua/
    chadrc.lua    ← config específica de NvChad (tema, UI options)
    plugins/      ← plugins custom (git-ignorados)
    mappings.lua  ← keymaps custom
  init.lua

~/.local/share/nvim/lazy/NvChad/   ← CORE (plugin, no lo tocas)
  lua/nvchad/
    plugins/      ← specs predeterminadas
    configs/      ← defaults reutilizables (lspconfig, cmp, etc.)
    utils/        ← utilidades internas
```

**Por qué así:** La separación de starter+core permite a NvChad actualizar el framework
sin romper la customización del usuario. El git-ignore de `lua/plugins/` fuerza que las
personalizaciones sean adiciones puras, no parches al upstream — filosofía "nunca mergear
conflictos".

**¿Qué tienes tú?** Una arquitectura similar a LazyVim: un solo repo, imports explícitos
via `{ import = "plugins.core" }` y `{ import = "plugins.custom" }`. Esto está bien.

---

## 2. Lazy loading: la estrategia de rendimiento central

### La regla de NvChad: 93% de plugins con `lazy = true`

NvChad consigue startups de 20-70ms porque **casi ningún plugin carga al iniciar**.
Sus triggers principales:

```lua
-- Cargar cuando se abre un buffer con contenido real
event = "BufReadPre"   -- antes de leer el archivo (lsp, treesitter)
event = "BufReadPost"  -- después de leer (gitsigns, indent)

-- Cargar en demanda por comando
cmd = "Oil"
cmd = { "Telescope", "TelescopeFiles" }

-- Cargar solo para filetypes específicos
ft = { "markdown", "norg" }

-- Cargar al usar el keymap (el más agresivo)
keys = { { "<leader>ff", ..., desc = "Find Files" } }

-- Diferir UI no crítica al ciclo siguiente
event = "VeryLazy"   -- todo lo que no bloquea el render inicial
```

**Por qué `VeryLazy`:** Es un evento sintético que lazy.nvim dispara después de
`UIEnter` y un `vim.schedule`. Garantiza que el editor ya mostró la UI antes de
cargar plugins de baja prioridad (which-key, mini.surround, autopairs).

### LazyVim: triggers en las keys del plugin spec

LazyVim aprovecha que lazy.nvim puede registrar keymaps *antes* de cargar el plugin:

```lua
-- El plugin no carga hasta que el usuario presiona <leader>ff
{
    "nvim-telescope/telescope.nvim",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
    },
}
```

**Ventaja:** El usuario ve los hints en which-key inmediatamente; el plugin se instancia
solo cuando hace falta. Elimina el problema de "registrar keymaps en `config =`" que
carga el plugin entero.

### Tu configuración actual

Tu `snacks.nvim` está bien con `lazy = false` y `priority = 1000` — es correcto
porque Snacks reemplaza `vim.notify` globalmente. El problema es que **ningún otro plugin**
tiene triggers explícitos de lazy loading. Todos cargan con defaults de lazy.nvim.

**Impacto medible:** Agrega `event = "BufReadPre"` a lsp, treesitter; `event = "VeryLazy"`
a lualine, noice, autopairs, gitsigns; y usa `keys = {}` en conform. Esto puede reducir
startup de ~150ms a ~40ms.

---

## 3. LSP: configuración y deduplicación

### El patrón moderno: `vim.lsp.config` + `vim.lsp.enable` (Neovim 0.11+)

**Tú ya usas esto correctamente.** Tanto NvChad como LazyVim migraron a este patrón
porque:
1. No necesita `lspconfig` para la plomería básica
2. Los archivos `lsp/*.lua` son módulos independientes cargados por nombre
3. `vim.lsp.config("*", { ... })` aplica capabilities globalmente sin repetirlo

```lua
-- after/plugin/lsp.lua
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})
```

Esto es exactamente lo que hace LazyVim. ✓

### El patrón de deduplicación de LazyVim

LazyVim tiene lógica para evitar que Mason y la config manual instalen el mismo servidor:

```lua
-- lua/lazyvim/plugins/lsp/init.lua (simplificado)
local mason_exclude = {}
for server, config in pairs(servers) do
    if config.mason == false or not mason_available then
        table.insert(mason_exclude, server)
    end
    -- Si tiene setup() propio, no dejar que mason-lspconfig lo toque
end
```

**Por qué:** Cuando tienes 8+ servidores, Mason y `ensure_installed` de mason-lspconfig
pueden instalar versiones que entran en conflicto con binarios del sistema (phpactor via
composer, node LSPs via npm). La flag `mason = false` le dice "este servidor lo gestiono yo".

### Tu `features.lua` — una solución equivalente

```lua
-- lua/config/features.lua
return {
    lsp = {
        lua_ls      = true,
        phpantom    = true,
        phpactor    = false,  -- desactivado manualmente
        vtsls       = true,
        ts_ls       = false,  -- conflicto con vtsls
    }
}
```

Esto cumple la misma función: control explícito de qué servidores activar sin depender de
auto-detección de Mason. Es un patrón sólido y más simple que el de LazyVim para tu stack.

### El problema del highlight con document_highlight

En `after/plugin/lsp.lua` tienes document_highlight restringido solo a phpactor:

```lua
if client and client.server_capabilities.documentHighlightProvider
    and client.name == "phpactor" then
```

**¿Por qué solo phpactor?** Probablemente porque otros servidores (vtsls, vue_ls) lo
activaban y generaban flicker. LazyVim lo activa para todos y luego deja que each server
decida. La restricción que tienes es válida como workaround, pero el pattern correcto
sería una lista negra en lugar de una lista blanca:

```lua
local highlight_exclude = { "tailwindcss", "eslint" }
if client.capabilities.documentHighlightProvider
    and not vim.tbl_contains(highlight_exclude, client.name) then
    -- activar highlight
end
```

---

## 4. Pipeline de formateo

### LazyVim: registro con prioridad + fallback inteligente

LazyVim tiene un sistema en `lua/lazyvim/util/format.lua`:

```lua
-- Los formateadores se registran con prioridad numérica
-- conform tiene mayor prioridad que LSP nativo
M.formatters = {}

function M.register(formatter)
    -- inserta y ordena por priority desc
end

function M.format(buf, opts)
    -- 1. Busca conform.nvim si está instalado
    -- 2. Si no, usa vim.lsp.buf.format()
    -- 3. Respeta enable/disable por buffer
end
```

**¿Por qué construyeron esto?** Para resolver el conflicto entre LSP que ofrece format
(como prettier via null-ls) y conform.nvim. Sin deduplicación, ambos se activan y
el resultado es impredecible.

**Comandos extra que LazyVim expone:**
- `:LazyFormat` — formatea aunque esté desactivado globalmente
- `:LazyFormatInfo` — muestra qué formateadores están activos en el buffer

### Tu configuración actual

Tienes conform bien configurado con `lsp_fallback = true`. El único gap es:
1. No hay format-on-save (BufWritePre)
2. No hay indicador visual de qué formatter aplicó

**Implementación mínima de format-on-save** (al estilo LazyVim):

```lua
-- En conform.lua, agrega en opts:
opts = {
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters_by_ft = { ... }  -- tu config actual
}
```

**¿Por qué 500ms y no infinito?** Si el formatter tarda más (red lenta, servidor sobrecargado),
bloquea el guardado. LazyVim usa 1000ms como máximo; 500ms es seguro para herramientas locales.

---

## 5. Sistema de temas y UI

### NvChad: base46 — pre-compilación de temas

Este es el aporte más original de NvChad. En lugar de que cada plugin defina sus propios
highlight groups al iniciar (costo en runtime), base46 **compila todo de antemano**:

```
Fase de build (~50-200ms, una sola vez):
  base46 lee theme.lua
  → genera paleta de colores completa
  → escribe un archivo Lua por integración:
      ~/.cache/nvim/base46/telescope
      ~/.cache/nvim/base46/cmp
      ~/.cache/nvim/base46/statusline
      ~/.cache/nvim/base46/gitsigns
      ...

Runtime (costo: 0):
  dofile(vim.g.base46_cache .. "telescope")  -- solo lee y aplica
```

**¿Por qué construyeron esto?** Neovim no tiene un API de temas que los plugins puedan
suscribirse. Cada plugin llama `vim.api.nvim_set_hl()` en su `setup()`. La pre-compilación
convierte ese costo recurrente en una operación única de IO.

**¿Cómo replicarlo de forma simple?**

No necesitas replicar base46 completo. La versión minimalista es usar `tokyonight.nvim`
con `opts.on_highlights` para ajustes quirúrgicos:

```lua
-- lua/plugins/custom/theme.lua
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "moon",
        transparent = false,
        on_highlights = function(hl, colors)
            hl.CursorLine = { bg = colors.bg_highlight }
            hl.WinSeparator = { fg = colors.border, bold = true }
            hl.FloatBorder = { fg = colors.border_highlight }
        end,
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight-moon")
    end,
}
```

**Alternativa para switching instantáneo:** `folke/styler.nvim` permite temas
por ventana sin necesidad de base46.

### NvChad: statusline y tabufline propios

NvChad escribió su propia statusline (no lualine) por tres razones:

1. **Integración con base46:** Los highlights se cargan del cache, no se calculan en runtime
2. **Per-tab buffer isolation:** Cada tab mantiene su propia lista de buffers — no disponible en bufferline.nvim estándar
3. **Rendimiento:** Sin abstracción intermedia; funciones Lua puras que devuelven strings

**¿Cuándo vale replicarlo?** Solo si necesitas per-tab buffer isolation. Para la mayoría
de workflows, `lualine` con `laststatus = 3` (statusline global) es suficiente y más
mantenible.

### LazyVim: lualine con secciones semánticas

```
Izquierda: [modo] [rama git]
Centro: [raíz proyecto] [diagnósticos] [icono filetype] [ruta archivo]
Derecha: [debugger] [git diff] [progreso] [línea:col]
```

**Por qué esta distribución:** La info de contexto (rama, diagnósticos) va a la izquierda
porque el ojo la lee primero. La info de posición (línea/col) va a la derecha porque
es de consulta ocasional.

---

## 6. Opciones de rendimiento

### Las opciones clave de LazyVim (y por qué cada una)

| Opción | Valor LazyVim | Tu valor actual | Razón |
|--------|--------------|-----------------|-------|
| `updatetime` | 200 | 250 | Frecuencia de CursorHold (LSP hover, document_highlight). Menor = más responsivo |
| `timeoutlen` | 300 | *comentado* | Which-key aparece más rápido; keymaps responden antes |
| `ttimeoutlen` | 10 | 10 | Salida de modos de terminal. Ya lo tienes correcto ✓ |
| `scrolloff` | 4 | 4 | Líneas de contexto al scroll. Ya correcto ✓ |
| `laststatus` | 3 | *no definido* | 3 = statusline global (una sola barra para todas las ventanas) |
| `smoothscroll` | true | *no definido* | Scroll fluido sin saltos. Requiere Neovim 0.10+ |
| `wrap` | false | true | LazyVim lo desactiva; tú lo tienes activado — depende del flujo |

**La más impactante que te falta:** `timeoutlen = 300`. Con which-key instalado, bajar
el timeout hace que los hints aparezcan casi instantáneamente después de presionar `<leader>`.

**`laststatus = 3`:** Con una sola ventana visible la diferencia es cosmética, pero con
splits muestra una sola barra elegante en lugar de múltiples.

### Opciones de fold

Tu configuración actual es sólida:

```lua
vim.opt.foldmethod = "indent"   -- más estable que treesitter en blade/vue
vim.opt.foldenable = false      -- no colapsar al abrir
vim.opt.foldlevel  = 99         -- abrir todo si se activa
```

Cambiaste de `foldexpr = treesitter` por razones válidas (crashes en blade). LazyVim
usa `foldmethod = "expr"` con `foldexpr = vim.treesitter.foldexpr()` pero también
tiene el mismo problema con injections. Tu solución de usar `indent` globalmente y
treesitter nativo via autocmd `FileType` es la más estable disponible hoy.

---

## 7. Autocomandos organizados

### El patrón de LazyVim: grupos con prefijo

LazyVim organiza todos sus autocmds en `lua/lazyvim/config/autocmds.lua` con un helper:

```lua
local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Ejemplo real de LazyVim:
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")  -- recargar si el archivo cambió fuera de nvim
        end
    end,
})
```

**Por qué el prefijo:** Al usar `:autocmd` para debuggear, el prefijo permite filtrar
tus propios grupos de los del sistema (`lazyvim_*` vs `kickstart-lsp-attach` que ya usas).

### Los autocmds más valiosos que LazyVim incluye y tú no tienes

**1. Auto-crear directorios al guardar:**
```lua
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
```
**Por qué es importante:** Al crear un archivo en una ruta nueva (`lua/utils/new/file.lua`),
sin este autocmd el guardado falla. Muy común en proyectos nuevos.

**2. Cerrar ventanas auxiliares con `q`:**
```lua
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "help", "lspinfo", "qf", "notify", "checkhealth",
        "neotest-output", "neotest-summary", "trouble",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf, silent = true, nowait = true,
        })
    end,
})
```
**Por qué:** Las ventanas de help, lspinfo, trouble, etc. no se cierran con `:q` intuitivo.
Este autocmd mapea `q` solo en esos filetypes, sin contaminar el keymap global.

**3. Recargar cuando el archivo cambia fuera de Neovim:**
```lua
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
    end,
})
```
**Por qué:** Si editas un archivo con otro editor o git hace un checkout, Neovim no
se entera. `checktime` fuerza la recarga al volver a la ventana.

---

## 8. Filosofía de keymaps

### LazyVim: namespace semántico estricto

```
<leader>b*   → Buffers    (close, next, prev, pin)
<leader>c*   → Code       (format, action, rename)
<leader>d*   → Debug      (breakpoint, continue, etc.)
<leader>f*   → Files      (find, recent, config)
<leader>g*   → Git        (branches, log, status, diff)
<leader>l*   → LSP        (diagnostics, symbols)
<leader>s*   → Search     (grep, help, marks)
<leader>u*   → UI         (toggles: spell, wrap, numbers)
<leader>w*   → Windows    (splits, close)
<leader><tab>* → Tabs
```

**Por qué este orden:** El prefijo semántico permite que which-key muestre grupos
coherentes. Cuando presionas `<leader>g`, ves "Git" con todos sus sub-comandos.
Sin namespace, `<leader>gb` podría ser "go back" o "git branches" según el plugin
que lo registró.

### Tu configuración actual

Tienes buenos keymaps pero sin namespace consistente:
- `<leader>tr*` = testing (bien, prefijo claro)
- `<leader>lg` = lazygit (bien)
- `<leader>cc` = Claude Code (bien)
- `<leader>md` = toggle diagnostics (ambiguo: "md" podría ser markdown)
- `<leader>yp`, `<leader>yn` = copy path/name (bien pero en grupo `<leader>y*`)

**Mejora sugerida:** Consolidar en `<leader>u*` los toggles (diagnósticos, inlay hints,
wrap) para alinearte con la convención de LazyVim y hacer which-key más legible.

### El patrón de toggle de LazyVim (via Snacks)

Como ya tienes Snacks, puedes usar su sistema de toggles:

```lua
-- Dentro de tu snacks.lua o en mappings.lua
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.treesitter():map("<leader>uT")
```

**Por qué Snacks.toggle en lugar de funciones custom:** Muestra el estado (on/off) en
which-key y notificaciones automáticamente. Tu `DiagnosticToggleLines` global hace
algo similar pero sin el feedback visual integrado.

---

## 9. Herramientas propias: por qué las construyeron

### NvChad: base46 (motor de temas)

**Problema que resuelve:** En Neovim, cada plugin llama `vim.api.nvim_set_hl()` en su
`setup()`. Con 30+ plugins, esto suma ~500 llamadas de highlight al arrancar.

**Solución:** Pre-compilar todos los highlights a archivos Lua durante la instalación.
Al iniciar, cada plugin hace un `dofile()` — una sola lectura de disco, sin cómputo.

**¿Se puede replicar sin base46?**
Sí, de forma manual. Puedes exportar tu paleta de colores y pasar los valores
directamente a la `opts` de cada plugin:

```lua
-- lua/utils/palette.lua (propio)
local M = {}
M.colors = require("tokyonight.colors").setup({ style = "moon" })
return M

-- En treesitter config:
local c = require("utils.palette").colors
-- usar c.blue, c.green, etc. para highlight groups custom
```

Pero la inversión de tiempo solo vale si gestionas 5+ temas o necesitas switching en vivo.

### NvChad: tabufline (bufferline por pestaña)

**Problema que resuelve:** `bufferline.nvim` estándar muestra *todos* los buffers abiertos
en la barra. Con 20+ archivos abiertos, la barra se llena y pierde utilidad.

**Solución de NvChad:** Cada tab de Neovim guarda su propia lista de buffers. La tabufline
muestra solo los buffers de la tab activa.

**¿Cómo replicarlo?** `akinsho/bufferline.nvim` tiene soporte básico de grupos, pero
no aislamiento por tab puro. La alternativa más cercana disponible como plugin es
`tiagovla/scope.nvim` que hace exactamente esto:

```lua
{
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = true,
}
```

Nota: **tú ya tienes `scope` de Snacks activado** (`scope = { enabled = true }`).
Snacks.scope hace análisis de scope de código (bloques, funciones), no aislamiento
de buffers. Para per-tab buffers necesitarías scope.nvim separado.

### LazyVim: `LazyVim.pick` (abstracción de pickers)

**Problema que resuelve:** LazyVim soporta Telescope, fzf-lua, y Snacks picker.
Sin abstracción, cambiar de picker requiere editar todos los keymaps.

**Solución:**

```lua
-- Registro del backend activo
LazyVim.pick.register({
    name = "snacks",
    open = function(command, opts)
        return Snacks.picker[command](opts)
    end,
})

-- Keymap agnóstico al backend
{ "<leader>ff", LazyVim.pick("files"), desc = "Find Files" }
```

**¿Necesitas esto?** No si usas Snacks picker exclusivamente (que es tu caso).
Solo es valioso si quieres poder cambiar de backend sin reescribir keymaps.

### LazyVim: `LazyVim.format` (registro de formateadores)

**Problema:** `conform.nvim` y LSP format pueden colisionar. El usuario puede querer
desactivar format-on-save por buffer pero no globalmente.

**Solución:**

```lua
-- Control por buffer
vim.b.autoformat = false  -- desactiva solo en este buffer

-- Comando de diagnóstico
:LazyFormatInfo  -- muestra qué formatter está activo y por qué
```

**¿Cómo replicarlo de forma simple?**

```lua
-- En mappings.lua
vim.keymap.set("n", "<leader>uf", function()
    vim.b.autoformat = not vim.b.autoformat
    vim.notify("Autoformat: " .. (vim.b.autoformat and "ON" or "OFF"))
end, { desc = "Toggle format on save (buffer)" })
```

---

## 10. Estado actual de tu config vs. buenas prácticas

### Lo que ya tienes bien

| Práctica | Estado |
|----------|--------|
| `vim.lsp.config` + `vim.lsp.enable` (API 0.11+) | ✓ Correcto |
| `blink.cmp` para capabilities globales | ✓ Moderno |
| `features.lua` para control de LSP | ✓ Equivalente a `mason = false` |
| Snacks como picker unificado | ✓ Excelente (misma elección de LazyVim) |
| `conform.nvim` con `lsp_fallback` | ✓ Correcto |
| Treesitter con native highlight API (0.12) | ✓ Adelantado al estándar |
| `undofile = true` + `undolevels = 10000` | ✓ Mismo que LazyVim |
| Autocomando `highlight_yank` | ✓ Igual que LazyVim |
| Grupos de autocomandos con `augroup` | ✓ Presente pero sin prefijo consistente |
| `foldmethod = indent` (estable en blade/vue) | ✓ Decisión correcta dado el contexto |

### Gaps identificados

| Gap | Impacto | Dificultad |
|-----|---------|------------|
| Sin lazy loading explícito en plugins | Alto (startup ~100ms extra) | Media |
| `timeoutlen` comentado | Medio (which-key lento) | Baja |
| Sin format-on-save | Medio (flujo manual) | Baja |
| Sin `laststatus = 3` | Bajo (cosmético) | Baja |
| Sin auto-create-dir autocmd | Medio (UX) | Baja |
| Sin close-with-q en ventanas aux | Medio (ergonomía) | Baja |
| `documentHighlight` solo para phpactor | Bajo (limitación funcional) | Baja |
| Sin toggles con Snacks.toggle | Bajo (ergonomía) | Baja |
| `smoothscroll` no activado | Bajo (visual) | Baja |

---

## 11. Mejoras priorizadas para implementar

Ordenadas por impacto/esfuerzo:

### Prioridad 1: Lazy loading (mayor impacto en startup)

```lua
-- lua/plugins/core/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },  -- AGREGAR
    -- ... resto igual
}

-- lua/plugins/core/completacion.lua  
return {
    "saghen/blink.cmp",
    event = "InsertEnter",  -- AGREGAR: solo carga al entrar en modo insert
    -- ...
}

-- lua/plugins/core/noice.lua
return {
    "folke/noice.nvim",
    event = "VeryLazy",  -- AGREGAR
    -- ...
}

-- lua/plugins/core/lualine.lua
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",  -- AGREGAR
    -- ...
}
```

### Prioridad 2: Opciones faltantes (bajo esfuerzo)

```lua
-- lua/config/options.lua — agregar:
vim.opt.timeoutlen   = 300   -- which-key más rápido (estaba comentado)
vim.opt.laststatus   = 3     -- statusline global (una barra para todos los splits)
vim.opt.smoothscroll = true  -- scroll fluido
vim.opt.splitkeepalt = "screen"  -- mantener viewport al hacer splits
```

### Prioridad 3: Autocmds de calidad de vida

```lua
-- lua/autocomands/init.lua — agregar requires:
require("autocomands.auto_create_dir")
require("autocomands.close_with_q")
require("autocomands.checktime")
```

```lua
-- lua/autocomands/auto_create_dir.lua
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("my_auto_create_dir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
```

```lua
-- lua/autocomands/close_with_q.lua
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
```

```lua
-- lua/autocomands/checktime.lua
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("my_checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})
```

### Prioridad 4: Format-on-save

```lua
-- lua/plugins/custom/conform.lua — modificar opts:
opts = {
    format_on_save = function(bufnr)
        -- Permite desactivar por buffer con vim.b.autoformat = false
        if vim.b[bufnr].autoformat == false then return end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters_by_ft = { ... }  -- tu config actual sin cambios
},
```

### Prioridad 5: Toggles con Snacks

```lua
-- lua/config/mappings.lua — agregar:
vim.keymap.set("n", "<leader>uw", function()
    Snacks.toggle.option("wrap"):toggle()
end, { desc = "Toggle Wrap" })

vim.keymap.set("n", "<leader>uL", function()
    Snacks.toggle.option("relativenumber"):toggle()
end, { desc = "Toggle Relative Numbers" })

vim.keymap.set("n", "<leader>ud", function()
    Snacks.toggle.diagnostics():toggle()
end, { desc = "Toggle Diagnostics" })

vim.keymap.set("n", "<leader>uh", function()
    Snacks.toggle.inlay_hints():toggle()
end, { desc = "Toggle Inlay Hints" })

vim.keymap.set("n", "<leader>uf", function()
    vim.b.autoformat = not vim.b.autoformat
    vim.notify("Autoformat " .. (vim.b.autoformat == false and "OFF" or "ON"))
end, { desc = "Toggle Format on Save (buffer)" })
```

---

## Resumen ejecutivo

| Distribución | Fortaleza clave | Por qué funciona |
|-------------|----------------|-----------------|
| **NvChad** | Startup ultrarrápido + theming | 93% lazy + base46 pre-compilado |
| **LazyVim** | UX pulida + extensibilidad | Abstracciones inteligentes (pick, format, toggle) |
| **Tu config** | Ya usa las APIs más modernas | vim.lsp.config, blink.cmp, Snacks, TS nativo |

**La brecha principal** no es de plugins sino de *triggers de carga*. Tienes los
plugins correctos; agregarles `event` y `keys` specs los hará cargar en demanda
en lugar de al inicio, acercándote al rendimiento de NvChad sin cambiar nada más.

Las utilidades de LazyVim (format registry, toggle system) son valiosas pero ya
tienes equivalentes parciales. Snacks.toggle es la forma más directa de obtener
el mismo resultado con cero dependencias adicionales.
