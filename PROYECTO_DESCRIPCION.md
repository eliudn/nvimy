# DESCRIPCION COMPLETA DEL PROYECTO - Neovim Configuration
> Generado: 2026-03-31 | Para uso de agentes de IA y colaboradores

---

## OVERVIEW

Configuracion de Neovim altamente personalizada para desarrollo **PHP/Laravel** y **JavaScript/TypeScript/Vue**, construida sobre Lazy.nvim con arquitectura modular. El proyecto tiene ~56 archivos Lua, ~2,870 lineas de codigo y 36 plugins activos.

**Estado actual:** Produccion-ready. Fases 4-7 completadas. Fases 1-3 pendientes (debugging, database, IA).

---

## 1. ESTRUCTURA DE DIRECTORIOS

```
/home/leunamzx/.config/nvim/
│
├── init.lua                          # Entry point (3 lineas) - carga config y autocommands
├── lazy-lock.json                    # Lock file de 36 plugins con commits exactos
├── .luarc.json                       # Configuracion del servidor LSP de Lua
│
├── ANALISIS_CONFIGURACION.md         # Analisis detallado de la config
├── PLAN_MEJORAS.md                   # Plan de 8 fases de mejoras (4-7 completadas)
├── CAMBIOS.md                        # Changelog de fases 4-7
├── PROYECTO_DESCRIPCION.md           # Este archivo
├── IMPRESIONES_EVALUACION.md         # Evaluacion critica del proyecto
│
├── after/plugin/
│   └── lsp.lua                       # Keybindings LSP + attachment logic + feature flags
│
├── lsp/                              # Configuraciones individuales por servidor LSP
│   ├── lua_ls.lua                    # Lua language server (LuaJIT)
│   ├── phpactor.lua                  # PHP con PHPStan e imports de Laravel
│   ├── ts_ls.lua                     # TypeScript (DESHABILITADO - sustituido por vtsls)
│   ├── vtsls.lua                     # TS/JS moderno con soporte Vue
│   ├── vue_ls.lua                    # Vue SFC language server
│   ├── emmet_ls.lua                  # HTML/CSS/Blade/PHP emmet
│   ├── jsonls.lua                    # JSON con validacion de schemas
│   ├── tailwindcss.lua               # TailwindCSS con soporte cva/cx
│   ├── eslint.lua                    # ESLint con auto-fix al guardar
│   ├── texlab.lua                    # LaTeX con auto-build
│   └── laravel-ls.lua                # Laravel routes/views/models
│
├── lua/
│   ├── config/
│   │   ├── init.lua                  # Carga todos los submodulos de config
│   │   ├── options.lua               # Opciones de vim (tabs, UI, performance)
│   │   ├── lazy.lua                  # Bootstrap de Lazy.nvim
│   │   ├── mappings.lua              # Keybindings globales (~105 lineas)
│   │   ├── diagnostic.lua            # Configuracion de diagnosticos LSP
│   │   └── features.lua              # Feature flags para habilitar/deshabilitar LSP
│   │
│   ├── autocomands/
│   │   ├── init.lua                  # Carga todos los autocommands
│   │   ├── easy_close_buffers.lua    # Cierra help/fugitive/qf con 'q'
│   │   ├── highlight_yank.lua        # Highlight visual al copiar (200ms)
│   │   ├── latex.lua                 # Settings especificos para LaTeX/Blade
│   │   ├── notify_formatter.lua      # Notificacion Snacks al formatear
│   │   ├── remove_trailing_whitespace.lua  # Elimina espacios al guardar
│   │   └── restore_cursor.lua        # Restaura posicion del cursor al abrir
│   │
│   ├── plugins/core/                 # Plugins fundamentales
│   │   ├── lsp.lua                   # Placeholder (LSP real en after/)
│   │   ├── mason.lua                 # Instalador: tailwindcss-ls, blade-formatter, eslint-lsp
│   │   ├── completacion.lua          # Blink.cmp + LuaSnip
│   │   ├── treesitter.lua            # Syntax highlighting 30+ lenguajes
│   │   ├── autoparis.lua             # Auto-cierre de brackets
│   │   ├── lualine.lua               # Status line con info de Laravel
│   │   ├── noice.nvim                # UI mejorado (comandos, busqueda)
│   │   ├── snacks.nvim               # Suite principal (picker, terminal, git, explorer)
│   │   ├── gitsing.lua               # Git signs en gutter
│   │   └── lazydev.lua               # Type hints para desarrollo en Lua
│   │
│   ├── plugins/custom/               # Plugins adicionales/experimentales
│   │   ├── theme.lua                 # Tokyo Night colorscheme
│   │   ├── conform.lua               # Formatters (13 filetypes)
│   │   ├── lint.lua                  # Linters (phpstan, eslint_d)
│   │   ├── trouble.lua               # Visor de diagnosticos
│   │   ├── flash.nvim                # Navegacion por salto de caracteres
│   │   ├── fidget.nvim               # Indicador de progreso LSP
│   │   ├── oil.lua                   # Explorador de archivos tipo buffer
│   │   ├── testing.lua               # Neotest + PHPUnit + Vitest
│   │   ├── laravel.lua               # Integracion Laravel.nvim
│   │   ├── mini-surround.lua         # Operaciones surround (sa, sd, sr)
│   │   ├── persistence.lua           # Gestion de sesiones
│   │   ├── todo-commends.lua         # Navegacion de comentarios TODO
│   │   └── nvim-colorizer.lua        # Preview de colores en codigo
│   │
│   └── snippets/
│       ├── php.lua                   # 10 snippets Laravel/PHP (mig, mod, ctrl, etc)
│       ├── blade.lua                 # 9 snippets Blade templates
│       └── vue.lua                   # 10 snippets Vue/TS + 3 TS genericos
```

