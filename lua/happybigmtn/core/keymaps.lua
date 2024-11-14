-- set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
keymap.set('n', 'zz', function()
  local line = vim.fn.line '.'
  vim.cmd 'normal! zt'
  vim.cmd 'normal! 9j'
end)

-- use jk to exit insert mode
keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- clear search highlights
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' }) -- close current split window

keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab

-- black hole
--
keymap.set('n', 'm', '"_x', { desc = 'Delete character to black hole register' })
-- -- Single character deletion to black hole register

-- Delete word to black hole register
keymap.set('n', 'mw', '"_dw', { desc = 'Delete word to black hole register' })
keymap.set('n', 'mW', '"_dW', { desc = 'Delete WORD to black hole register' })

-- Delete line to black hole register
keymap.set('n', 'md', '"_dd', { desc = 'Delete line to black hole register' })

-- Delete to end of line
keymap.set('n', 'mD', '"_D', { desc = 'Delete to end of line to black hole register' })

-- Visual mode deletions
keymap.set('v', 'm', '"_d', { desc = 'Delete selection to black hole register' })

-- Inner text objects with black hole register
keymap.set('n', 'miw', '"_diw', { desc = 'Delete inner word to black hole register' })
keymap.set('n', 'mi(', '"_di(', { desc = 'Delete inner parentheses to black hole register' })
keymap.set('n', 'mi{', '"_di{', { desc = 'Delete inner curly braces to black hole register' })
keymap.set('n', 'mi[', '"_di[', { desc = 'Delete inner square brackets to black hole register' })
keymap.set('n', "mi'", '"_di\'', { desc = 'Delete inner single quotes to black hole register' })
keymap.set('n', 'mi"', '"_di"', { desc = 'Delete inner double quotes to black hole register' })
