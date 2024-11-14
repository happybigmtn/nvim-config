return {
  {
    'rachartier/tiny-code-action.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    event = 'LspAttach',
    config = function()
      require('tiny-code-action').setup {
        backend = 'vim',
        telescope_opts = {
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.7,
            height = 0.9,
            preview_cutoff = 1,
          },
        },
        signs = {
          quickfix = { '', { link = 'DiagnosticInfo' } },
          refactor = { '', { link = 'DiagnosticWarning' } },
          source = { '', { link = 'DiagnosticError' } },
        },
      }
    end,
  },
  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'nvimtools/none-ls.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'ts_ls', 'rust_analyzer' },
      }

      -- LSP keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = event.buf }
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        end,
      })

      -- Null-ls setup
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
        },
      }
    end,
  },
}
