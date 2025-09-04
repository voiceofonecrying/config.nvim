local GH = 'https://github.com/'

vim.pack.add({
    { src = GH .. 'neovim/nvim-lspconfig' },
    { src = GH .. 'mason-org/mason.nvim' },
    { src = GH .. 'mason-org/mason-lspconfig.nvim' },
    { src = GH .. 'WhoIsSethDaniel/mason-tool-installer' },
})

require 'mason'.setup()
require 'mason-lspconfig'.setup()
require 'mason-tool-installer'.setup({
    ensure_installed = {
        'pyright',
        'lua-language-server',
        'vim-language-server',
        'stylua',
        'luacheck',
        'misspell',
        'jdtls'
    }
})

vim.lsp.config('lua_ls', {
    settings = {
        workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
        }
    }
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
    --virtual_lines = true,
    underline = true
})

--vim.lsp.on_type_formatting.enable()