---

## 2. CONFIGURACION DE OPTIONS (lua/config/options.lua)

```lua
-- Leader keys
mapleader = " "       -- Barra espaciadora
maplocalleader = "'"  -- Comilla simple

-- Numeros de linea
number = true
relativenumber = true
signcolumn = "yes"

-- Indentacion (espacios, no tabs)
expandtab = true
tabstop = 4
softtabstop = 4
shiftwidth = 4

-- Splits
splitbelow = true
splitright = true

-- Busqueda
hlsearch = false
incsearch = true
ignorecase = true
smartcase = true

-- UI
colorcolumn = "80"
termguicolors = true
scrolloff = 4
sidescrolloff = 4
cmdheight = 0        -- Sin barra de comandos visible

-- Rendimiento
updatetime = 250     -- ms
timeoutlen = 300     -- ms para mappings
ttimeoutlen = 10     -- ms para escape terminal
redrawtime = 1500    -- ms para syntax highlighting

-- Undo persistente
undofile = true
undodir = cache_dir .. "/undo//"
undolevels = 10000
undoreload = 10000

-- Folding (deshabilitado por defecto)
foldmethod = "expr"
foldexpr = "nvim_treesitter#foldexpr()"
foldenable = false

-- LaTeX
vimtex_view_method = "zathura"
```

---

## 3. FEATURE FLAGS (lua/config/features.lua)

Tabla de control para habilitar/deshabilitar servidores LSP:

```lua
M.servers = {
    lua_ls     = true,   -- Lua language server
    phpactor   = true,   -- PHP (con PHPStan + Laravel)
    ts_ls      = false,  -- DESHABILITADO (vtsls lo reemplaza)
    vue_ls     = true,   -- Vue SFC
    vtsls      = true,   -- TypeScript/JavaScript moderno
    emmet      = true,   -- Emmet para HTML/CSS/Blade/PHP
    tailwindcss = true,  -- TailwindCSS
    eslint     = true,   -- ESLint con auto-fix
    texlab     = true,   -- LaTeX
}
```

> Para agregar un nuevo servidor: crear `lsp/nombre.lua` y agregar entrada en features.lua

---

## 4. SERVIDORES LSP (11 configurados, 10 activos)

