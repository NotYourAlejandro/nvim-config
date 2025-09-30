return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {
          "--interpreter=dap",
          "--eval-command",
          "set print pretty on",
        },
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/simulator", "file")
          end,
          args = {}, -- provide args if needed
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          setupCommands = {
            {
              text = "set substitute-path /home/alexander/source/os-simulator " .. vim.fn.getcwd(),
            },
          },
        },
      }
    end,
  },

  -- Mason packages
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "checkmake",
        "clangd",
        "marksman",
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "racket",
        "regex",
        "scheme",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- Conform formatter config
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      }
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        sh = { "shfmt" },
        c = { "clangd" },
      })
      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        injected = {
          options = {
            ignore_errors = true,
          },
        },
      })
    end,
  },

  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "wlangstroth/vim-racket",
    ft = { "racket" },
  },
}
