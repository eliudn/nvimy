# Plan de Mejoras Neovim
> Fecha: 2026-03-23 | Stack: PHP/Laravel · JS/TS/Vue · IA · Debug · DB

---

## PRIORIDADES

| Fase | Área | Impacto | Dificultad |
|------|------|---------|------------|
| 1 | Debugging (DAP) | CRÍTICO | Media |
| 2 | Gestor de Bases de Datos | CRÍTICO | Baja |
| 3 | Asistente IA | ALTO | Media |
| 4 | Testing integrado | ALTO | Media |
| 5 | Completado y snippets | MEDIO | Baja |
| 6 | Formateo y linting | MEDIO | Baja |
| 7 | Performance y limpieza | BAJO | Baja |

---

## FASE 1 — DEBUGGING (DAP) 🔴

### Objetivo
Configurar depuración interactiva para PHP/Laravel y JS/TS/Node.

### Plugins a instalar
```lua
-- lua/plugins/custom/dap.lua
{
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",      -- UI visual de debug
    "nvim-neotest/nvim-nio",     -- ya instalado
    "theHamsta/nvim-dap-virtual-text", -- variables inline
  },
},
{
  "jay-babu/mason-nvim-dap.nvim", -- instala adaptadores via Mason
  dependencies = { "mason.nvim", "nvim-dap" },
},
```

### Adaptadores a configurar
| Adaptador | Lenguaje | Instalar via Mason |
|-----------|----------|---------------------|
| `php-debug-adapter` | PHP/Laravel | `mason install php-debug-adapter` |
| `js-debug-adapter` | JS/TS/Node | `mason install js-debug-adapter` |

### Keybindings sugeridos
```lua
-- Agregar a mappings.lua o dap.lua
vim.keymap.set("n", "<F5>",  dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Condition: "))
end)
vim.keymap.set("n", "<leader>du", dapui.toggle)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dl", dap.run_last)
```

### Configuración PHP (Xdebug)
```lua
-- lsp/dap_php.lua
dap.adapters.php = {
  type = "executable",
  command = "php-debug-adapter",
}
dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Laravel: Listen for Xdebug",
    port = 9003,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}",
    },
  },
}
```

### Configuración JS/TS/Node
```lua
-- lsp/dap_js.lua
require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug-adapter",
    args = { "${port}" },
  },
}
```

### Tareas
- [ ] Crear `lua/plugins/custom/dap.lua` con los plugins
- [ ] Instalar mason-nvim-dap.nvim
- [ ] Crear `lsp/dap_php.lua` — configuración PHP/Xdebug
- [ ] Crear `lsp/dap_js.lua` — configuración JS/TS/Node
- [ ] Agregar keybindings en `config/mappings.lua`
- [ ] Instalar `php-debug-adapter` y `js-debug-adapter` via Mason
- [ ] Configurar `nvim-dap-virtual-text` para variables inline
- [ ] Documentar configuración Xdebug en php.ini

---

## FASE 2 — GESTOR DE BASES DE DATOS 🔴

### Objetivo
Query directo a MySQL/PostgreSQL/SQLite desde Neovim con autocompletado.

### Plugins a instalar
```lua
-- lua/plugins/custom/database.lua
{
  "tpope/vim-dadbod",
  lazy = true,
},
{
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  keys = {
    { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
  },
},
```

### Completado SQL en blink.cmp
```lua
-- Agregar a completacion.lua en sources
sources = {
  default = { "lsp", "path", "snippets", "buffer", "dadbod" },
  providers = {
    dadbod = {
      name = "Dadbod",
      module = "vim_dadbod_completion.blink",
    },
  },
},
```

### Conexiones de ejemplo (`.env` o variables de entorno)
```
-- Conexiones se guardan en: ~/.local/share/db_ui/
-- Ejemplos:
-- mysql://user:pass@localhost:3306/laravel_db
-- postgresql://user:pass@localhost:5432/mydb
-- sqlite:./database/database.sqlite
```

### Integración con Laravel
- Leer automáticamente `.env` del proyecto para conexión
- Snippet de keybinding para abrir la BD del proyecto actual

