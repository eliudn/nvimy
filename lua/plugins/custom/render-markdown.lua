return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-mini/mini.icons",
    },
    ft = { "markdown" },
    opts = {
        heading = {
            enabled = true,
            sign = true,
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        },
        code = {
            enabled = true,
            sign = false,
            style = "full",
            border = "thick",
            width = "block",
        },
        dash = { enabled = true },
        bullet = {
            enabled = true,
            icons = { "●", "○", "◆", "◇" },
        },
        checkbox = {
            enabled = true,
            unchecked = { icon = "󰄱 " },
            checked   = { icon = "󰱒 " },
            custom = {
                todo      = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
                important = { raw = "[!]", rendered = "󰀨 ", highlight = "RenderMarkdownWarn" },
            },
        },
        quote  = { enabled = true },
        table  = { enabled = true, style = "full" },
        callout = {
            note      = { raw = "[!NOTE]",      rendered = "󰋽 Note",      highlight = "RenderMarkdownInfo" },
            tip       = { raw = "[!TIP]",       rendered = "󰌶 Tip",       highlight = "RenderMarkdownSuccess" },
            important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
            warning   = { raw = "[!WARNING]",   rendered = "󰀨 Warning",   highlight = "RenderMarkdownWarn" },
            caution   = { raw = "[!CAUTION]",   rendered = "󰳦 Caution",   highlight = "RenderMarkdownError" },
        },
        link = {
            enabled = true,
            image = "󰥶 ",
            email = "󰀓 ",
            hyperlink = "󰌹 ",
        },
    },
}
