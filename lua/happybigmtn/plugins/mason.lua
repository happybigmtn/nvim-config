return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- LSP on_attach function
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      -- LSP keybindings
      local opts = { buffer = bufnr }
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    end
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }
    mason_lspconfig.setup {
      ensure_installed = {
        'ts_ls',
        'html',
        'cssls',
        'tailwindcss',
        'lua_ls',
        'emmet_ls',
        'prismals',
        'pyright',
        'eslint',
        'jsonls',
        'astro',
        'marksman',
      },
      automatic_installation = true,
    }
    -- Setup all LSP servers with capabilities and on_attach
    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            -- TypeScript specific settings
            typescript = {
              suggestionActions = { enabled = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              preferences = {
                importModuleSpecifier = 'non-relative',
              },
            },
            javascript = {
              suggestionActions = { enabled = true },
              preferences = {
                importModuleSpecifier = 'non-relative',
              },
            },
          },
        }
      end,
    }
    mason_tool_installer.setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'eslint_d',
        'prettierd',
        'typescript-language-server',
        'css-lsp',
        'html-lsp',
        'json-lsp',
        'tailwindcss-language-server',
        'prisma-language-server',
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 24,
    }
  end,
}
