-- return {
--
--     'nvim-lualine/lualine.nvim',
--     dependencies = { 'nvim-tree/nvim-web-devicons' },
--
--     config = function ()
--         require("lualine").setup()
--     end
-- }
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- Función para obtener el nombre del proyecto usando Snacks
    local function get_project_name()
      local root = Snacks.util.root()
      return "󱉭  " .. vim.fn.fnamemodify(root, ":t")
    end

    -- Función para ver qué LSP y Formateadores están activos
    local function lsp_status()
      local msg = 'No LSP'
      local buf_ft = vim.api.nvim_get_current_buf_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if next(clients) == nil then return msg end

      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return "  " .. table.concat(client_names, ', ')
    end

    return {
      options = {
        theme = "auto",
        component_separators = { left = '󰿟', right = '󰿟' },
        section_separators = { left = '', right = '' },
        globalstatus = true, -- Importante para que combine con cmdheight = 0
        disabled_filetypes = { statusline = { "dashboard", "alpha", "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { { 'mode', icon = "" } },
        lualine_b = {
          { 'branch', icon = '' },
          { 'diff', symbols = { added = ' ', modified = '󰝤 ', removed = ' ' } }
        },
        lualine_c = {
          { get_project_name, color = { fg = "#ff9e64", gui = "bold" } }, -- Nombre del proyecto
          { 'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { 'filename', path = 1, symbols = { modified = "  ", readonly = "  ", unnamed = " [Sin nombre] " } },
        },
        lualine_x = {
          { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' } },
          { lsp_status, color = { fg = "#7aa2f7" } }, -- Muestra tu lua_ls, phpactor, etc.
        },
        lualine_y = {
          { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } },
          'encoding',
          'filesize' -- Muy útil para saber si el archivo es pesado
        },
        lualine_z = {
          { 'location', icon = "" },
          { 'progress', separator = " ", padding = { left = 0, right = 1 } },
        },
      },
    }
  end,
}
