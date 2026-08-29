local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh('mfussenegger/nvim-dap'),
	gh('mfussenegger/nvim-dap-python'),
	gh('rcarriga/nvim-dap-ui'),
	gh('theHamsta/nvim-dap-virtual-text'),
	}

local dap = require('dap')
dap.adapters.debugpy = {
type = 'executable';
command = 'poetry run python';
args = { '-m', 'debugpy.adapter', '--no-header', '--no-summary', '-q' };
cwd = '${workspaceFolder}';
}
require('nvim-dap-virtual-text').setup({ })
require("dapui").setup()
vim.keymap.set("n", "<leader>du", function() require('dapui').toggle() end, { desc = "DAP: toggle UI" })

vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end, { desc = "DAP: step over" })
vim.keymap.set("n", "<F9>", function()
	dap.step_into()
end, { desc = "DAP: step into" })
vim.keymap.set("n", "<F8>", function()
	dap.continue()
end, { desc = "DAP: continue" })
vim.keymap.set("n", "<F7>", function()
	dap.step_out()
end, { desc = "DAP: step out" })
vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { desc = "DAP: toggle breakpoint" })
