---@type vim.lsp.Config
return {
	cmd = { "phpactor", "language-server" },
	filetypes = { "php", "blade" },
	init_options = {
		["language_server_worse_reflection.inlay_hints.enable"] = true,
		["language_server_worse_reflection.inlay_hints.types"] = false,
		["language_server_worse_reflection.inlay_hints.params"] = true,
		["code_transform.import_globals"] = true,
	},
	handlers = {
		["textDocument/publishDiagnostics"] = function(err, result, ...)
			if vim.endswith(result.uri, "Test.php") then
				result.diagnostics = vim.tbl_filter(function(diagnostic)
					return (not vim.startswith(diagnostic.message, 'Namespace should probably be "Tests'))
						and (not vim.endswith(diagnostic.message, "PHPUnit\\Framework\\MockObject\\MockObject given."))
				end, result.diagnostics)
			end
			if vim.endswith(result.uri, "blade.php") then
				result.diagnostics = vim.tbl_filter(function(diagnostic)
					return (not vim.startswith(diagnostic.message, 'Undefined variable "$this"'))
				end, result.diagnostics)
			end
			vim.lsp.diagnostic.on_publish_diagnostics(err, result, ...)
		end,

		["textDocument/inlayHint"] = function(err, result, ...)
			for _, res in ipairs(result or {}) do
				if res.kind == 2 then
					res.label = res.label .. ":"
				end
				res.label = res.label .. " "
			end
			vim.lsp.handlers["textDocument/inlayHint"](err, result, ...)
		end,
	},
	root_markers = { "composer.json", ".git", "index.php" },
}
