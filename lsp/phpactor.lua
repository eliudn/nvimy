---@type vim.lsp.Config
return {
	cmd = {
		"phpactor",
		"language-server",
	},
	filetype = { "php" },
	root_makers = { ".git", "composer.json", ".phpactor.json", ".phpactor.yml" },
	workspace_required = true,
}
