return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local bg = '#011628'
      local bg_dark = '#011423'
      local bg_highlight = '#143652'
      local bg_search = '#0A64AC'
      local bg_visual = '#275378'
      local fg = '#CBE0F0'
      local fg_dark = '#DBE9F4'
      local fg_gutter = '#A8B9C9'
      local border = '#547998'

      require('tokyonight').setup {
        style = 'night',
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
        on_highlights = function(highlights, colors)
          -- Brighter comments
          highlights.Comment = {
            fg = '#7AA2C7'  -- Brighter blue-gray
          }
          
          -- Brighter unused variables
          highlights.DiagnosticUnnecessary = {
            fg = '#9AB8D7'  -- Bright blue-gray
            -- Alternative options:
            -- fg = '#8CA2B7'  -- More muted but still visible
            -- fg = '#A8C2D8'  -- Very bright
          }
        end,
      }
      -- load the colorscheme here
      vim.opt.termguicolors = true
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}
