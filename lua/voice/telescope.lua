local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh("ibhagwan/fzf-lua"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	}

require('telescope').setup({
	extensions = {
		["ui_select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
})
require('telescope').load_extension('ui-select')

vim.diagnostic.config({
    virtual_text = {
	prefix = '●',
	source = "if_many",
    },
    signs = {
						text = {
										[vim.diagnostic.severity.ERROR] =  " ",
										[vim.diagnostic.severity.WARN] =  " ",
										[vim.diagnostic.severity.HINT] =  " ",
										[vim.diagnostic.severity.INFO] =  " ",
						}
		},
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

require("fzf-lua").setup({"telescope",winopts={preview={default="bat"}}})
vim.keymap.set('n', '<leader>ff', function() require('fzf-lua').files() end, { desc = 'FZF find files' })
vim.keymap.set('n', '<leader>fg', function() require('fzf-lua').live_grep() end, { desc = 'FZF live grep' })
vim.keymap.set('n', '<leader>fb', function() require('fzf-lua').buffers() end, { desc = 'FZF buffers' })
vim.keymap.set('n', '<leader>fh', function() require('fzf-lua').help_tags() end, { desc = 'FZF help tags' })
