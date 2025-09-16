vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local m = vim.keymap

-- Arrow keys to move through windows
m.set('n', '<left>', '<cmd>wincmd h<CR>')
m.set('n', '<right>', '<cmd>wincmd l<CR>')
m.set('n', '<down>', '<cmd>wincmd j<CR>')
m.set('n', '<up>', '<cmd>wincmd k<CR>')

m.set('v', 'J', ":m '>+1<CR>gv=gv")
m.set('v', 'K', ":m '>--2<CR>gv=gv")

m.set('n', 'J', 'mzJ`z')

m.set('n', '<C-d>', '<C-d>zz')
m.set('n', '<C-u>', '<C-u>zz')
m.set('n', 'n', 'nzzzv')
m.set('n', 'N', 'Nzzzv')
m.set('n', '=ap', "ma=ap'a")

-- greatest remap ever
m.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
m.set({ 'n', 'v' }, '<leader>y', [["+y]], {desc='yank to clipboard'})
m.set('n', '<leader>Y', [["+Y]], {desc='yank line to clipboard'})


m.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc='rename word under cursor'})


m.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
m.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
m.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc='make bash executable' })