| Servidor | Lenguaje | Archivo Config | Estado | Root Markers |
|----------|----------|---------------|--------|--------------|
| `phpactor` | PHP, Blade | `lsp/phpactor.lua` | ACTIVO | composer.json |
| `lua_ls` | Lua | `lsp/lua_ls.lua` | ACTIVO | .luarc.json, .git |
| `vtsls` | TS, JS, Vue | `lsp/vtsls.lua` | ACTIVO | package.json |
| `vue_ls` | Vue SFC | `lsp/vue_ls.lua` | ACTIVO | package.json, vite.config.* |
| `emmet_ls` | HTML,CSS,Blade,PHP | `lsp/emmet_ls.lua` | ACTIVO | .git |
| `jsonls` | JSON, JSONC | `lsp/jsonls.lua` | ACTIVO | .git |
| `tailwindcss` | CSS en cualquier lang | `lsp/tailwindcss.lua` | ACTIVO | tailwind.config.* |
| `eslint` | JS, TS, Vue | `lsp/eslint.lua` | ACTIVO | .eslintrc.*, eslint.config.* |
| `texlab` | LaTeX, BibTeX | `lsp/texlab.lua` | ACTIVO | .latexmkrc, .git |
| `laravel-ls` | PHP, Blade | `lsp/laravel-ls.lua` | ACTIVO | artisan |
| `ts_ls` | TS, JS | `lsp/ts_ls.lua` | DESHABILITADO | - |

### Keybindings LSP (after/plugin/lsp.lua)
```
gd       → Go to definition (Snacks picker)
gr       → References (Snacks picker)
gI       → Implementations
gD       → Declaration
K        → Hover docs (border redondeado)
<leader>rn → Rename
<leader>ca → Code action
<leader>D  → Type definition
<leader>ds → Document symbols
<leader>ws → Workspace symbols
<leader>th → Toggle inlay hints
```

---

## 5. FORMATTERS (lua/plugins/custom/conform.lua)

**Motor:** Conform.nvim | **Trigger:** `<C-f>` (async, con fallback LSP)

| Filetype | Formatter | Instalacion |
|----------|-----------|-------------|
| lua | stylua | `cargo install stylua` |
| php | php_cs_fixer | `composer global require friendsofphp/php-cs-fixer` |
| blade | blade_formatter | `npm i -g blade-formatter` (Mason auto-instala) |
| vue | prettier | `npm i -g prettier` |
| javascript | prettier | `npm i -g prettier` |
| typescript | prettier | `npm i -g prettier` |
| javascriptreact | prettier | `npm i -g prettier` |
| typescriptreact | prettier | `npm i -g prettier` |
| json | prettier | `npm i -g prettier` |
| jsonc | prettier | `npm i -g prettier` |
| css | prettier | `npm i -g prettier` |
| html | prettier | `npm i -g prettier` |
| markdown | prettier | `npm i -g prettier` |

---

## 6. LINTERS (lua/plugins/custom/lint.lua)

**Motor:** nvim-lint | **Trigger:** Automatico en `BufWritePost`, `BufReadPost`

| Filetype | Linter | Proposito |
|----------|--------|-----------|
| php | phpstan | Analisis estatico de tipos |
| javascript | eslint_d | Linting rapido (modo daemon) |
| typescript | eslint_d | Linting rapido |
| vue | eslint_d | Linting rapido |

> ESLint tambien disponible como LSP (`eslint.lua`) con auto-fix via `EslintFixAll` en `BufWritePre`

---

## 7. COMPLETION ENGINE (lua/plugins/core/completacion.lua)

**Motor:** Blink.cmp (reemplaza nvim-cmp) + LuaSnip

**Fuentes de completion:**
- LSP servers
- Snippets (LuaSnip)
- Path completion
- Buffer words

**Snippets personalizados** (`lua/snippets/`):
- `php.lua`: 10 snippets - `mig`, `mod`, `ctrl`, `req`, `resp`, `form`, `job`, `event`, `obs`, `mid`
- `blade.lua`: 9 snippets - componentes, directivas, layouts Blade
- `vue.lua`: 10 snippets Vue + 3 TypeScript genericos

---

## 8. LISTA COMPLETA DE PLUGINS (36 total)

