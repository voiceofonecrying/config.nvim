local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh('mfussenegger/nvim-dap'),
	gh('mfussenegger/nvim-dap-python'),
	gh('rcarriga/nvim-dap-ui'),
	gh('theHamsta/nvim-dap-virtual-text'),
}

local dap = require('dap')
local debug_env = {
	PYDEVD_USE_CYTHON = "NO",
	PYDEVD_USE_FRAME_EVAL = "NO",
	PYDEVD_DISABLE_FILE_VALIDATION = "1",
}


require('dapui').setup()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

dap.configurations.python = dap.configurations.python or {}
table.insert(dap.configurations.python, {
	type = 'python',
	request = 'launch',
	name = 'Python: current file (debugpy workaround)',
	program = '${file}',
	justMyCode = false,
	env = debug_env,
})
require('nvim-dap-virtual-text').setup({})
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

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
