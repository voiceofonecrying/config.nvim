local GH = 'https://github.com/'
vim.pack.add({
    { src = GH .. 'mfussenegger/nvim-dap' },
    { src = 'https://codeberg.org/mfussenegger/nvim-dap-python' }
})

require 'dap-python'.setup('/usr/bin/python')