### Core LSP & Completion
| Plugin | Version | Proposito |
|--------|---------|-----------|
| blink.cmp | cdd2b4b | Motor de completion moderno |
| blink.compat | v2 | Compatibilidad de fuentes legacy |
| luasnip | v2.3.0 | Motor de snippets |
| friendly-snippets | main | Coleccion de snippets VSCode |
| mason.nvim | v2+ | Instalador de herramientas LSP |
| nvim-treesitter | master | Syntax highlighting 30+ langs |
| nvim-treesitter-textobjects | main | Text objects (funcion, clase) |
| lazydev.nvim | main | Type hints para Lua dev |

### UI & Navegacion
| Plugin | Version | Proposito |
|--------|---------|-----------|
| snacks.nvim | main | Suite: picker, terminal, git, notifier |
| noice.nvim | main | UI de comandos y busqueda |
| nui.nvim | main | Componentes UI (para noice/laravel) |
| lualine.nvim | master | Status line |
| nvim-notify | master | Notificaciones |
| tokyonight.nvim | main | Colorscheme Tokyo Night |
| flash.nvim | main | Navegacion por salto |
| oil.nvim | master | Explorador de archivos-buffer |
| trouble.nvim | main | Visor de diagnosticos |
| mini.icons | main | Iconos |
| mini.surround | main | Operaciones surround |

### Git
| Plugin | Version | Proposito |
|--------|---------|-----------|
| gitsigns.nvim | main | Signs git en gutter |

### Desarrollo
| Plugin | Version | Proposito |
|--------|---------|-----------|
| laravel.nvim | main | Integracion Laravel completa |
| conform.nvim | master | Formatters de codigo |
| nvim-lint | master | Motor de linting |
| neotest | master | Framework de testing |
| neotest-phpunit | main | Adapter PHPUnit/Pest |
| neotest-vitest | main | Adapter Vitest |
| nvim-autopairs | master | Auto-cierre de brackets |
| nvim-colorizer.lua | master | Preview de colores |
| todo-comments.nvim | main | Navegacion TODO comments |
| fidget.nvim | main | Indicador progreso LSP |
| persistence.nvim | main | Sesiones |
| FixCursorHold.nvim | master | Performance CursorHold |

### Utilidades
| Plugin | Version | Proposito |
|--------|---------|-----------|
| lazy.nvim | main | Plugin manager |
| plenary.nvim | master | Utilidades Lua |
| nvim-nio | master | Utilidades async |

---

## 9. KEYBINDINGS COMPLETOS

### Leader = Barra espaciadora ` `

#### Archivos & Navegacion
```
<leader>ff    → Snacks: Buscar archivos en cwd
<leader>fg    → Snacks: Archivos git
<leader>fb    → Snacks: Buffers abiertos
<leader>fc    → Snacks: Archivos de config
<leader>fr    → Snacks: Archivos recientes
<leader>fp    → Snacks: Proyectos
<leader>,     → Snacks: Buffers (alternativa)
<leader><space> → Snacks: Smart (archivos/buffers)
-             → Oil: explorador de archivos
<leader>e     → Snacks: Explorer
```

#### Edicion & Ventanas
```
<leader>w     → Guardar
<leader>q     → Cerrar
<leader>Q     → Cerrar todo
<leader>-     → Split horizontal
<leader>|     → Split vertical
<leader>yp    → Copiar ruta del archivo
<leader>yn    → Copiar nombre del archivo
<C-h/j/k/l>  → Navegar entre ventanas
<C-Dir>       → Redimensionar ventanas
<A-j/k>       → Mover linea arriba/abajo
<C-f>         → Formatear buffer (Conform)
```

#### LSP
```
gd            → Ir a definicion
gr            → Referencias
gI            → Implementaciones
gD            → Declaracion
K             → Hover docs
<leader>rn    → Renombrar
<leader>ca    → Code action
<leader>th    → Toggle inlay hints
<leader>ds    → Simbolos del documento
<leader>ws    → Simbolos del workspace
```

