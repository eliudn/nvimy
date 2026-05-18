local dap = require("dap")

local adapter_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

-- Un solo adapter sirve para Node y para Chrome
for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
    dap.adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            args    = { adapter_path, "${port}" },
        },
    }
end

local configs = {
    {
        type    = "pwa-node",
        request = "launch",
        name    = "Node: Launch file",
        program = "${file}",
        cwd     = "${workspaceFolder}",
    },
    {
        type      = "pwa-node",
        request   = "attach",
        name      = "Node: Attach a proceso",
        processId = require("dap.utils").pick_process,
        cwd       = "${workspaceFolder}",
    },
    {
        type                    = "pwa-node",
        request                 = "launch",
        name                    = "Vitest: Debug tests",
        cwd                     = "${workspaceFolder}",
        program                 = "${workspaceFolder}/node_modules/.bin/vitest",
        args                    = { "--reporter=verbose" },
        autoAttachChildProcesses = true,
        smartStep               = true,
        console                 = "integratedTerminal",
        env                     = { CI = "true" },
    },
    {
        type       = "pwa-chrome",
        request    = "launch",
        name       = "Chrome: Vite dev server",
        url        = "http://localhost:5173",
        webRoot    = "${workspaceFolder}/src",
        sourceMaps = true,
    },
    {
        type       = "pwa-chrome",
        request    = "launch",
        name       = "Chrome: URL personalizada",
        url        = function() return vim.fn.input("URL: ", "http://localhost:") end,
        webRoot    = "${workspaceFolder}/src",
        sourceMaps = true,
    },
}

for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }) do
    dap.configurations[lang] = configs
end
