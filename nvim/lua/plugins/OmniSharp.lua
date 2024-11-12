return {
  -- Plugin para omnisharp
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  { "Issafalcon/neotest-dotnet" },

  -- Configuración para null-ls con CSharpier
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },

  -- Integración de Conform para formatear C#
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },

  -- Integración de DAP para debugging en .NET
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["netcoredbg"] then
        dap.adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },

  -- Integración de Neotest para pruebas .NET
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          -- Aquí puedes configurar opciones específicas para neotest-dotnet
        },
      },
    },
  },

  -- Integración de NuGet para completar paquetes
  {
    "nvim-cmp",
    dependencies = {
      "PasiBergman/cmp-nuget",
    },
    opts = function(_, opts)
      local nuget = require("cmp-nuget")
      nuget.setup({})

      table.insert(opts.sources, 1, {
        name = "nuget",
      })

      opts.formatting.format = function(entry, vim_item)
        if entry.source.name == "nuget" then
          vim_item.kind = "NuGet"
        end
        return vim_item
      end
    end,
  },
}