#### Git
```
<leader>lg    → Lazygit (floating)
<leader>gB    → Abrir en browser
<leader>gb    → Branches
<leader>gl    → Git log
<leader>gs    → Git status
<leader>gd    → Git diff
]c / [c       → Siguiente/anterior hunk
<leader>hs    → Stage hunk
<leader>hr    → Reset hunk
<leader>hp    → Preview hunk
<leader>hb    → Blame line
```

#### Laravel
```
<leader>ll    → Laravel picker principal
<leader>la    → Artisan picker
<leader>lr    → Routes picker
<leader>lm    → Make picker
<leader>lc    → Commands picker
<leader>lt    → Actions picker
<leader>lh    → Documentacion Laravel
<C-g>         → View finder
gf (expr)     → Go to resource (routes, views, models)
```

#### Busqueda
```
<leader>sg    → Grep en proyecto
<leader>sw    → Grep palabra bajo cursor
<leader>sB    → Grep en buffers abiertos
<leader>sb    → Lineas del buffer
<leader>st    → Buscar TODO comments
<leader>sh    → Help pages
<leader>sk    → Keymaps
```

#### Diagnosticos & Errores
```
<leader>xx    → Trouble: Toggle diagnosticos
<leader>xX    → Trouble: Diagnosticos del buffer
<leader>cs    → Trouble: Simbolos del documento
<leader>cl    → Trouble: LSP referencias
<leader>xL    → Trouble: Location list
<leader>xQ    → Trouble: Quickfix list
<leader>ld    → Snacks: Diagnosticos LSP
```

#### Testing (Neotest)
```
<leader>tr    → Ejecutar test mas cercano
<leader>tf    → Ejecutar tests del archivo
<leader>ts    → Parar tests
<leader>to    → Ver output del test
<leader>tO    → Toggle panel de output
<leader>tS    → Toggle summary
```

#### Sesiones & Utilidades
```
<leader>qs    → Restaurar sesion
<leader>ql    → Restaurar ultima sesion
<leader>qd    → No guardar sesion
<C-'>         → Terminal flotante
<leader>.     → Scratch buffer
<leader>n     → Historial de notificaciones
<leader>:     → Historial de comandos
```

#### Flash (Jump Navigation)
```
s (n/v/o)    → Flash jump
S (n/v/o)    → Flash treesitter jump
r (operador) → Remote flash
```

---

## 10. AUTOCOMMANDS

| Archivo | Evento | Accion |
|---------|--------|--------|
| `easy_close_buffers.lua` | FileType help/qf/notify/etc | Mapea 'q' para cerrar |
| `highlight_yank.lua` | TextYankPost | Highlight visual 200ms |
| `latex.lua` | FileType tex/blade | wrap, spell, conceallevel=2 |
| `notify_formatter.lua` | User conform (post-format) | Notificacion Snacks |
| `remove_trailing_whitespace.lua` | BufWritePre | Elimina espacios finales |
| `restore_cursor.lua` | BufReadPost | Restaura posicion del cursor |

---

## 11. UI Y APARIENCIA

### Colorscheme
- **Tema:** Tokyo Night (dark variant)
- **Carga:** lazy=false, priority=1000 (primero en cargar)

### Status Line (Lualine)
Componentes de izquierda a derecha:
1. Icono de modo (normal/insert/visual/etc)
2. Branch git + diff stats (added/modified/removed)
3. Nombre del proyecto (autodetect git root)
4. Icono de filetype + nombre del archivo con path
5. Diagnosticos LSP (errores/warnings/hints)
6. Nombres de servidores LSP activos
7. Info Laravel (version, PHP, dump server) - si aplica

### Diagnosticos
```lua
virtual_lines = true   -- Una linea por debajo, no inline
underline = true
severity_sort = true
signs = {
    ERROR = "󰅚",   -- Rojo
    WARN  = "󰀪",   -- Naranja
    INFO  = "󰋽",   -- Azul
    HINT  = "󰌶",   -- Gris
}
float = { border = "rounded", source = true }
```

---

## 12. DEPENDENCIAS EXTERNAS

