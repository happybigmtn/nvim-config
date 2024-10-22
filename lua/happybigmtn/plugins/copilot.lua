return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      -- Your Copilot configuration here
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  end,
}
