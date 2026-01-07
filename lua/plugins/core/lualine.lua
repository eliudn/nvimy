---@diagnostic disable: param-type-mismatch
local y_section = {}

y_section = {
    {
        function()
            local ok, laravel_version = pcall(function()
                return Laravel.app("status"):get("laravel")
            end)
            if ok then
                return laravel_version
            end
        end,
        icon = { " ", color = { fg = "#F55247" } },
        cond = function()
            local ok, has_laravel_versions = pcall(function()
                return Laravel.app("status"):has("laravel")
            end)
            return ok and has_laravel_versions
        end,
    },
    {
        function()
            local ok, php_version = pcall(function()
                return Laravel.app("status"):get("php")
            end)
            if ok then
                return php_version
            end
            return nil
        end,
        icon = { " ", color = { fg = "#AEB2D5" } },
        cond = function()
            local ok, has_php_version = pcall(function()
                return Laravel.app("status"):has("php")
            end)
            return ok and has_php_version
        end,
    },
    {
        function()
            local ok, hostname = pcall(function()
                return Laravel.extensions.composer_dev.hostname()
            end)
            if ok then
                return hostname
            end
            return nil
        end,
        icon = { " ", color = { fg = "#8FBC8F" } },
        cond = function()
            local ok, is_running = pcall(function()
                return Laravel.extensions.composer_dev.isRunning()
            end)
            return ok and is_running
        end,
    },
    {
        function()
            local ok, unseen_records = pcall(function()
                return #(Laravel.extensions.dump_server.unseenRecords())
            end)

            if ok then
                return unseen_records
            end
            return 0
        end,
        icon = { "󰱧 ", color = { fg = "#FFCC66" } },
        cond = function()
            local ok, is_running = pcall(function()
                return Laravel.extensions.dump_server.isRunning()
            end)

            return ok and is_running
        end,
    },
}
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
            },
            sections = {
                lualine_a = { { 'mode', icon = "" } },
                lualine_b = {
                    { 'branch', icon = '' },
                    { 'diff', symbols = { added = ' ', modified = '󰝤 ', removed = ' ' } }
                },
                lualine_c = {
                    { get_project_name, color = { fg = "#ff9e64", gui = "bold" } }, -- Nombre del proyecto
                    { 'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { 'filename', path = 1, symbols = { modified = "  ", readonly = "  ", unnamed = " [Sin nombre] " } },
                },
                lualine_x = {
                    { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' } },
                    { lsp_status, color = { fg = "#7aa2f7" } }, -- Muestra tu lua_ls, phpactor, etc.
                },
                lualine_y = y_section,
                -- lualine_y = {
                --     { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } },
                --     'encoding',
                --     'filesize' -- Muy útil para saber si el archivo es pesado
                -- },
                -- lualine_z = {
                --     { 'location', icon = "" },
                --     { 'progress', separator = " ", padding = { left = 0, right = 1 } },
                -- },
            },
        }
    end,
}
