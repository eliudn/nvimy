local dap = require("dap")

local delve_path = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv"

-- Delve soporta launch (proceso nuevo) y attach remote (delve ya corriendo)
dap.adapters.delve = function(cb, config)
    if config.mode == "remote" and config.request == "attach" then
        cb({
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or "38697",
        })
    else
        cb({
            type = "server",
            port = "${port}",
            executable = {
                command = delve_path,
                args    = { "dap", "-l", "127.0.0.1:${port}" },
            },
        })
    end
end

dap.configurations.go = {
    {
        type    = "delve",
        request = "launch",
        name    = "Go: Debug file",
        program = "${file}",
    },
    {
        type    = "delve",
        request = "launch",
        name    = "Go: Debug package",
        program = "${workspaceFolder}",
    },
    {
        type    = "delve",
        request = "launch",
        name    = "Go: Debug con args",
        program = "${workspaceFolder}",
        args    = function()
            local input = vim.fn.input("Args: ")
            return vim.split(input, " ", { plain = true, trimempty = true })
        end,
    },
    {
        type    = "delve",
        request = "launch",
        name    = "Go: Debug test (archivo)",
        mode    = "test",
        program = "${file}",
    },
    {
        type    = "delve",
        request = "launch",
        name    = "Go: Debug test (package)",
        mode    = "test",
        program = "${workspaceFolder}",
    },
    {
        type    = "delve",
        request = "attach",
        name    = "Go: Attach remoto (dlv headless)",
        mode    = "remote",
        host    = "127.0.0.1",
        port    = "38697",
    },
}
