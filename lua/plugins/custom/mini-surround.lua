-- lua/plugins/extras/mini-surround.lua
return {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
        mappings = {
            add = "sa",            -- Add surrounding (sa"): hello → "hello"
            delete = "sd",         -- Delete surrounding (sd"): "hello" → hello
            find = "sf",           -- Find surrounding
            find_left = "sF",      -- Find surrounding left
            highlight = "sh",      -- Highlight surrounding
            replace = "sr",        -- Replace surrounding (sr"'): "hello" → 'hello'
            update_n_lines = "sn", -- Update n_lines
        },
    },
}
