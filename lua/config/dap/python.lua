local dap = require("dap")

local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

-- El adapter soporta launch (proceso nuevo) y attach (proceso ya corriendo)
dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        cb({
            type    = "server",
            host    = (config.connect or config).host or "127.0.0.1",
            port    = assert((config.connect or config).port, "Falta puerto para attach de debugpy"),
            options = { source_filetype = "python" },
        })
    else
        cb({
            type    = "executable",
            command = debugpy_path,
            args    = { "-m", "debugpy.adapter" },
            options = { source_filetype = "python" },
        })
    end
end

-- Detecta el intérprete correcto: env var > .venv local > sistema
local function python_path()
    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    if venv then return venv .. "/bin/python" end
    for _, name in ipairs({ ".venv", "venv", "env" }) do
        local path = vim.fn.getcwd() .. "/" .. name .. "/bin/python"
        if vim.fn.filereadable(path) == 1 then return path end
    end
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

dap.configurations.python = {
    {
        type       = "python",
        request    = "launch",
        name       = "Python: Launch file",
        program    = "${file}",
        pythonPath = python_path,
    },
    {
        type       = "python",
        request    = "launch",
        name       = "Python: Launch module",
        module     = function() return vim.fn.input("Módulo: ") end,
        pythonPath = python_path,
    },
    {
        type    = "python",
        request = "attach",
        name    = "Python: Attach a debugpy (puerto 5678)",
        connect = { host = "127.0.0.1", port = 5678 },
    },
    {
        type       = "python",
        request    = "launch",
        name       = "Django: runserver",
        program    = "${workspaceFolder}/manage.py",
        args       = { "runserver", "--noreload" },
        pythonPath = python_path,
        django     = true,
    },
    {
        type       = "python",
        request    = "launch",
        name       = "FastAPI: uvicorn",
        module     = "uvicorn",
        args       = function()
            local app = vim.fn.input("App (ej. main:app): ", "main:app")
            return { app, "--reload" }
        end,
        pythonPath = python_path,
        console    = "integratedTerminal",
    },
}
