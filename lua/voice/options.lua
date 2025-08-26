local o = vim.o

o.nu = true
o.relativenumber = true
o.winborder = 'rounded'

o.smartindent = true
o.smarttab = true
o.softtabstop = 4
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.wrap = false
o.smoothscroll = true
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.hlsearch = false
o.incsearch = true
o.scrolloff = 8

o.colorcolumn = '100'
--or yes?
o.signcolumn = 'number'
o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
