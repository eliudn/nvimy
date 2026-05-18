return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        opts = {
            language = "Spanish",
        },
        -- Nueva estructura: adapters.http
        adapters = {
            http = {
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = { api_key = "ANTHROPIC_API_KEY2" },
                        schema = { model = { default = "claude-sonnet-4-6" } },
                    })
                end,
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        env = { api_key = "GEMINI_API_KEY" },
                        schema = {
                            model = {
                                default = "gemini-3-flash-preview", -- free tier real
                            },
                        }
                    })
                end,

            },

            acp = {
                gemini_cli = function()
                    return require("codecompanion.adapters").extend("gemini_cli", {
                        commands = {
                            default = {
                                "gemini", -- el binario a ejecutar
                                "--experimental-acp", -- argumento que activa el protocolo ACP
                            },
                        },
                        defaults = {
                            -- auth_method = "gemini-api-key",
                            model = "gemini-3-flash-preview"
                        },
                        env = {
                            GEMINI_API_KEY = "GEMINI_API_KEY", }
                    })
                end
            }
        },

        -- Nueva estructura: interactions en lugar de strategies
        interactions = {
            chat       = { adapter = "gemini_cli" },
            inline     = { adapter = "gemini_cli" },
            cmd        = { adapter = "gemini_cli" },
            background = {
                adapter = "gemini_cli"
            },
            cli        = {
                agent = "claude_code",
                agents = {
                    claude_code = {
                        cmd         = "claude",
                        args        = {},
                        description = "Claude Code CLI",
                        provider    = "terminal",
                    },
                },
            },

        },

        -- Action palette via snacks (ya lo tienes instalado)
        display = {
            action_palette = {
                provider = "snacks",
            },
            chat = {
                window = {
                    layout = "vertical",
                    width  = 0.35,
                },
                show_token_count = true,
            },
            inline = {
                diff = {
                    enabled  = true,
                    provider = "mini_diff",
                },
            },
        },
    },

    keys = {
        { "<leader>aa", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" },                desc = "AI: Actions" },
        -- { "<leader>cc", "<cmd>CodeCompanionCLI<cr>",         desc = "AI: Claude Code CLI" },
        { "<leader>ct", "<cmd>CodeCompanionCLI Toggle<cr>",  desc = "AI: Toggle Claude Code CLI" },
        { "<leader>ac", "<cmd>CodeCompanionChat<cr>",        mode = { "n", "v" },                desc = "AI: Chat" },
        { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI: Toggle chat" },
        { "<leader>ai", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" },                desc = "AI: Inline edit" },

        -- Shortcuts del prompt library
        { "<leader>ae", ":'<,'>CodeCompanion /explain<cr>",  mode = "v",                         desc = "AI: Explain" },
        { "<leader>af", ":'<,'>CodeCompanion /fix<cr>",      mode = "v",                         desc = "AI: Fix" },
        { "<leader>aT", ":'<,'>CodeCompanion /tests<cr>",    mode = "v",                         desc = "AI: Generate tests" },
        { "<leader>aL", ":'<,'>CodeCompanion /lsp<cr>",      mode = "v",                         desc = "AI: Explain LSP error" },

        -- Commit message desde git status
        { "<leader>am", "<cmd>CodeCompanion /commit<cr>",    desc = "AI: Commit message" },
    },
}
