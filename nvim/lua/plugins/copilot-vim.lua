return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- o github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- para curl, log wrapper
    },
    build = "make tiktoken", -- Solo en MacOS o Linux
    opts = function(_, opts)
      -- Verifica si 'opts.sources' existe, si no, inicialízalo como una tabla vacía
      opts.sources = opts.sources or {}

      -- Insertar CopilotC como fuente de autocompletado con alta prioridad
      table.insert(opts.sources, 1, {
        name = "CopilotC",
        group_index = 1,
        priority = 100,
      })
    end,
    -- Aquí puedes agregar más configuraciones de comandos o lazy loading si es necesario
  },
}
