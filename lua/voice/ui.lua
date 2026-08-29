local gh = function(x) return 'https://github.com/' .. x end
-- Colorscheme and also some other UI tweaks

vim.pack.add {
	gh("Aejkatappaja/cendre"),
	gh("nickkadutskyi/jb.nvim"),
	gh("sschleemilch/slimline.nvim"),
	}

require("slimline").setup({})
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

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono NFM:h16"
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scroll_animation_length = 0.3
	vim.opt.linespace = 10
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})
