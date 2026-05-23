return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    init = function()
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_theme = "dark"
    end,
    keys = {
        { "<leader>om", "<cmd>MarkdownPreviewToggle<cr>", desc = "Preview en browser" },
    },
}
