---@type vim.lsp.Config
return {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
    },
    root_markers = {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        ".git",
    },
    settings = {
        validate = "on",
        packageManager = nil,
        useESLintClass = false,
        useFlatConfig = nil,
        experimental = {
            useFlatConfig = false,
        },
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine",
            },
            showDocumentation = {
                enable = true,
            },
        },
        format = false, -- usar prettier para formatear, eslint solo para linting
        workingDirectory = { mode = "location" },
    },
    on_attach = function(_, bufnr)
        -- Auto-fix al guardar con EslintFixAll
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
}
