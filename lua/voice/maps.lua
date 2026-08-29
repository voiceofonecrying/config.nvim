local map = vim.keymap.set

-- U = redo
map("n", "U", "<c-r>", { silent = true })

-- Tab forward/backward
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Arrow keys to move between windows
map('n', '<Left>', '<C-w>h')
map('n', '<Down>', '<C-w>j')
map('n', '<Up>', '<C-w>k')
map('n', '<Right>', '<C-w>l')


-- Fold all and unfold all
map('n', '<leader>zc', '<cmd>normal! zM<CR>', { silent = true })
map('n', '<leader>zo', '<cmd>normal! zR<CR>', { silent = true })

-- Common Neovim/LSP replacements for some IdeaVim actions TODO: move to lsp.lua
map('n', 'gD', vim.lsp.buf.declaration)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<leader>rr', function() vim.lsp.buf.format({ async = true }) end)