### Keybindings sugeridos
```lua
{ "<leader>dB", "<cmd>DBUIToggle<cr>",        desc = "DB UI toggle" },
{ "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "DB add connection" },
{ "<leader>df", "<cmd>DBUIFindBuffer<cr>",    desc = "DB find buffer" },
```

### Treesitter SQL
```lua
-- Agregar a treesitter.lua
ensure_installed = { ..., "sql" }
```

### Tareas
- [ ] Crear `lua/plugins/custom/database.lua`
- [ ] Agregar `dadbod` como fuente en `completacion.lua`
- [ ] Agregar `sql` a Treesitter `ensure_installed`
- [ ] Agregar keybindings en `config/mappings.lua`
- [ ] Crear snippet para conexión Laravel desde `.env`
- [ ] Probar con MySQL y SQLite

---

## FASE 3 — ASISTENTE DE IA 🟡

### Objetivo
Integrar asistente de código con IA (Claude/Copilot/local) para autocompletado inteligente, explicación de código, generación y chat.

### Opción A: Avante.nvim (Recomendado — Claude/GPT/local)
```lua
-- lua/plugins/custom/ai.lua
{
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim", -- o snacks
    "echasnovski/mini.icons",
    "zbirenbaum/copilot.lua", -- opcional
    "HakonHarnes/img-clip.nvim", -- opcional para imágenes
  },
  opts = {
    provider = "claude",  -- o "openai", "copilot", "ollama"
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-6",
      temperature = 0,
      max_tokens = 8096,
    },
    -- Alternativa local con Ollama:
    -- provider = "ollama",
    -- ollama = { model = "codellama:13b" },
  },
},
```

### Opción B: CodeCompanion.nvim (más ligero, MCP-ready)
```lua
{
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = { adapter = "anthropic" },
      inline = { adapter = "anthropic" },
    },
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = { api_key = "ANTHROPIC_API_KEY" },
          schema = { model = { default = "claude-sonnet-4-6" } },
        })
      end,
    },
  },
},
```

### Opción C: Supermaven (completado IA ultra-rápido)
```lua
{
  "supermaven-inc/supermaven-nvim",
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",
      clear_suggestion  = "<C-]>",
      accept_word       = "<C-j>",
    },
  },
},
```

### Recomendación de implementación
1. **Supermaven** para completado inline rápido (gratuito, muy rápido)
2. **CodeCompanion** o **Avante** para chat y generación de código
3. Posibilidad de usar **Ollama** para modelo local sin costos

### Keybindings sugeridos (Avante)
```lua
{ "<leader>aa", "<cmd>AvanteAsk<cr>",    desc = "IA: Ask" },
{ "<leader>ae", "<cmd>AvanteEdit<cr>",   desc = "IA: Edit selection" },
{ "<leader>ar", "<cmd>AvanteRefresh<cr>",desc = "IA: Refresh" },
{ "<leader>at", "<cmd>AvanteToggle<cr>", desc = "IA: Toggle chat" },
```

### Variables de entorno necesarias
```bash
# ~/.zshrc o ~/.bashrc
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-..."       # opcional
```

### Preparación futura para MCP
- CodeCompanion tiene soporte nativo para MCP servers
- Permite conectar herramientas externas (DB, APIs, filesystem)
- Ver: https://codecompanion.olimorris.dev/extensions/mcphub

### Tareas
- [ ] Evaluar y elegir entre Avante vs CodeCompanion
- [ ] Crear `lua/plugins/custom/ai.lua`
- [ ] Configurar API keys como variables de entorno
- [ ] Agregar keybindings en `config/mappings.lua`
- [ ] Evaluar Supermaven para completado inline
- [ ] Documentar proceso de configuración con Ollama (opción local)

---

## FASE 4 — TESTING INTEGRADO 🟡

### Objetivo
Ejecutar y visualizar tests de PHPUnit/Pest y Vitest/Jest desde Neovim.

### Plugins a instalar
```lua
-- lua/plugins/custom/testing.lua
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",  -- ya instalado
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Adaptadores
    "olimorris/neotest-phpunit",
    "marilari88/neotest-vitest",
    -- opcional: "haydenmeade/neotest-jest",
  },
  opts = {
    adapters = {
      require("neotest-phpunit")({
        phpunit_cmd = function()
          return "vendor/bin/phpunit"
        end,
      }),
      require("neotest-vitest"),
    },
  },
},
```

