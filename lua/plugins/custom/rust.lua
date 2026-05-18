return {
    -- rustaceanvim: wrapper sobre rust-analyzer con features que el protocolo LSP
    -- estándar no soporta (hover interactivo, code actions agrupadas, cargo integration).
    --
    -- REGLA CRÍTICA: rust_analyzer NO debe estar en features.lua.
    -- Si lspconfig también arranca rust-analyzer → 2 clientes en el mismo buffer
    -- → diagnósticos duplicados, hover inconsistente, completado conflictivo.
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        ft = { "rust" },
        opts = function()
            -- Resuelve la ruta de codelldb instalado por mason (si ya está disponible)
            local codelldb_adapter = nil
            local ext      = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
            local codelldb = ext .. "adapter/codelldb"
            local liblldb  = ext .. "lldb/lib/liblldb.so"
            if vim.fn.filereadable(codelldb) == 1 then
                local ok, ra_cfg = pcall(require, "rustaceanvim.config")
                if ok then
                    codelldb_adapter = ra_cfg.get_codelldb_adapter(codelldb, liblldb)
                end
            end

            return {
                server = {
                    capabilities = require("blink.cmp").get_lsp_capabilities(),
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures        = true,
                                loadOutDirsFromCheck = true,
                                buildScripts       = { enable = true },
                            },
                            -- Clippy reemplaza cargo check: 500+ reglas de calidad.
                            -- Se integra aquí para no duplicar con nvim-lint.
                            check = {
                                allFeatures = true,
                                command     = "clippy",
                                extraArgs   = { "--no-deps" },
                            },
                            procMacro = {
                                enable  = true,
                                ignored = {
                                    ["async-trait"]     = { "async_trait" },
                                    ["napi-derive"]     = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                            inlayHints = {
                                bindingModeHints  = { enable = false },
                                closingBraceHints = { minLines = 10 },
                            },
                        },
                    },
                    on_attach = function(_, bufnr)
                        local map = function(keys, fn, desc)
                            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
                        end

                        -- Sobreescribe los globales con versiones Rust-aware (buffer-local)
                        map("<leader>ca", function() vim.cmd.RustLsp("codeAction") end,
                            "Rust: Code Action (agrupado)")
                        map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end,
                            "Rust: Hover + Acciones")

                        -- Cargo targets: selecciona y lanza sin salir de Neovim
                        map("<leader>rr", function() vim.cmd.RustLsp("runnables") end,
                            "Rust: Runnables")
                        map("<leader>rd", function() vim.cmd.RustLsp("debuggables") end,
                            "Rust: Debuggables")
                        map("<leader>rt", function() vim.cmd.RustLsp("testables") end,
                            "Rust: Testables")

                        -- Herramientas de análisis
                        map("<leader>re", function() vim.cmd.RustLsp("explainError") end,
                            "Rust: Explain error")
                        map("<leader>rm", function() vim.cmd.RustLsp("expandMacro") end,
                            "Rust: Expand macro")
                        map("<leader>rp", function() vim.cmd.RustLsp("parentModule") end,
                            "Rust: Parent module")
                    end,
                },
                tools = {
                    hover_actions    = { auto_focus = false },
                    float_win_config = { border = "rounded" },
                },
                -- codelldb: debugger con pretty-printing nativo de Vec/HashMap/String/etc.
                -- Se autoconfigura en nvim-dap cuando llamas RustLsp("debuggables").
                dap = { adapter = codelldb_adapter },
            }
        end,
        config = function(_, opts)
            vim.g.rustaceanvim = opts
        end,
    },

    -- crates.nvim: info de versiones, actualizaciones y acciones en Cargo.toml.
    -- Modo LSP: blink.cmp lo recoge vía la source "lsp" sin config adicional.
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            lsp = {
                enabled    = true,
                actions    = true,
                completion = true,
                hover      = true,
            },
        },
        keys = {
            { "<leader>cu", function() require("crates").upgrade_crate() end,      ft = "toml", desc = "Crates: Actualizar crate" },
            { "<leader>cU", function() require("crates").upgrade_all_crates() end, ft = "toml", desc = "Crates: Actualizar todos" },
            { "<leader>ci", function() require("crates").show_crate_popup() end,   ft = "toml", desc = "Crates: Info crate" },
        },
    },
}
