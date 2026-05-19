---@diagnostic disable: param-type-mismatch

local function find_project_root()
    local root = vim.fs.find({ ".git", "composer.json", "Cargo.toml", "pyproject.toml",
        "requirements.txt", "package.json", "go.mod" }, {
        path = vim.fn.expand("%:p:h"),
        upward = true,
    })[1]
    return root and vim.fn.fnamemodify(root, ":h") or vim.fn.getcwd()
end

local function is_laravel()
    local root = find_project_root()
    return vim.fn.filereadable(root .. "/artisan") == 1
end

local function is_python()
    local root = find_project_root()
    return vim.fn.filereadable(root .. "/pyproject.toml") == 1
        or vim.fn.filereadable(root .. "/requirements.txt") == 1
        or vim.fn.filereadable(root .. "/setup.py") == 1
end

local function is_rust()
    local root = find_project_root()
    return vim.fn.filereadable(root .. "/Cargo.toml") == 1
end

local function is_js()
    local root = find_project_root()
    return vim.fn.filereadable(root .. "/package.json") == 1
        and vim.fn.filereadable(root .. "/artisan") == 0
end

local function is_lua_project()
    if is_laravel() or is_python() or is_rust() or is_js() then return false end
    return vim.bo.filetype == "lua"
end

-- Componentes Laravel
local laravel_components = {
    {
        function()
            local ok, v = pcall(function() return Laravel.app("status"):get("laravel") end)
            return ok and v or nil
        end,
        icon = { " ", color = { fg = "#F55247" } },
        cond = function()
            if not is_laravel() then return false end
            local ok, has = pcall(function() return Laravel.app("status"):has("laravel") end)
            return ok and has
        end,
    },
    {
        function()
            local ok, v = pcall(function() return Laravel.app("status"):get("php") end)
            return ok and v or nil
        end,
        icon = { " ", color = { fg = "#AEB2D5" } },
        cond = function()
            if not is_laravel() then return false end
            local ok, has = pcall(function() return Laravel.app("status"):has("php") end)
            return ok and has
        end,
    },
    {
        function()
            local ok, h = pcall(function() return Laravel.extensions.composer_dev.hostname() end)
            return ok and h or nil
        end,
        icon = { " ", color = { fg = "#8FBC8F" } },
        cond = function()
            if not is_laravel() then return false end
            local ok, running = pcall(function() return Laravel.extensions.composer_dev.isRunning() end)
            return ok and running
        end,
    },
    {
        function()
            local ok, n = pcall(function() return #(Laravel.extensions.dump_server.unseenRecords()) end)
            return ok and n or 0
        end,
        icon = { "ï§ ", color = { fg = "#FFCC66" } },
        cond = function()
            if not is_laravel() then return false end
            local ok, running = pcall(function() return Laravel.extensions.dump_server.isRunning() end)
            return ok and running
        end,
    },
}

-- Componente Python: venv activo
local python_component = {
    function()
        local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV")
        if venv then
            return vim.fn.fnamemodify(venv, ":t")
        end
        local root = find_project_root()
        local f = io.open(root .. "/.python-version", "r")
        if f then
            local ver = f:read("*l"); f:close()
            return ver
        end
        return vim.fn.exepath("python3") ~= "" and "python3" or "python"
    end,
    icon = { " ", color = { fg = "#4B8BBE" } },
    color = { fg = "#FFE873" },
    cond = is_python,
}

-- Componente Rust: edicion del crate
local rust_component = {
    function()
        local root = find_project_root()
        local f = io.open(root .. "/Cargo.toml", "r")
        if f then
            for line in f:lines() do
                local edition = line:match('^edition%s*=%s*"(%d+)"')
                if edition then f:close(); return "edition " .. edition end
            end
            f:close()
        end
        return "cargo"
    end,
    icon = { " ", color = { fg = "#CE412B" } },
    color = { fg = "#F74C00" },
    cond = is_rust,
}

-- Componente JS/TS: package manager + Node version
local js_component = {
    function()
        local root = find_project_root()
        local pm = "npm"
        if vim.fn.filereadable(root .. "/bun.lockb") == 1 then
            pm = "bun"
        elseif vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then
            pm = "pnpm"
        elseif vim.fn.filereadable(root .. "/yarn.lock") == 1 then
            pm = "yarn"
        end
        local node = vim.fn.system("node --version 2>/dev/null"):gsub("%s+", "")
        return node ~= "" and (pm .. " Â· " .. node) or pm
    end,
    icon = { "󰎝 ", color = { fg = "#F7DF1E" } },
    color = { fg = "#83CD29" },
    cond = is_js,
}

-- Componente Lua: version de Lua o contexto Neovim
local lua_component = {
    function()
        if vim.fn.expand("%:p"):find(vim.fn.stdpath("config"), 1, true) then
            return "nvim " .. tostring(vim.version())
        end
        local ver = vim.fn.system("lua -v 2>&1"):match("Lua%s+([%d%.]+)")
            or vim.fn.system("luajit -v 2>&1"):match("LuaJIT%s+([%d%.%-]+)")
        return ver and ("lua " .. ver) or "lua"
    end,
    icon = { " ", color = { fg = "#00AAFF" } },
    color = { fg = "#7FDBFF" },
    cond = is_lua_project,
}

-- Fallback: filetype + encoding si no es UTF-8
local fallback_component = {
    function()
        local enc = vim.opt.fileencoding:get()
        if enc ~= "" and enc ~= "utf-8" then
            return enc:upper()
        end
        local ft = vim.bo.filetype
        return ft ~= "" and ft or "plain"
    end,
    icon = { "󰈙 ", color = { fg = "#888888" } },
    color = { fg = "#aaaaaa" },
    cond = function()
        return not is_laravel() and not is_python() and not is_rust()
            and not is_js() and not is_lua_project()
    end,
}

local y_section = vim.list_extend(
    vim.deepcopy(laravel_components),
    { python_component, rust_component, js_component, lua_component, fallback_component }
)
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        -- Función para obtener el nombre del proyecto usando Snacks

        local function get_project_name()
            -- Intenta obtener la raíz de git primero
            local root = Snacks.git.get_root()

            -- Si no hay git, busca marcadores de proyecto
            if not root then
                local markers = {
                    "package.json", "Cargo.toml", "go.mod",
                    "pom.xml", "requirements.txt", "setup.py",
                    "composer.json", "Makefile", "CMakeLists.txt",
                    ".git"
                }

                local current_file = vim.fn.expand("%:p:h")
                local found = vim.fs.find(markers, {
                    path = current_file,
                    upward = true
                })[1]

                if found then
                    root = vim.fn.fnamemodify(found, ":h")
                else
                    -- Fallback al directorio de trabajo actual
                    root = vim.fn.getcwd()
                end
            end

            return "󱉭  " .. vim.fn.fnamemodify(root, ":t")
        end

        -- Función para ver qué LSP y Formateadores están activos
        local function lsp_status()
            local msg = 'No LSP'
            -- local buf_ft = vim.api.nvim_get_current_buf_option(0, 'filetype')
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then return msg end

            local client_names = {}
            for _, client in ipairs(clients) do
                table.insert(client_names, client.name)
            end
            return "  " .. table.concat(client_names, ', ')
        end

        return {
            options = {
                theme = "auto",
                component_separators = { left = '󰿟', right = '󰿟' },
                section_separators = { left = '', right = '' },
                globalstatus = true, -- Importante para que combine con cmdheight = 0
                disabled_filetypes = { statusline = { "dashboard", "alpha", "snacks_dashboard" } },
                winbar          = {},
                inactive_winbar = {},
            },
            sections = {
                lualine_a = { { 'mode', icon = "" } },
                lualine_b = {
                    { 'branch', icon = '' },
                    { 'diff', symbols = { added = ' ', modified = '󰝤 ', removed = ' ' } }
                },
                lualine_c = {
                    { get_project_name, color = { fg = "#ff9f5e", gui = "bold" } }, -- Nombre del proyecto
                    { 'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { 'filename', path = 1, symbols = { modified = "  ", readonly = "  ", unnamed = " [Sin nombre] " } },
                },
                lualine_x = {
                    { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' } },
                    { lsp_status, color = { fg = "#5ea1ff" } }, -- Muestra tu lua_ls, phpactor, etc.
                },
                lualine_y = y_section,
                lualine_z = {
                    { 'location', icon = "" },
                    { 'progress', separator = " ", padding = { left = 0, right = 1 } },
                },
            },
        }
    end,
}
