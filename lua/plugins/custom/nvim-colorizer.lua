return {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = { "*" },
        user_default_options = {
            names = true,
            RGB = true,
            RRGGBB = true,
            RRGGBBAA = true,
            rgb_fn = true,
            hsl_fn = true,
            mode = "background",
        }
    }
}
