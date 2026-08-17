vim.lsp.config('pytest_language_server', {
  cmd = { 'pytest-language-server' },
  filetypes = { 'python' },
  root_markers = { 'pytest.ini', 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
})

vim.lsp.config('pyright', {
				settings = {
								python = {
												analysis = {
																extraPaths = {
																				{'/Users/jazkin/Dev/sas-studio-playwrightautomation/src/tests'} } } } }
})

vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })

vim.lsp.enable({'lua_ls', 'ruff', 'pyrefly', 'pylsp', 'pyright', 'pytest_language_server', 'behave_lsp', 'gopls'})
-- lsp
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect,popup")

