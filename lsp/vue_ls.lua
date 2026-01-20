local typescript_lib = vim.fn.stdpath('data') ..
    "/mason/packages/typescript-language-server/node_modules/typescript/lib"
---@type vim.lsp.Config
return {
    cmd = { "vue-language-server", "--stdio" },
    -- capabilities = vim.lsp.protocol.make_client_capabilities(),
    filetypes = { 'vue' },
    root_markers = { 'package.json', 'vite.config.ts', 'vite.config.js', 'vue.config.js', '.git' },
    init_options = {
        vue = {
            -- Hybrid Mode delega la lógica de TS al servidor ts_ls configurado arriba
            hybridMode = false,
        },
        typescript = {
            tsdk = typescript_lib
        }
    },
}
-- ---@type vim.lsp.Config
-- return {
--     cmd = { "vue-language-server", "--stdio" },
--     filetypes = { "vue" },
--     root_markers = { "package.json" }
-- }