### Keybindings sugeridos
```lua
{ "<leader>tr",  neotest.run.run,               desc = "Test: Run nearest" },
{ "<leader>tf",  function() neotest.run.run(vim.fn.expand("%")) end, desc = "Test: Run file" },
{ "<leader>ts",  neotest.run.stop,              desc = "Test: Stop" },
{ "<leader>to",  neotest.output.open,           desc = "Test: Output" },
{ "<leader>tO",  neotest.output_panel.toggle,   desc = "Test: Panel" },
{ "<leader>tS",  neotest.summary.toggle,        desc = "Test: Summary" },
{ "<leader>tw",  function() neotest.run.run({ jestCommand = "jest --watch" }) end, desc = "Test: Watch" },
```

### Tareas
- [ ] Crear `lua/plugins/custom/testing.lua`
- [ ] Instalar `neotest-phpunit` y `neotest-vitest`
- [ ] Agregar keybindings en `config/mappings.lua`
- [ ] Verificar que `vendor/bin/phpunit` existe en proyectos Laravel
- [ ] Configurar Pest si se usa en lugar de PHPUnit

---

## FASE 5 — COMPLETADO Y SNIPPETS 🟢

### 5.1 Snippets personalizados para Laravel/PHP
Crear `lua/snippets/php.lua` y `lua/snippets/blade.lua`:

```lua
-- Snippets PHP/Laravel útiles a crear:
-- "mig"  → migration boilerplate
-- "mod"  → Eloquent model con fillable, relations
-- "ctrl" → Resource controller completo
-- "req"  → Form request con rules()
-- "job"  → Job class con handle()
-- "evt"  → Event + Listener boilerplate
-- "api"  → API Resource boilerplate
-- "test" → Test case PHPUnit/Pest
-- "fact" → Factory con definition()
-- "seed" → Seeder boilerplate
```

### 5.2 Snippets Vue/TS
```lua
-- "sfc"  → Vue SFC completo <script setup> + <template> + <style>
-- "comp" → composable useX()
-- "pinia"→ Pinia store boilerplate
-- "api"  → composable de API con useAsyncData
-- "emit" → defineEmits con tipado TS
-- "prop" → defineProps con tipado TS
```

### 5.3 Mejorar blink.cmp
```lua
-- Agregar en completacion.lua:
-- Mayor scoring para LSP sobre buffer
-- Fuzzy matching más agresivo
-- Mostrar documentación automáticamente
appearance = {
  use_nvim_cmp_as_default = true,
  nerd_font_variant = "mono",
},
completion = {
  documentation = {
    auto_show = true,
    auto_show_delay_ms = 200,
  },
},
```

### Tareas
- [ ] Crear directorio `lua/snippets/`
- [ ] Crear `lua/snippets/php.lua` con snippets Laravel
- [ ] Crear `lua/snippets/blade.lua` con snippets Blade
- [ ] Crear `lua/snippets/vue.lua` con snippets Vue/TS
- [ ] Configurar LuaSnip para cargar snippets desde directorio
- [ ] Mejorar `auto_show` en blink.cmp

---

## FASE 6 — FORMATEO Y LINTING 🟢

### 6.1 Completar formateadores en Conform

```lua
-- Agregar a conform.lua:
formatters_by_ft = {
  lua          = { "stylua" },
  php          = { "php_cs_fixer" },
  blade        = { "blade-formatter" },  -- NUEVO
  vue          = { "prettier" },
  javascript   = { "prettier" },         -- NUEVO
  typescript   = { "prettier" },         -- NUEVO
  javascriptreact  = { "prettier" },     -- NUEVO
  typescriptreact  = { "prettier" },     -- NUEVO
  json         = { "prettier" },         -- NUEVO
  css          = { "prettier" },         -- NUEVO
  html         = { "prettier" },         -- NUEVO
  markdown     = { "prettier" },         -- NUEVO
},
```

### 6.2 Habilitar TailwindCSS LSP

```lua
-- features.lua
lsp = {
  ...
  tailwindcss = true,  -- HABILITAR
}
```

