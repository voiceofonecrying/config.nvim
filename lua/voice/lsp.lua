local gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("mason-org/mason.nvim"),
	gh("folke/trouble.nvim"),
	gh("stevanmilic/nvim-lspimport"),
	gh("ojroques/nvim-lspfuzzy"),
	gh('ray-x/lsp_signature.nvim'),
	gh('ray-x/navigator.lua')
})


require('navigator').setup()
require('lsp_signature').setup()
require("lspfuzzy").setup()

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		else
			client.request = require("lspfuzzy").wrap_request(client.request)
		end
	end
})

vim.keymap.set("n", "<leader>i", require("lspimport").import, { noremap = true })
require("trouble").setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "gopls" },
})

vim.lsp.config("cucumber_language_server", {
	cmd = { "cucumber-language-server", "--stdio" },
	filetypes = { "cucumber" },
	root_dir = require("lspconfig.util").root_pattern(".git"),
	settings = {
		cucumber = {
			features = { "tests/studio/features/**/*.feature" },
			glue = { "tests/studio/step_defs/**/*.py" },
		},
	},
})

vim.lsp.semantic_tokens.enable()
vim.diagnostic.config({ virtual_text = true })
vim.cmd("set completeopt+=noselect,popup")

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: toggle" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: toggle quickfix list" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Trouble: toggle symbols" })
