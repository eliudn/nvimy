return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "olimorris/neotest-phpunit",
            "marilari88/neotest-vitest",
        },
        keys = {
            { "<leader>tr", function() require("neotest").run.run() end,                              desc = "Test: Run nearest" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,            desc = "Test: Run file" },
            { "<leader>ts", function() require("neotest").run.stop() end,                             desc = "Test: Stop" },
            { "<leader>to", function() require("neotest").output.open({ enter = true }) end,          desc = "Test: Output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end,                  desc = "Test: Panel" },
            { "<leader>tS", function() require("neotest").summary.toggle() end,                       desc = "Test: Summary" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-phpunit")({
                        phpunit_cmd = function()
                            -- Soporta vendor/bin/phpunit y ./vendor/bin/pest
                            if vim.fn.filereadable("vendor/bin/pest") == 1 then
                                return "vendor/bin/pest"
                            end
                            return "vendor/bin/phpunit"
                        end,
                        root_files = { "composer.json", "phpunit.xml", "phpunit.xml.dist" },
                    }),
                    require("neotest-vitest"),
                },
                -- Mostrar output inline más compacto
                output = {
                    open_on_run = "short",
                },
                -- Iconos en el gutter
                icons = {
                    passed  = "✓",
                    failed  = "✗",
                    running = "⟳",
                    skipped = "⊘",
                    unknown = "?",
                },
            })
        end,
    },
}
