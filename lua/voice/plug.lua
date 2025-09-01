local GH = 'https://github.com/'
local keymap = vim.keymap

vim.pack.add {
    { src = GH .. 'stevearc/oil.nvim' },
    { src = GH .. 'nvim-telescope/telescope.nvim' },
    { src = GH .. 'echasnovski/mini.completion' },
    { src = GH .. 'echasnovski/mini.icons' },
    { src = GH .. 'echasnovski/mini.snippets' },
    { src = GH .. 'echasnovski/mini.diff' },
    { src = GH .. 'rose-pine/neovim' },
    { src = GH .. 'folke/lazydev.nvim' },
    { src = GH .. 'folke/which-key.nvim' },
    { src = GH .. 'nvim-lua/plenary.nvim' },
    { src = GH .. 'ThePrimeagen/harpoon',               version = 'harpoon2' },
    { src = GH .. 'lukas-reineke/indent-blankline.nvim' },
    { src = GH .. 'nvim-treesitter/nvim-treesitter' },
    { src = GH .. 'MunifTanjim/nui.nvim' },
    { src = GH .. 'm4xshen/hardtime.nvim' },
    { src = GH .. 'rcarriga/nvim-notify' },
    { src = GH .. 'tris203/precognition.nvim' },
    { src = GH .. 'pocco81/true-zen.nvim' },
    { src = GH .. 'christoomey/vim-tmux-navigator' },
}

vim.cmd 'colorscheme rose-pine-moon'
require('lazydev').setup()
require('mini.completion').setup()
require('mini.icons').setup()
require('mini.snippets').setup()
local which_key = require 'which-key'

which_key.add {
    { '<leader>p', desc='Pick' },
    { '<leader>d', desc='DAP'},
    --{ '<leader>a', icon = 'f1845' }
}

vim.notify = require 'notify'
require('hardtime').setup {
    enabled = false,
    disabled_keys = {
        ['<Up>'] = false,
        ['<Down>'] = false,
        ['<Left>'] = false,
        ['<Right>'] = false,
    },
}

require('oil').setup()
keymap.set('n', '<leader>pv', ':Oil<CR>', { desc = 'explore' })
local builtin = require 'telescope.builtin'
keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'files' })
keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'grep' })
keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'buffers' })
keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'help' })

require('mini.diff').setup()
--MiniDiff.config.view.style = 'sign'; vim.cmd('edit')
--keymap.set('n', '<leader>do', function() MiniDiff.toggle_overlay(0) end)

local harpoon = require 'harpoon'
harpoon.setup()
keymap.set('n', '<leader>h', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, {desc='\'Pooned files'})
keymap.set('n', '<leader>a', function()
    harpoon:list():add()
end, {desc='\'Poon file'})
keymap.set('n', '<F1>', function()
    harpoon:list():select(1)
end)
keymap.set('n', '<F2>', function()
    harpoon:list():select(2)
end)
keymap.set('n', '<F3>', function()
    harpoon:list():select(3)
end)
keymap.set('n', '<F4>', function()
    harpoon:list():select(4)
end)
keymap.set('n', '<F9>', function()
    harpoon:list():prev()
end)
keymap.set('n', '<F10>', function()
    harpoon:list():next()
end)

local highlight = {
    'RainbowViolet',
    'RainbowCyan',
    'RainbowOrange',
    'RainbowYellow',
    'RainbowGreen',
    'RainbowBlue',
    'RainbowRed',
}

local hooks = require 'ibl.hooks'
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
end)

require('ibl').setup { indent = { highlight = highlight } }

keymap.set('n', '<leader>tw', function()
    require('precognition').toggle()
    vim.cmd ':Hardtime toggle'
end)

local truezen = require('true-zen')
keymap.set('n', '<leader>zn', function()
  local first = 0
  local last = vim.api.nvim_buf_line_count(0)
  truezen.narrow(first, last)
end, { noremap = true })
keymap.set('v', '<leader>zn', function()
  local first = vim.fn.line('v')
  local last = vim.fn.line('.')
  truezen.narrow(first, last)
end, { noremap = true })
keymap.set('n', '<leader>zm', truezen.minimalist, { noremap = true })
keymap.set('n', '<leader>zz', truezen.ataraxis, { noremap = true })
