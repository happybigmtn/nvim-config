-- VSCode Neovim Configuration
vim.g.vscode = true -- Mark that we're in VSCode

-- Basic options for VSCode Neovim
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Install and configure plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure compatible plugins
require("lazy").setup({
    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true
    },
    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                    javascript = { "template_string" },
                    java = false,
                }
            })
        end
    },
    -- Comment
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = true
    },
    -- Treesitter (for better syntax highlighting and text objects)
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "python",
                    "lua",
                    "vim",
                    "html",
                    "css",
                    "json",
                    "yaml",
                    "markdown",
                },
                highlight = {
                    enable = false, -- disable as VSCode handles this
                },
                indent = {
                    enable = true,
                },
            })
        end
    },
    -- Treesitter text objects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
            })
        end
    },
    -- Auto tag
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = true
    },
    -- Additional productivity plugins
    {
        "ggandor/leap.nvim", -- Lightning-fast navigation
        event = "VeryLazy",
        config = function()
            require('leap').add_default_mappings()
        end
    },
    {
        "tpope/vim-repeat", -- Enable repeating supported plugin maps with .
        event = "VeryLazy",
    },
    {
        "wellle/targets.vim", -- Additional text objects
        event = "VeryLazy",
    },
    {
        "machakann/vim-sandwich", -- Alternative surround operations
        event = "VeryLazy",
    },
    {
        "andymass/vim-matchup", -- Enhanced % matching
        event = "VeryLazy",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    {
        "RRethy/vim-illuminate", -- Highlight other uses of word under cursor
        event = "VeryLazy",
        config = function()
            require('illuminate').configure({
                providers = {'treesitter'},
                delay = 100,
                modes_allowlist = {'n', 'v'},
            })
        end
    },
    {
        "mvllow/modes.nvim",
        event = "VeryLazy",
        config = function()
            require('modes').setup()
        end
    },
    -- Houdini for better escape handling
    {
        "TheBlob42/houdini.nvim",
        event = "VeryLazy",
        config = function()
            -- Define VSCode escape command
            local function vscode_escape()
                vim.fn.VSCodeCall('vscode-neovim.escape')
            end
            
            require('houdini').setup {
                mappings = { 'jk' },
                timeout = vim.o.timeoutlen,
                check_modified = true,
                excluded_filetypes = {},
                escape_sequences = {
                    ['i']    = vscode_escape,
                    ['ic']   = vscode_escape,
                    ['ix']   = vscode_escape,
                    ['v']    = '<ESC>',
                    ['V']    = '<ESC>',
                    ['^V']   = '<ESC>',
                    ['s']    = '<ESC>',
                    ['S']    = '<ESC>',
                    ['^S']   = '<ESC>',
                },
            }
        end
    },
})

-- VSCode-specific keybindings helper
local function vscode_notify(cmd, args)
    return function()
        require('vscode-neovim').call(cmd, args)
    end
end

-- VSCode-specific keymaps
local keymaps = {
    -- Navigation
    ["<C-u>"] = vscode_notify("editorScroll", { "up", "page" }),
    ["<C-d>"] = vscode_notify("editorScroll", { "down", "page" }),
    ["<C-f>"] = vscode_notify("editorScroll", { "down", "page" }),
    ["<C-b>"] = vscode_notify("editorScroll", { "up", "page" }),
    
    -- Search
    ["*"] = vscode_notify("actions.find"),
    ["n"] = vscode_notify("editor.action.nextMatchFindAction"),
    ["N"] = vscode_notify("editor.action.previousMatchFindAction"),
    
    -- File navigation
    ["gd"] = vscode_notify("editor.action.revealDefinition"),
    ["gr"] = vscode_notify("editor.action.goToReferences"),
    ["gi"] = vscode_notify("editor.action.goToImplementation"),
    ["gh"] = vscode_notify("editor.action.showHover"),
    ["K"] = vscode_notify("editor.action.showHover"),
    
    -- Quick Fix and Refactoring
    ["<leader>ca"] = vscode_notify("editor.action.quickFix"),
    ["<leader>rn"] = vscode_notify("editor.action.rename"),
    
    -- File explorer
    ["<leader>e"] = vscode_notify("workbench.view.explorer")--[[  ]],
    
    -- Comment
    ["gc"] = vscode_notify("editor.action.commentLine"),
    
    -- Window navigation
    ["<C-w>h"] = vscode_notify("workbench.action.focusLeftGroup"),
    ["<C-w>j"] = vscode_notify("workbench.action.focusBelowGroup"),
    ["<C-w>k"] = vscode_notify("workbench.action.focusAboveGroup"),
    ["<C-w>l"] = vscode_notify("workbench.action.focusRightGroup"),
    
    -- Terminal
    ["<leader>t"] = vscode_notify("workbench.action.terminal.toggleTerminal"),
    
    -- Pane Navigation
    ["<C-h>"] = vscode_notify("workbench.action.navigateLeft"),
    ["<C-l>"] = vscode_notify("workbench.action.navigateRight"),
    ["<C-k>"] = vscode_notify("workbench.action.navigateUp"),
    ["<C-j>"] = vscode_notify("workbench.action.navigateDown"),

    -- Workspace
    ["<leader>ff"] = vscode_notify("workbench.action.quickOpen"),
    ["<leader>fg"] = vscode_notify("workbench.action.findInFiles"),
    
    -- Buffer navigation
    ["<leader>b"] = vscode_notify("workbench.action.showAllEditorsByMostRecentlyUsed"),
    ["H"] = vscode_notify("workbench.action.previousEditor"),
    ["L"] = vscode_notify("workbench.action.nextEditor"),

    -- Window management
    ["<leader>sv"] = vscode_notify("workbench.action.splitEditorRight"),
    ["<leader>sh"] = vscode_notify("workbench.action.splitEditorDown"),
    ["<leader>se"] = vscode_notify("workbench.action.evenEditorWidths"),
    ["<leader>sx"] = vscode_notify("workbench.action.closeActiveEditor"),

    -- Clear search highlights
    ["<Esc>"] = function()
        vim.cmd('nohl')  -- Clear highlights
        vscode_notify("cancelSelection")()  -- Clear VSCode selection
    end,
    ["<leader>nh"] = vscode_notify("editor.action.clearSearchResults"),

    -- Increment/decrement
    ["<leader>+"] = vscode_notify("workbench.action.increaseViewSize"),
    ["<leader>-"] = vscode_notify("workbench.action.decreaseViewSize"),

    -- Focus editor
    ["<D-1>"] = vscode_notify("workbench.action.focusFirstEditorGroup"),
}
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')
vim.keymap.set('n', '<leader>D', '"_D')
vim.keymap.set('n', '<leader>x', '"_x')
-- Insert mode mappings
local opts = { noremap = true, silent = true }

-- Apply normal mode keymaps
for k, v in pairs(keymaps) do
    vim.keymap.set("n", k, v, { silent = true })
end

-- Remap S (substitute line) to M since S is taken by leap
vim.keymap.set('n', 'M', 'S', { noremap = true, silent = true })

-- Custom function for top-of-screen centering
vim.keymap.set('n', 'zz', function()
    local line = vim.fn.line('.')
    vim.cmd('normal! zt')
    vim.cmd('normal! 9j')
end, { desc = 'Center cursor at top of screen' })

-- Additional VSCode-specific settings
vim.g.vscode_neovim_loaded = true

-- Print confirmation
print("VSCode Neovim configuration loaded successfully")