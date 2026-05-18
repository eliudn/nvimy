local dap = require("dap")

local adapter_path = vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js"

dap.adapters.php = {
    type = "executable",
    command = "node",
    args = { adapter_path },
}

dap.configurations.php = {
    {
        type    = "php",
        request = "launch",
        name    = "PHP: Listen for Xdebug",
        port    = 9003,
    },
    {
        type    = "php",
        request = "launch",
        name    = "PHP: Listen (Docker / Sail)",
        port    = 9003,
        -- Mapea la ruta del contenedor a la ruta local del proyecto.
        -- Ajusta la clave según el workdir de tu contenedor (ej. /app, /srv/app).
        pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
        },
    },
    {
        type    = "php",
        request = "launch",
        name    = "PHP: Artisan CLI",
        port    = 9003,
        -- Lanza el comando manualmente con:
        -- XDEBUG_MODE=debug php -dxdebug.start_with_request=yes artisan <cmd>
    },
}
