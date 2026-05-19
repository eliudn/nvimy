
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                header = [[
                                __ _._.,._.__
                          .o8888888888888888P'
                        .d88888888888888888K
          ,8            888888888888888888888boo._
         :88b           888888888888888888888888888b.
          `Y8b          88888888888888888888888888888b.
            `Yb.       d8888888888888888888888888888888b
              `Yb.___.88888888888888888888888888888888888b
                `Y888888888888888888888888888888CG88888P"'
                  `88888888888888888888888888888MM88P"'
 "Y888K    "Y8P""Y888888888888888888888888oo._""""
   88888b    8    8888`Y88888888888888888888888oo.
   8"Y8888b  8    8888  ,8888888888888888888888888o,
   8  "Y8888b8    8888""Y8`Y8888888888888888888888b.
   8    "Y8888    8888   Y  `Y8888888888888888888888
   8      "Y88    8888     .d `Y88888888888888888888b
 .d8b.      "8  .d8888b..d88P   `Y88888888888888888888
                                  `Y88888888888888888b.
                   "Y888P""Y8b. "Y888888888888888888888
                     888    888   Y888`Y888888888888888
                     888   d88P    Y88b `Y8888888888888
                     888"Y88K"      Y88b dPY8888888888P
                     888  Y88b       Y88dP  `Y88888888b
                     888   Y88b       Y8P     `Y8888888
                   .d888b.  Y88b.      Y        `Y88888
                                                  `Y88K
                                                    `Y8
                                                      ']],
                keys = {
                    { icon = "󰈞 ", key = "f", desc = "Buscar archivo",     action = ":lua Snacks.picker.files()" },
                    { icon = " ", key = "r", desc = "Recientes",           action = ":lua Snacks.picker.recent()" },
                    { icon = "󰺮 ", key = "g", desc = "Buscar en proyecto", action = ":lua Snacks.picker.grep()" },
                    { icon = " ", key = "e", desc = "Explorador",          action = ":Oil" },
                    { icon = " ", key = "l", desc = "LazyGit",             action = ":lua Snacks.lazygit()" },
                    { icon = " ", key = "s", desc = "Restaurar sesión",    action = ":lua require('persistence').load()" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy",               action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Salir",              action = ":qa" },
                },
            },
            sections = {
                { section = "header",  pane = 1 },
                { section = "startup", pane = 1 },
                {
                    pane    = 2,
                    indent  = 2,
                    spacing = 1,
                    { section = "keys", gap = 1, padding = 1 },
                },
            },
        },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
            styles = "fancy"
        },
        picker = {
            enabled = true,
            win = {
                input = {
                    keys = {
                        ["<C-w>w"] = { "focus_preview", desc = "Enfocar Contenido", mode = { "i", "n" } },
                    }
                },
                -- Teclas cuando estás navegando la lista con j/k o <c-n>/<c-p>
                list = {
                    keys = {
                        ["<C-w>w"] = { "focus_preview", desc = "Enfocar Contenido", mode = { "i", "n" } },
                    }
                }
            }
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        image = { enabled = false },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            },
        },
        terminal = {
            win = {
                styles = "terminal",
                position = "bottom",
                keys = {
                    term_normal = {
                        "<esc>",
                        [[<C-\><C-n>]],
                        mode = "t",
                        expr = true,
                        desc = "Regresar al modo normal",
                    }
                }
            }
        },
        lazygit = {
            win = {
                position = "float"
            }
        }

    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            once = true,
            callback = function()
                -- En este punto noice ya cargó y tomó vim.notify.
                -- Snacks ya está inicializado (priority=1000, lazy=false).
                -- Reasignamos vim.notify directamente a snacks.
                -- Los features de noice (cmdline, LSP markdown) NO usan
                -- vim.notify — operan a nivel de ui_attach, son independientes.
                --
                ---@diagnostic disable-next-line: duplicate-set-field
                vim.notify = function(msg, level, opts)
                    Snacks.notify(msg, level, opts)
                end
            end,
        })
    end,
    keys = {
        {
            "<leader>cc",
            function()
                Snacks.terminal("claude", {
                    win = {
                        position = "right",
                        width = 0.40,
                        term_normal = {
                            "<esc>",
                            [[<C-\><C-n>]],
                            mode = "t",
                            expr = true,
                            desc = "Modo normal",
                        },
                    }
                })
            end,
            desc = "Claude code (lateral)"
        },
        {
            "<leader>cd",
            function()
                Snacks.terminal("claude --dangerously-skip-permissions", {
                    win = {
                        position = "right",
                        width = 0.40,
                        term_normal = {
                            "<esc>",
                            [[<C-\><C-n>]],
                            mode = "t",
                            expr = true,
                            desc = "Modo normal",
                        },
                    }
                })
            end,
            desc = "Claude code (lateral)"
        },
        -- Utilidades extra
        { "<leader>.",  function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end,     desc = "Select Scratch Buffer" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end,          desc = "Abrir en Browser (Git)", mode = { "n", "v" } },
        -- lazygit
        {
            "<leader>lg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit"
        },
        -- terminal
        {
            "<c-'>",
            function()
                Snacks.terminal()
            end,
            desc = "Terminal"
        },
        -- Top Pickers & Explorer
        {
            "<leader><space>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notification History",
        },
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        -- find
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Projects",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },
        -- git
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>gL",
            function()
                Snacks.picker.git_log_line()
            end,
            desc = "Git Log Line",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash()
            end,
            desc = "Git Stash",
        },
        {
            "<leader>gd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git Diff (Hunks)",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git Log File",
        },
        -- Grep
        {
            "<leader>sb",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        -- search
        {
            '<leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>s/",
            function()
                Snacks.picker.search_history()
            end,
            desc = "Search History",
        },
        {
            "<leader>sD",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Buffer Diagnostics",
        },
        {
            "<leader>ld",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "LSP Diagnostics"
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>sH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Highlights",
        },
        {
            "<leader>si",
            function()
                Snacks.picker.icons()
            end,
            desc = "Icons",
        },
        -- {
        -- 	"<leader>sj",
        -- 	function()
        -- 		Snacks.picker.jumps()
        -- 	end,
        -- 	desc = "Jumps",
        -- },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        -- {
        -- 	"<leader>sl",
        -- 	function()
        -- 		Snacks.picker.loclist()
        -- 	end,
        -- 	desc = "Location List",
        -- },
        {
            "<leader>sm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>sM",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },
    },
}
