local M = {
  'echasnovski/mini.move',
  version = '*',
  event = 'VeryLazy',
  config = function()
    -- Disable default mini.move mappings
    require('mini.move').setup {
      mappings = {
        -- Disable default mappings
        left = '',
        right = '',
        down = '',
        up = '',
        line_left = '',
        line_right = '',
        line_down = '',
        line_up = '',
      },
      options = {
        reindent_linewise = true,
      },
    }

    -- Line movement with up/down arrows
    vim.keymap.set('n', '<Down>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
    vim.keymap.set('n', '<Up>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
    vim.keymap.set('i', '<Down>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down', silent = true })
    vim.keymap.set('i', '<Up>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up', silent = true })
    vim.keymap.set('v', '<Down>', ":m '>+1<CR>gv=gv", { desc = 'Move line down', silent = true })
    vim.keymap.set('v', '<Up>', ":m '<-2<CR>gv=gv", { desc = 'Move line up', silent = true })

    -- Character swapping with left/right arrows
    vim.keymap.set('n', '<Left>', 'xhP', { desc = 'Swap with previous char', silent = true })
    vim.keymap.set('n', '<Right>', 'xp', { desc = 'Swap with next char', silent = true })

    -- Visual mode character swapping
    vim.keymap.set('v', '<Left>', '<Left>xhP`[v`]', { desc = 'Swap with previous char', silent = true })
    vim.keymap.set('v', '<Right>', '<Right>xp`[v`]', { desc = 'Swap with next char', silent = true })

    -- Shift + Arrow for larger jumps
    vim.keymap.set('n', '<S-Down>', ':m .+5<CR>==', { desc = 'Move line 5 down', silent = true })
    vim.keymap.set('n', '<S-Up>', ':m .-6<CR>==', { desc = 'Move line 5 up', silent = true })
    vim.keymap.set('v', '<S-Down>', ":m '>+5<CR>gv=gv", { desc = 'Move line 5 down', silent = true })
    vim.keymap.set('v', '<S-Up>', ":m '<-6<CR>gv=gv", { desc = 'Move line 5 up', silent = true })

    -- Shift + Left/Right for word swapping
    vim.keymap.set('n', '<S-Left>', 'dawbP', { desc = 'Swap with previous word', silent = true })
    vim.keymap.set('n', '<S-Right>', 'dawwP', { desc = 'Swap with next word', silent = true })
  end,
}

return M
