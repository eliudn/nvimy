return {
	"mason-org/mason.nvim",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		-- Herramientas que se instalan automáticamente
		ensure_installed = {
			"tailwindcss-language-server", -- LSP TailwindCSS
			"blade-formatter",             -- Formateador Blade templates
			"eslint-lsp",                  -- ESLint como LSP (vscode-eslint-language-server)
			-- Python toolchain
			"basedpyright",                -- LSP: type checking + autocompletado
			"ruff",                        -- LSP + formatter + linter (binario unificado)
			-- mypy: omitido — requiere stubs por proyecto; basedpyright es suficiente
			"debugpy",                     -- Adapter DAP para debugging
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)

		-- Instalar automáticamente los paquetes de ensure_installed
		local registry = require("mason-registry")
		registry.refresh(function()
			for _, name in ipairs(opts.ensure_installed or {}) do
				local pkg = registry.get_package(name)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end)
	end,
}
