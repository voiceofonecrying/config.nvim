vim.o.scrolloff = 50
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = true
vim.o.showcmd = true
vim.o.visualbell = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.timeout = false
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.autoread = true
vim.o.laststatus = 3
vim.o.cmdheight = 0
vim.o.winblend = 5
vim.o.splitright = true


vim.cmd.colorscheme("jb")
-- local modes = {
-- 	'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
-- 	'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
-- 	'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
-- 	'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
-- 	'EndOfBuffer', 'TelescopePreviewNormal', 'TelescopeMatching', 'TelescopeSelection',
-- 	'TelescopePromptTitle', 'TelescopePromptPrefix', 'TelescopePromptCounter', 'TelescopePromptNormal',
-- 	'TelescopePromptBorder', 'TelescopeResultsTitle', 'TelescopeResultsNormal', 'TelescopeResultsBorder',
-- 	'TelescopePreviewTitle', 'TelescopePreviewNormal', 'TelescopePreviewBorder', }
-- for _, mode in ipairs(modes) do
-- 	vim.api.nvim_set_hl(0, mode, { bg = "none" })
-- end