### Herramientas del sistema (requeridas)
```
git              # Control de versiones
stylua           # Formatter Lua
php-cs-fixer     # Formatter PHP
prettier         # Formatter JS/TS/CSS/HTML/JSON/MD
eslint_d         # Linter JS/TS daemon
phpstan          # Linter estatico PHP
zathura          # Visor PDF para LaTeX
latexmk          # Build LaTeX
```

### Herramientas instaladas via Mason (automatico)
```
tailwindcss-language-server
blade-formatter
eslint-lsp
```

### Requerimientos del sistema
```
Neovim >= 0.10
Terminal con truecolor (24-bit)
Nerd Font instalada
Node.js + npm (para TS/Vue/formatters)
PHP + Composer (para proyectos Laravel)
```

### Rutas importantes
```
Config:     ~/.config/nvim/
Cache/Undo: ~/.cache/nvim/undo/
Plugins:    ~/.local/share/nvim/lazy/
Mason:      ~/.local/share/nvim/mason/
Sessions:   ~/.local/share/nvim/persistence/
```

---

## 13. ROADMAP (Estado actual)

### Completado
- [x] Fase 4: Framework de testing (Neotest + PHPUnit + Vitest)
- [x] Fase 5: Snippets personalizados (PHP, Blade, Vue)
- [x] Fase 6: Formateo completo, TailwindCSS, ESLint, nvim-lint
- [x] Fase 7: Performance y limpieza (ts_ls deshabilitado, folding)

### Pendiente (critico)
- [ ] Fase 1: Debugging - nvim-dap + adapters PHP + JS/TS
- [ ] Fase 2: Database - vim-dadbod + vim-dadbod-ui
- [ ] Fase 3: AI Assistant - Avante.nvim o CodeCompanion + Claude API

---

## 14. PATRONES Y CONVENCIONES DEL PROYECTO

### Agregar nuevo plugin
1. Crear `lua/plugins/custom/nombre.lua` (o `core/` si es fundamental)
2. Exportar tabla de configuracion Lazy
3. Agregar keybindings en el archivo o en `lua/config/mappings.lua`

### Agregar nuevo LSP
1. Crear `lsp/nombre.lua` con `M = {}; M.setup = {...}; return M`
2. Agregar `nombre = true` en `lua/config/features.lua`
3. Asegurar que Mason lo instale si no esta en el sistema

### Agregar nuevos snippets
1. Editar el archivo correspondiente en `lua/snippets/`
2. Usar formato LuaSnip con `ls.add_snippets("filetype", {...})`
3. Cargar via `require("luasnip.loaders.from_lua").load(...)`

### Estilo de codigo
- Lua puro (no vimscript)
- Modulos retornan tablas con configuracion Lazy
- Feature flags en `features.lua` para cosas que se desactivan frecuentemente
- Autocommands en archivos separados por funcionalidad

---

## 15. INFORMACION PARA OTROS AGENTES

### Contexto del usuario
- **Enfoque principal:** Desarrollo Laravel (PHP) + Vue/TypeScript
- **Secundario:** LaTeX, JSON, HTML/CSS
- **Herramienta preferida para busqueda:** Snacks.nvim picker (NO Telescope)
- **Completion engine:** Blink.cmp (NO nvim-cmp)
- **Filosofia:** Keyboard-only, minimalista pero completo

### Archivos criticos para modificar
- `lua/config/options.lua` - settings globales de Neovim
- `lua/config/mappings.lua` - TODOS los keybindings globales
- `lua/config/features.lua` - habilitar/deshabilitar LSP servers
- `after/plugin/lsp.lua` - keybindings y comportamiento LSP
- `lua/plugins/custom/conform.lua` - formatters
- `lua/plugins/custom/lint.lua` - linters

### Archivos de solo lectura (no modificar sin razon)
- `lazy-lock.json` - solo actualizar via `:Lazy update`
- `.luarc.json` - configuracion del LSP de Lua

### Patrones de busqueda utiles
```
-- Para encontrar un keymap:
grep -r "leader" lua/config/mappings.lua

-- Para encontrar configuracion de un plugin:
grep -r "plugin-name" lua/plugins/

-- Para verificar que LSP esta activo:
:LspInfo en un buffer del tipo correspondiente
```