Crear `lsp/tailwindcss.lua`:
```lua
return {
  root_dir = require("lspconfig.util").root_pattern(
    "tailwind.config.js", "tailwind.config.ts",
    "postcss.config.js", "postcss.config.ts"
  ),
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
}
```

### 6.3 Agregar ESLint LSP

```lua
-- features.lua
lsp = {
  ...
  eslint = true,   -- NUEVO
}
```

Crear `lsp/eslint.lua`:
```lua
return {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
```

### 6.4 Agregar nvim-lint (linting desacoplado del LSP)
```lua
-- lua/plugins/custom/lint.lua
{
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      php        = { "phpstan" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      vue        = { "eslint_d" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function() require("lint").try_lint() end,
    })
  end,
},
```

### 6.5 Treesitter — lenguajes faltantes
```lua
-- Agregar a treesitter.lua ensure_installed:
"tsx", "vue", "sql", "graphql", "regex", "jsdoc", "typescript", "json5"
```

### Tareas
- [ ] Completar `formatters_by_ft` en `conform.lua`
- [ ] Instalar `blade-formatter` via Mason o npm
- [ ] Crear `lsp/tailwindcss.lua` y habilitar en features.lua
- [ ] Crear `lsp/eslint.lua` y habilitar en features.lua
- [ ] Crear `lua/plugins/custom/lint.lua` con nvim-lint
- [ ] Instalar `eslint_d` via Mason o npm global
- [ ] Actualizar `treesitter.lua` con lenguajes faltantes

---

## FASE 7 — PERFORMANCE Y LIMPIEZA 🟢

### 7.1 Resolver duplicidad ts_ls + vtsls

Actualmente ambos `ts_ls` y `vtsls` están activos. Evaluar:
- **Opción A:** Desactivar `ts_ls` y usar solo `vtsls` (recomendado para proyectos Vue)
- **Opción B:** Configurar `ts_ls` solo para archivos `.ts/.js` y `vtsls` para `.vue`

```lua
-- features.lua — recomendado:
lsp = {
  ts_ls  = false,  -- DESACTIVAR si se usa vtsls
  vtsls  = true,   -- mantener para Vue + TS
}
```

### 7.2 Lazy loading más agresivo

```lua
-- Plugins que pueden tener event más específico:
-- laravel.nvim → ft = { "php", "blade" }
-- trouble.nvim → cmd = { "Trouble" }
-- todo-comments → event = "BufReadPost"
-- flash.nvim → event = "BufReadPost"
```

### 7.3 Limpiar archivo vacío

Eliminar o dar uso a `lua/plugins/core/lsp.lua` (actualmente vacío).

### 7.4 Habilitar/remover spectre.nvim

- **Opción A:** Eliminar `lua/plugins/custom/spectre.lua`
- **Opción B:** Reemplazar con Snacks search (ya disponible via `<leader>sr`)

### 7.5 Optimizar updatetime y timeouts

```lua
-- options.lua — valores recomendados:
vim.opt.updatetime   = 200    -- 250 → 200
vim.opt.timeoutlen   = 300    -- default 1000 → más rápido
vim.opt.ttimeoutlen  = 10     -- escape más rápido
```

### 7.6 Foldado moderno con Treesitter

```lua
-- options.lua
vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false   -- desactivado por defecto, activar con zi
vim.opt.foldlevel  = 99
```

### Tareas
- [ ] Desactivar `ts_ls` si se confirma que `vtsls` cubre todas las necesidades
- [ ] Agregar `ft` events a plugins específicos de lenguaje
- [ ] Eliminar o rellenar `lua/plugins/core/lsp.lua`
- [ ] Decidir qué hacer con `spectre.nvim`
- [ ] Ajustar `timeoutlen` y `ttimeoutlen` en options.lua
- [ ] Implementar foldado con Treesitter

---

## FASE 8 — EXTRAS Y FUTURO 🔵

### 8.1 HTTP Client para APIs REST
```lua
{
  "mistweaverco/kulala.nvim",  -- o "rest-nvim/rest.nvim"
  ft = "http",
  opts = {},
  -- Permite ejecutar archivos .http directamente
  -- Ideal para probar endpoints Laravel API
},
```

### 8.2 Markdown Preview
```lua
{
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
  build = function() vim.fn.jobstart({"npm", "install"}, {cwd = ...}) end,
  ft = { "markdown" },
},
```

