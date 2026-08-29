local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh('nvim-treesitter/nvim-treesitter-textobjects'),
	gh('mason-org/mason-lspconfig.nvim'),
	gh('mason-org/mason.nvim'),
	}

	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "pyright", "gopls"}})

vim.lsp.semantic_tokens.enable()
vim.diagnostic.config({ virtual_text = true })
vim.cmd("set completeopt+=noselect,popup")

