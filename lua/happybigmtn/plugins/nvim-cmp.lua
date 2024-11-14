return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    'zbirenbaum/copilot.lua',
    'zbirenbaum/copilot-cmp',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('copilot_cmp').setup()
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = false },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      },
      sources = {
        { name = 'copilot', priority = 1100 },
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'nvim_lsp_signature_help', priority = 800 },
        { name = 'luasnip', priority = 750 },
        {
          name = 'buffer',
          priority = 500,
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = 'path', priority = 250 },
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        expandable_indicator = true,
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = { Copilot = '' },
          menu = {
            copilot = '[Copilot]',
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[Snippet]',
            path = '[Path]',
          },
        },
      },
    }

    -- Set up LSP capabilities
    require('lspconfig').ts_ls.setup {
      capabilities = capabilities,
      settings = {
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