### 8.3 Soporte .env files
```lua
{
  "ellisonleao/dotenv.nvim",  -- highlighting para .env
  -- o instalar treesitter grammar "bash" con detección .env
},
```

### 8.4 Docker integration
```lua
-- Considerar: skanehira/denops-docker.nvim o
-- Acceso via terminal integrada (ya disponible con <C-'>)
```

### 8.5 Composer integration
```lua
-- laravel.nvim ya cubre mucho, pero evaluar:
-- Snippets para composer.json
-- Keybinding para composer install/update desde Neovim
```

### 8.6 Preparación para MCP (Model Context Protocol)
- CodeCompanion soporta MCP servers nativamente
- Permite al asistente IA acceder a:
  - Filesystem del proyecto
  - Base de datos vía dadbod
  - Git log y diff
  - Resultados de tests
  - Documentación externa

---

## CRONOGRAMA SUGERIDO

```
Semana 1:  Fase 1 (DAP/Debug) + Fase 6.1-6.3 (Formateo/Linting)
Semana 2:  Fase 2 (Bases de Datos) + Fase 5 (Snippets básicos)
Semana 3:  Fase 3 (IA - Avante/CodeCompanion)
Semana 4:  Fase 4 (Testing/Neotest) + Fase 7 (Performance/Limpieza)
Semana 5+: Fase 8 (Extras: HTTP, Markdown, MCP)
```

---

## CHECKLIST GENERAL DE PROGRESO

### Fase 1 — Debugging
- [ ] nvim-dap instalado
- [ ] nvim-dap-ui instalado
- [ ] nvim-dap-virtual-text instalado
- [ ] PHP debug adapter configurado
- [ ] JS/TS debug adapter configurado
- [ ] Keybindings F5-F12 configurados

### Fase 2 — Bases de Datos
- [ ] vim-dadbod instalado
- [ ] vim-dadbod-ui instalado
- [ ] vim-dadbod-completion integrado en blink.cmp
- [ ] SQL agregado a Treesitter
- [ ] Conexión Laravel .env funcional

### Fase 3 — IA
- [ ] Plugin IA elegido e instalado
- [ ] API key configurada en env
- [ ] Keybindings configurados
- [ ] Probado con código PHP y Vue

### Fase 4 — Testing
- [ ] neotest instalado
- [ ] neotest-phpunit configurado
- [ ] neotest-vitest configurado
- [ ] Keybindings configurados

### Fase 5 — Snippets
- [ ] Snippets PHP/Laravel creados
- [ ] Snippets Blade creados
- [ ] Snippets Vue/TS creados

### Fase 6 — Formateo/Linting
- [ ] JS/TS/JSON/CSS en conform.lua
- [ ] blade-formatter instalado
- [ ] TailwindCSS LSP habilitado
- [ ] ESLint LSP configurado
- [ ] nvim-lint instalado
- [ ] Treesitter tsx/vue/sql/graphql agregados

### Fase 7 — Performance
- [ ] ts_ls vs vtsls resuelto
- [ ] Lazy loading optimizado
- [ ] lsp.lua vacío limpiado
- [ ] spectre.nvim decidido
- [ ] timeoutlen ajustado
- [ ] Foldado con Treesitter habilitado

---

## NOTAS TÉCNICAS

### Compatibilidad blink.cmp + dadbod
blink.cmp requiere fuente `vim_dadbod_completion.blink` — verificar que la versión de dadbod-completion lo soporte, o usar `blink.compat` (ya instalado) como capa de compatibilidad.

### ts_ls vs vtsls
`vtsls` es el sucesor recomendado de `ts_ls` para proyectos con Vue. Ambos activos pueden causar conflictos en archivos `.ts`. Recomendación: desactivar `ts_ls` y usar `vtsls` exclusivamente.

### DAP + Xdebug en Laravel
Requiere Xdebug 3.x instalado en PHP con:
```ini
[xdebug]
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_port=9003
xdebug.client_host=127.0.0.1
```

### IA local con Ollama
Para no depender de APIs externas:
```bash
ollama pull codellama:13b   # para completado de código
ollama pull llama3.2:3b     # para chat rápido
```
Configurar Avante con `provider = "ollama"`.
