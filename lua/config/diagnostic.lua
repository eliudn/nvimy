local severity = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_lines = true,
	-- virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[severity.ERROR] = "󰅚 ",
			[severity.WARN] = "󰀪 ",
			[severity.INFO] = "󰋽 ",
			[severity.HINT] = "󰌶 ",
		},
		numhl = {
			[severity.ERROR] = "ErrorMsg",
			[severity.WARN] = "WarningMsg",
		},
	},
})
