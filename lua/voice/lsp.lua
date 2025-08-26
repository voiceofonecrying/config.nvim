local GH = 'https://github.com/'

vim.pack.add({
    { src = GH .. 'neovim/nvim-lspconfig' },
    { src = GH .. 'mason-org/mason.nvim' },
    { src = GH .. 'mason-org/mason-lspconfig.nvim' },
})

require 'mason'.setup()
require 'mason-lspconfig'.setup()

vim.lsp.config('lua_ls', {
    settings = {
        workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
        }
    }
})

vim.keymap.set('n', '<leader><Tab>', vim.lsp.buf.format)
-- Tab cycles lsp completions
vim.keymap.set('i', '<Tab>', '<C-n>')
vim.keymap.set('i', '<S-Tab>', '<C-b>')

vim.diagnostic.config({
    --virtual_text = true,
    virtual_lines = true,
    underline = true
})
