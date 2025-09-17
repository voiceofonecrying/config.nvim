local GH = 'https://github.com/'

vim.pack.add({
    { src = GH .. 'neovim/nvim-lspconfig' },
    { src = GH .. 'mason-org/mason.nvim' },
    { src = GH .. 'mason-org/mason-lspconfig.nvim' },
    { src = GH .. 'WhoIsSethDaniel/mason-tool-installer' },
    { src = GH .. 'lervag/vimtex' },
    { src = GH .. 'hrsh7th/cmp-nvim-lsp' },
    { src = GH .. 'hrsh7th/nvim-cmp' },
    { src = GH .. 'L3MON4D3/LuaSnip' }
})

require 'mason'.setup()
require 'mason-lspconfig'.setup()
require 'mason-tool-installer'.setup({
    ensure_installed = {
        'pyrefly',
        'debugpy',
        'lua-language-server',
        'vim-language-server',
        'groovy-language-server',
        'stylua',
        'luacheck',
        'misspell',
        'texlab'
    }
})

--vim.lsp.enable('zuban')
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'tectonic'
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function (args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    sources = {
        { name = 'nvim_lsp' }
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('lua_ls', {
    settings = {
        workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
        }
    },
    capabilities = capabilities
})
vim.lsp.config('texlab', {
    capabilities = capabilities
})
vim.lsp.config('pyright', {
    capabilities = capabilities
})

vim.keymap.set('n', '<leader><Tab>', vim.lsp.buf.format, { desc = 'LSP Format' })
-- Tab cycles lsp completions
vim.keymap.set('i', '<Tab>', '<C-n>')
vim.keymap.set('i', '<S-Tab>', '<C-b>')
vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, {desc='go to definition'})
vim.keymap.set('n', 'gD', function () vim.lsp.buf.implementation() end, {desc='go to implementation'})
vim.keymap.set('n', '<leader>rn', function () vim.lsp.buf.rename() end, {desc='rename variable'})



vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = {
        current_line = true
    },
    underline = true
})

vim.lsp.on_type_formatting.enable()
