return {
	-- 1. Plugin Principal: Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- Eliminamos branch = "main" ya que está causando inestabilidad
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
				"php",
				"blade",
				"css",
				"javascript",
			},
			highlight = { enable = true },
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			-- require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- 2. Plugin de Textobjects: Ahora depende de que Treesitter esté cargado
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		config = function()
			-- Esto asegura que solo se configure cuando Treesitter ya existe
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
						},
					},
				},
			})
		end,
	},
}

