local GH = 'https://github.com/'

vim.pack.add({
    { src = GH .. 'stevearc/oil.nvim' },
    { src = GH .. 'echasnovski/mini.pick' },
    { src = GH .. 'echasnovski/mini.completion' },
    { src = GH .. 'echasnovski/mini.icons' },
    { src = GH .. 'echasnovski/mini.snippets' },
    { src = GH .. 'echasnovski/mini.diff' },
    { src = GH .. 'rose-pine/neovim' },
    { src = GH .. 'folke/lazydev.nvim' },
    { src = GH .. 'nvim-lua/plenary.nvim' },
    { src = GH .. 'ThePrimeagen/harpoon',       version = 'harpoon2' },
    { src = GH .. 'lukas-reineke/indent-blankline.nvim' },
    { src = GH .. 'nvim-treesitter/nvim-treesitter' },
})

vim.cmd('colorscheme rose-pine-moon')
require 'lazydev'.setup()
require 'mini.completion'.setup()
require 'mini.icons'.setup()
require 'mini.snippets'.setup()

require 'oil'.setup()
vim.keymap.set('n', '<leader>pv', ':Oil<CR>')

require 'mini.pick'.setup()
vim.keymap.set('n', '<leader>pf', ':Pick files<CR>')
vim.keymap.set('n', '<leader>ph', ':Pick help<CR>')

require 'mini.diff'.setup()
MiniDiff.config.view.style = 'sign'; vim.cmd('edit')
vim.keymap.set('n', '<leader>do', function() MiniDiff.toggle_overlay(0) end)

local harpoon = require 'harpoon'
harpoon.setup()
vim.keymap.set('n', '<leader>h', function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<leader>a', function () harpoon:list():add() end)
vim.keymap.set('n', '<F1>', function () harpoon:list():select(1) end)
vim.keymap.set('n', '<F2>', function () harpoon:list():select(2) end)
vim.keymap.set('n', '<F3>', function () harpoon:list():select(3) end)
vim.keymap.set('n', '<F4>', function () harpoon:list():select(4) end)
vim.keymap.set('n', '<F9>', function () harpoon:list():prev() end)
vim.keymap.set('n', '<F10>', function () harpoon:list():next() end)


local highlight = {
    "RainbowViolet",
    "RainbowCyan",
    "RainbowOrange",
    "RainbowYellow",
    "RainbowGreen",
    "RainbowBlue",
    "RainbowRed",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }
