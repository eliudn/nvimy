return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- solo se carga al abrir archivos lua
    opts = {
      library = {
        -- Carga los tipos de Snacks para que tengas autocompletado de Snacks.terminal, etc.
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
