local map = vim.keymap.set

map("n", "U", "<c-r>", { silent = true })

-- Direct / native equivalents
map('n', 'Q', 'gq')

map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '<Left>', '<C-w>h')
map('n', '<Down>', '<C-w>j')
map('n', '<Up>', '<C-w>k')
map('n', '<Right>', '<C-w>l')



map('n', '<leader>zc', '<cmd>normal! zM<CR>', { silent = true })
map('n', '<leader>zo', '<cmd>normal! zR<CR>', { silent = true })

-- Common Neovim/LSP replacements for some IdeaVim actions
map('n', 'gd', vim.lsp.buf.declaration)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<leader>rr', function() vim.lsp.buf.format({ async = true }) end)

