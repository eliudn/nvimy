-- lua/plugins/extras/persistence.lua
return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
        { "<leader>ps", function() require("persistence").load() end,             desc = "Session: Restaurar" },
        { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Session: Última sesión" },
        { "<leader>pd", function() require("persistence").stop() end,            desc = "Session: No guardar" },
    },
}
