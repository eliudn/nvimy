-- lua/plugins/extras/mini-surround.lua
return {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
        mappings = {
            add            = "gza", -- Add surrounding (gza"): hello → "hello"
            delete         = "gzd", -- Delete surrounding (gzd"): "hello" → hello
            find           = "gzf", -- Find surrounding
            find_left      = "gzF", -- Find surrounding left
            highlight      = "gzh", -- Highlight surrounding
            replace        = "gzr", -- Replace surrounding (gzr"'): "hello" → 'hello'
            update_n_lines = "gzn", -- Update n_lines
        },
    },
}
