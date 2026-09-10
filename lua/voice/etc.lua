local gh = function(x) return 'https://github.com/' .. x end
vim.g.mapleader = " "

-- Miscellaneous plugins with minimal configuration

vim.pack.add {
	gh('folke/lazydev.nvim'),
	gh("nvim-lua/plenary.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh('antoinemadec/FixCursorHold.nvim'),
	gh("lewis6991/gitsigns.nvim"),
	gh("linux-cultist/venv-selector.nvim"),
	gh("cohama/lexima.vim"),
	gh("NumToStr/Comment.nvim"),
	gh("nvim-neo-tree/neo-tree.nvim"),
	gh('nvim-neotest/nvim-nio'),
	gh('LintaoAmons/cd-project.nvim'),
	gh('soulis-1256/eagle.nvim'),
	gh('error311/wayfinder.nvim')
}

require('wayfinder').setup()
vim.keymap.set('n', '<leader>wf', '<cmd>Wayfinder<cr>')
require('eagle').setup({
				keyboard_mode = true
})
vim.cmd.packadd('nvim.undotree')
vim.keymap.set('n', '<leader>u', '<cmd>Undotree<cr>')
require('lazydev').setup({ library = { 'nvim-dap-ui' } })
vim.keymap.set("n", "<leader>ps", "<cmd>CdProject<cr>", { desc = "CD Project: change directory to project root" })
require("neo-tree").setup({})
vim.keymap.set('n', '<leader>pv', '<cmd>Neotree toggle<cr>')
require("venv-selector").setup()
vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>")
require('Comment').setup()

local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

vim.keymap.set("n", "<leader>pc", pack_clean)
