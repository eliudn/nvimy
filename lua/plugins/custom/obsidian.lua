return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "principal",
                path = "~/Vault",
            },
        },
        daily_notes = {
            folder = "Dailies",
            date_format = "%Y-%m-%d",
            alias_format = "%d %B %Y",
            template = "Templates/daily.md",
        },
        templates = {
            subdir = "Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        picker = {
            name = "snacks.nvim",
        },
        -- IDs tipo timestamp para evitar colisiones
        note_id_func = function(title)
            local suffix = ""
            if title ~= nil then
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.date("%Y%m%d")) .. "-" .. suffix
        end,
        -- render-markdown.nvim maneja la UI visual
        ui = { enable = false },
        attachments = {
            img_folder = "Assets",
        },
    },
    keys = {
        { "<leader>oo", "<cmd>ObsidianOpen<cr>",                       desc = "Abrir en Obsidian App" },
        { "<leader>on", "<cmd>ObsidianNew<cr>",                        desc = "Nueva nota" },
        { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>",                desc = "Cambiar nota (fuzzy)" },
        { "<leader>of", "<cmd>ObsidianSearch<cr>",                     desc = "Buscar en vault" },
        { "<leader>od", "<cmd>ObsidianToday<cr>",                      desc = "Nota de hoy" },
        { "<leader>oD", "<cmd>ObsidianTomorrow<cr>",                   desc = "Nota de mañana" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",                  desc = "Backlinks" },
        { "<leader>ol", "<cmd>ObsidianLinks<cr>",                      desc = "Links de esta nota" },
        { "<leader>oL", "<cmd>ObsidianLinkNew<cr>",  mode = "v",       desc = "Link a nueva nota" },
        { "<leader>oT", "<cmd>ObsidianTags<cr>",                       desc = "Buscar por tags" },
        { "<leader>ot", "<cmd>ObsidianTemplate<cr>",                   desc = "Insertar template" },
        { "<leader>ow", "<cmd>ObsidianWorkspace<cr>",                  desc = "Cambiar workspace" },
        { "<leader>oe", "<cmd>ObsidianExtractNote<cr>", mode = "v",    desc = "Extraer a nueva nota" },
        { "<leader>oR", "<cmd>ObsidianRename<cr>",                     desc = "Renombrar nota" },
        { "<leader>op", "<cmd>ObsidianPasteImg<cr>",                   desc = "Pegar imagen" },
        { "<leader>oc", "<cmd>ObsidianTOC<cr>",                        desc = "Tabla de contenido" },
    },
}
