# Registro de Cambios — Neovim Config
> Implementación de Fases 4–7 del Plan de Mejoras
> Fecha de implementación: 2026-03-24
> Stack objetivo: PHP/Laravel · JS/TS/Vue · Testing · IA · DB

---

## ÍNDICE RÁPIDO

| Fase | Área | Archivos Afectados |
|------|------|--------------------|
| [4](#fase-4--testing-integrado) | Testing integrado (neotest) | `testing.lua`, `mappings.lua` |
| [5](#fase-5--snippets-y-completado) | Snippets PHP/Blade/Vue + blink.cmp | `snippets/`, `completacion.lua` |
| [6](#fase-6--formateo-y-linting) | Formateo completo + ESLint + TailwindCSS | `conform.lua`, `lint.lua`, `lsp/`, `treesitter.lua`, `features.lua` |
| [7](#fase-7--performance-y-limpieza) | Performance + limpieza | `options.lua`, `features.lua`, `lsp.lua`, `spectre.lua` |

---

## FASE 4 — Testing Integrado

### ¿Qué se hizo?

Se creó `lua/plugins/custom/testing.lua` con **neotest** y dos adaptadores:
- `neotest-phpunit` → corre PHPUnit o Pest en proyectos Laravel
- `neotest-vitest` → corre Vitest en proyectos JS/TS/Vue

### ¿Por qué?

Sin neotest no había manera de correr tests desde Neovim. El flujo anterior requería cambiar a la terminal. Con neotest los tests se ven inline en el buffer con iconos de ✓/✗ y se puede navegar a failures directamente.

### Decisiones técnicas

- La función `phpunit_cmd` detecta automáticamente si el proyecto usa **Pest** (`vendor/bin/pest`) o PHPUnit estándar (`vendor/bin/phpunit`). Así funciona con ambos frameworks sin configuración extra.
- `output.open_on_run = "short"` muestra output compacto para no bloquear el flujo.
- Los keybindings usan el prefijo `<leader>t` (t = test):

| Key | Acción |
|-----|--------|
| `<leader>tr` | Correr test más cercano al cursor |
| `<leader>tf` | Correr todos los tests del archivo |
| `<leader>ts` | Detener tests |
| `<leader>to` | Ver output del test |
| `<leader>tO` | Toggle panel de output |
| `<leader>tS` | Toggle resumen de tests |

### Archivos creados/modificados
- ✅ **CREADO**: `lua/plugins/custom/testing.lua`
- ✅ **MODIFICADO**: `lua/config/mappings.lua` — keybindings `<leader>t*`

---

## FASE 5 — Snippets y Completado

### ¿Qué se hizo?

Se crearon snippets en Lua para tres lenguajes del stack, más mejoras a blink.cmp.

#### Snippets PHP/Laravel (`lua/snippets/php.lua`)

| Trigger | Genera |
|---------|--------|
| `mig`   | Migration con Schema::create completo |
| `mod`   | Eloquent Model con fillable |
| `ctrl`  | Resource Controller con todos los métodos |
| `req`   | Form Request con authorize() y rules() |
| `job`   | Job class con ShouldQueue + handle() |
| `evt`   | Event con Dispatchable |
| `api`   | API Resource con toArray() |
| `test`  | TestCase con RefreshDatabase |
| `fact`  | Factory con definition() |
| `seed`  | Seeder con run() |

#### Snippets Blade (`lua/snippets/blade.lua`)

| Trigger | Genera |
|---------|--------|
| `layout` | HTML base con @vite y @yield |
| `comp`   | Component con @props |
| `fore`   | @forelse ... @empty ... @endforelse |
| `ifsec`  | @if ... @else ... @endif |
| `form`   | Form con @csrf y route() |
| `auth`   | @auth ... @guest |
| `inc`    | @include con datos |
| `sec`    | @section ... @endsection |
| `live`   | @livewire() |

#### Snippets Vue/TS (`lua/snippets/vue.lua`)

| Trigger | Genera |
|---------|--------|
| `sfc`    | SFC completo: script setup + template + style |
| `prop`   | defineProps<{}> tipado |
| `emit`   | defineEmits<{}> tipado |
| `comp`   | Composable useX() con ref/computed |
| `pinia`  | Store Pinia con defineStore |
| `fetch`  | Composable de API con loading/error |
| `ref`    | ref<T>(value) tipado |
| `comp2`  | computed<T>() tipado |
| `watch`  | watch(source, fn) |
| `onm`    | onMounted(() => {}) |

También incluye snippets TypeScript: `iface`, `type`, `afn` (async function).

#### Mejoras a blink.cmp (`completacion.lua`)

- **LuaSnip ahora carga los snippets Lua** con `from_lua.load()` apuntando a `lua/snippets/`.
- **Documentación automática**: `auto_show = true` con delay de 200ms. Antes la doc no aparecía sola, había que abrirla manualmente.

### ¿Por qué?

`friendly-snippets` solo tiene snippets genéricos. Los snippets de Laravel/PHP, Blade y Vue son específicos del stack y no existían. Crearlos en formato LuaSnip Lua permite usar insert nodes, function nodes y fmt para plantillas con múltiples campos de salto.

La doc automática de blink.cmp es crítica para LSP: ver la firma de un método mientras se escribe sin abrir un hover manual.

### Archivos creados/modificados
- ✅ **CREADO**: `lua/snippets/php.lua`
- ✅ **CREADO**: `lua/snippets/blade.lua`
- ✅ **CREADO**: `lua/snippets/vue.lua`
- ✅ **MODIFICADO**: `lua/plugins/core/completacion.lua` — loader Lua + auto_show

---

## FASE 6 — Formateo y Linting

### ¿Qué se hizo?

Cuatro cambios principales:

#### 6.1 Conform.nvim — formatadores completos

Antes solo se formateaban Lua, PHP y Vue. Ahora:

```
lua, php, blade, vue, javascript, typescript,
javascriptreact, typescriptreact, json, jsonc,
css, html, markdown
```

- `blade_formatter` para templates Blade (instalar: `npm i -g blade-formatter` o via Mason)
- `prettier` unificado para todo el ecosistema JS/TS

#### 6.2 TailwindCSS LSP (`lsp/tailwindcss.lua`)

- Habilitado en `features.lua` (`tailwindcss = true`)
- Detecta proyectos por `tailwind.config.js/ts` y `postcss.config.js/ts`
- Soporte para `cva()` y `cx()` (class-variance-authority) — común en proyectos modernos Vue
- Cubre PHP, Blade, Vue, HTML, CSS, JS, TS

#### 6.3 ESLint LSP (`lsp/eslint.lua`)

- Habilitado en `features.lua` (`eslint = true`)
- **Auto-fix al guardar** via `BufWritePre` + `EslintFixAll`
- `format = false` — ESLint solo corrige errores de reglas, prettier sigue siendo el formateador
- Detecta configuración por `eslint.config.js`, `.eslintrc.*`, etc.

#### 6.4 nvim-lint (`lua/plugins/custom/lint.lua`)

Linting desacoplado del LSP:
- PHP → phpstan (análisis estático)
- JS/TS/Vue → eslint_d (versión demonio, más rápida que eslint)
- Se ejecuta en `BufWritePost` y `BufReadPost`
- `ignore_errors = true` para no mostrar errores si el linter no está instalado

#### 6.5 Treesitter — lenguajes agregados

Se agregaron a `ensure_installed`:
`typescript`, `tsx`, `vue`, `sql`, `graphql`, `regex`, `jsdoc`, `json`, `json5`, `markdown_inline`, `phpdoc`

### ¿Por qué?

- JS/TS no tenía formateador asignado — `prettier` existía instalado pero nunca se llamaba
- Blade templates tampoco tenían formateador
- TailwindCSS LSP es esencial para proyectos Laravel + Vite + Tailwind (completado de clases)
- ESLint como LSP da diagnósticos inline más completos que nvim-lint solo
- nvim-lint complementa al LSP con análisis estático (phpstan detecta tipos incorrectos que phpactor no reporta)
- Treesitter sin `tsx`/`vue`/`typescript` explícitos significa que el highlighting de esos archivos dependía de `auto_install` en vez de estar garantizado

### Archivos creados/modificados
- ✅ **MODIFICADO**: `lua/plugins/custom/conform.lua` — 9 tipos de archivo nuevos
- ✅ **CREADO**: `lsp/tailwindcss.lua`
- ✅ **CREADO**: `lsp/eslint.lua`
- ✅ **CREADO**: `lua/plugins/custom/lint.lua`
- ✅ **MODIFICADO**: `lua/config/features.lua` — tailwindcss y eslint habilitados
- ✅ **MODIFICADO**: `lua/plugins/core/treesitter.lua` — 11 lenguajes añadidos

---

## FASE 7 — Performance y Limpieza

### ¿Qué se hizo?

#### 7.1 Desactivar ts_ls (duplicidad resuelta)

En `features.lua`: `ts_ls = false`

**Problema**: `ts_ls` y `vtsls` corrían simultáneamente en archivos `.ts`. Ambos proveen las mismas funcionalidades (go-to-def, references, hover, rename). Esto causaba duplicados en completado y conflictos potenciales en rename/refactor.

**Solución**: `vtsls` es el sucesor moderno de `ts_ls`, tiene mejor integración con Vue via `@vue/typescript-plugin`, y cubre exactamente los mismos archivos. Se desactiva `ts_ls` completamente.

#### 7.2 Foldado con Treesitter

Se añadió a `options.lua`:
```lua
vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false  -- zi para activar
vim.opt.foldlevel  = 99
```

- `foldenable = false` significa que abre todos los archivos sin colapsar nada
- `zi` activa el foldado cuando se necesite
- `za` colapsa/expande el fold actual
- `zM`/`zR` colapsa/expande todo

#### 7.3 Limpieza de `lua/plugins/core/lsp.lua`

Este archivo era un residuo con solo `return {}` y código comentado. Se reemplazó con un comentario claro que explica que LSP se configura en `after/plugin/lsp.lua`. Así queda documentado el propósito del archivo sin generar confusión.

#### 7.4 Eliminación de `spectre.nvim`

`lua/plugins/custom/spectre.lua` fue eliminado. Razones:
1. Tenía `if true then return {} end` — nunca se cargaba
2. La funcionalidad de buscar/reemplazar ya existe via Snacks (`<leader>sr` usa Snacks search)
3. Mantener un archivo deshabilitado sin propósito genera ruido en la configuración

### Archivos creados/modificados
- ✅ **MODIFICADO**: `lua/config/features.lua` — `ts_ls = false`
- ✅ **MODIFICADO**: `lua/config/options.lua` — folding con Treesitter
- ✅ **MODIFICADO**: `lua/plugins/core/lsp.lua` — comentario de propósito
- ✅ **ELIMINADO**: `lua/plugins/custom/spectre.lua`

---

## RESUMEN DE TODOS LOS CAMBIOS

### Archivos nuevos creados (7)
```
lua/plugins/custom/testing.lua    → neotest + phpunit + vitest
lua/plugins/custom/lint.lua       → nvim-lint (phpstan + eslint_d)
lua/snippets/php.lua              → 10 snippets Laravel/PHP
lua/snippets/blade.lua            → 9 snippets Blade
lua/snippets/vue.lua              → 10 snippets Vue/TS + 3 TS
lsp/tailwindcss.lua               → TailwindCSS LSP config
lsp/eslint.lua                    → ESLint LSP con auto-fix
```

### Archivos modificados (6)
```
lua/plugins/custom/conform.lua        → +9 tipos de archivo formateados
lua/plugins/core/completacion.lua     → loader Lua snippets + doc auto_show
lua/plugins/core/treesitter.lua       → +11 lenguajes
lua/config/features.lua               → ts_ls=false, tailwindcss/eslint=true
lua/config/options.lua                → folding Treesitter
lua/config/mappings.lua               → keybindings <leader>t*
lua/plugins/core/lsp.lua              → comentario descriptivo
```

### Archivos eliminados (1)
```
lua/plugins/custom/spectre.lua        → deshabilitado, reemplazado por Snacks
```

---

## PENDIENTE PARA COMPLETAR EL SETUP

### Herramientas externas requeridas (instalar manualmente)

```bash
# blade-formatter (para formatear Blade templates)
npm install -g blade-formatter

# eslint_d (linter JS/TS rápido para nvim-lint)
npm install -g eslint_d

# O via Mason en Neovim:
# :MasonInstall blade-formatter eslint_d tailwindcss-language-server
```

### Para que funcione el debug (Fase 1, ya implementada anteriormente)
```bash
# Xdebug en php.ini debe tener:
# xdebug.mode=debug
# xdebug.start_with_request=yes
# xdebug.client_port=9003
```

### Variables de entorno para IA (Fase 3, ya implementada)
```bash
# ~/.zshrc
export ANTHROPIC_API_KEY="sk-ant-..."
```

---

## NOTAS PARA FUTURA IA

- Este archivo fue creado para ser leído por Claude Code en futuras conversaciones
- Los snippets están en formato LuaSnip Lua (no VsCode JSON)
- `features.lua` es el panel de control de LSPs — modificar aquí para habilitar/deshabilitar
- `ts_ls` está desactivado intencionalmente — usar `vtsls` para todo JS/TS/Vue
- `tailwindcss` solo se activa en proyectos con `tailwind.config.*` (no afecta proyectos sin Tailwind)
- `eslint` usa `vscode-eslint-language-server` que viene de Mason como `eslint-lsp`
- Los tests de PHP detectan automáticamente PHPUnit vs Pest — no hay que configurar por proyecto
