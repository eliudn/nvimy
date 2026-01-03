return {
	{ "saghen/blink.compat", version = "*", lazy = true, opts = {} },
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				name = "luasnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
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
				["<S-Tab>"] = {},
				["<Tab>"] = {},
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-j>"] = { "snippet_backward", "fallback" },
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
			sources = {
				default = function()
					local sources = { "lsp", "path", "snippets", "buffer" }
					-- if
					-- 	require("nixCatsUtils").enableForCategory("laravel")
					-- 	and vim.bo.filetype == "php"
					-- 	and vim.fn.filereadable("artisan") == 1
					-- then
					-- 	table.insert(sources, "laravel")
					-- end

					if vim.tbl_contains({ "sql", "mysql", "plsql" }, vim.bo.filetype) then
						return { "dadbod", "snippets" }
					end

					return sources
				end,
				providers = {
					laravel = {
						name = "laravel",
						module = "blink.compat.source",
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
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
