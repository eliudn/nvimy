return {
    { "saghen/blink.compat", version = "*", lazy = true, opts = {} },
    { "hrsh7th/nvim-cmp",    lazy = true },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                name = "luasnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    -- Cargar snippets personalizados en Lua
                    require("luasnip.loaders.from_lua").load({
                        paths = vim.fn.stdpath("config") .. "/lua/snippets",
                    })
                end,
            },
            { "nvim-mini/mini.icons", opts = {} },
        },
        version = "*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<C-l>"] = {},
                ["<C-j>"] = {},
                ["<Tab>"]   = { "snippet_forward",  "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            signature = {
                enabled = true,
                trigger = {
                    enabled = false,
                },
            },
            snippets = { preset = "luasnip" },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            sources = {
                default = function()
                    local sources = { "lsp", "path", "snippets", "buffer", "laravel", }
                    -- if
                    -- 	require("nixCatsUtils").enableForCategory("laravel")
                    -- 	and vim.bo.filetype == "php"
                    -- 	and vim.fn.filereadable("artisan") == 1
                    -- then
                    -- 	table.insert(sources, "laravel")
                    -- end

                    -- if vim.tbl_contains({ "sql", "mysql", "plsql" }, vim.bo.filetype) then
                    -- 	return { "dadbod", "snippets" }
                    -- end

                    return sources
                end,
                per_filetype = {
                    markdown = { "obsidian", "obsidian_new", "obsidian_tags", "lsp", "path", "snippets", "buffer" },
                    codecompanion = { "codecompanion", "path", "buffer" },
                    codecompanion_input = { "codecompanion" },
                },
                providers = {
                    codecompanion = {
                        name = "CodeCompanion",
                        module = "codecompanion.providers.completion.blink",
                        score_offset = 10,
                    },
                    laravel = {
                        name = "laravel",
                        module = "blink.compat.source",
                    },
                    minuet = {
                        name = "minuet",
                        module = "minuet.blink",
                        score_offset = 8,
                    },
                    obsidian = {
                        name = "obsidian",
                        module = "blink.compat.source",
                    },
                    obsidian_new = {
                        name = "obsidian_new",
                        module = "blink.compat.source",
                    },
                    obsidian_tags = {
                        name = "obsidian_tags",
                        module = "blink.compat.source",
                    },
                    -- dadbod = {
                    -- 	name = "Dadbod",
                    -- 	module = "vim_dadbod_completion.blink",
                    -- },
                },
            },
        },
        opts_extend = { "sources.default" },
        config = function(_, opts)
            -- if require("nixCatsUtils").isNixCats then
            -- 	opts.fuzzy = { prebuilt_binaries = { download = false } }
            -- end
            require("blink-cmp").setup(opts)
        end,
    },
}
