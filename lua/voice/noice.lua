local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh('rcarriga/nvim-notify'),
	gh('folke/noice.nvim'),
	}

require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
	},
	cmdline = {
		view = "cmdline",
	}
})
vim.keymap.set("n", "<leader>nn", "<cmd>NoiceHistory<cr>", { desc = "Noice: history" })
