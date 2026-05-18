return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "williamboman/mason.nvim" },
                opts = {
                    automatic_installation = true,
                    handlers = {},
                    ensure_installed = { "php", "js", "python", "delve" },
                },
            },
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                         desc = "Debug: Toggle breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,                 desc = "Debug: Breakpoint condicional" },
            { "<leader>dc", function() require("dap").continue() end,                                                  desc = "Debug: Continue / Start" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                             desc = "Debug: Run to cursor" },
            { "<leader>di", function() require("dap").step_into() end,                                                 desc = "Debug: Step into" },
            { "<leader>do", function() require("dap").step_over() end,                                                 desc = "Debug: Step over" },
            { "<leader>dO", function() require("dap").step_out() end,                                                  desc = "Debug: Step out" },
            { "<leader>dp", function() require("dap").pause() end,                                                     desc = "Debug: Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                               desc = "Debug: REPL toggle" },
            { "<leader>dl", function() require("dap").run_last() end,                                                  desc = "Debug: Run last" },
            { "<leader>ds", function() require("dap").session() end,                                                   desc = "Debug: Sesión activa" },
            { "<leader>dt", function() require("dap").terminate() end,                                                 desc = "Debug: Terminar" },
            { "<leader>du", function() require("dapui").toggle() end,                                                  desc = "Debug: UI toggle" },
            { "<leader>de", function() require("dapui").eval() end,                                                    desc = "Debug: Eval expresión", mode = { "n", "v" } },
        },
        config = function()
            local dap    = require("dap")
            local dapui  = require("dapui")

            -- Signos en el gutter
            vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DapBreakpoint",          linehl = "",              numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "",              numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected",  { text = "○", texthl = "DapBreakpointRejected",  linehl = "",              numhl = "" })
            vim.fn.sign_define("DapLogPoint",            { text = "◎", texthl = "DapLogPoint",            linehl = "",              numhl = "" })
            vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })

            -- UI: abre y cierra automáticamente con la sesión
            dap.listeners.before.attach.dapui_config            = function() dapui.open() end
            dap.listeners.before.launch.dapui_config            = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config  = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config      = function() dapui.close() end

            -- Virtual text (valores inline mientras se debuggea)
            require("nvim-dap-virtual-text").setup({
                display_callback = function(variable, _, _, _, _)
                    if #variable.value > 50 then
                        return " = " .. variable.value:sub(1, 47) .. "..."
                    end
                    return " = " .. variable.value
                end,
            })

            -- Adaptadores por lenguaje
            require("config.dap.php")
            require("config.dap.javascript")
            require("config.dap.python")
            require("config.dap.go")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        opts = {
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            layouts = {
                {
                    elements = {
                        { id = "scopes",      size = 0.40 },
                        { id = "breakpoints", size = 0.20 },
                        { id = "stacks",      size = 0.20 },
                        { id = "watches",     size = 0.20 },
                    },
                    size = 40,
                    position = "left",
                },
                {
                    elements = {
                        { id = "repl",    size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                    size = 12,
                    position = "bottom",
                },
            },
            controls = {
                enabled = true,
                element = "repl",
                icons = {
                    pause        = "",
                    play         = "",
                    step_into    = "",
                    step_over    = "",
                    step_out     = "",
                    step_back    = "",
                    run_last     = "",
                    terminate    = "",
                    disconnect   = "",
                },
            },
            floating = { border = "rounded" },
        },
    },
}
