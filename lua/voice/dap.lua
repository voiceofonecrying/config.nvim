local GH = 'https://github.com/'
vim.pack.add {
    { src = GH .. 'mfussenegger/nvim-dap' },
    { src = GH .. 'mfussenegger/nvim-dap-python' },
    { src = GH .. 'igorlfs/nvim-dap-view' },
    { src = GH .. 'theHamsta/nvim-dap-virtual-text' },
    { src = GH .. 'nvim-neotest/nvim-nio' },
    { src = GH .. 'nvim-neotest/neotest' },
    { src = GH .. 'nvim-neotest/neotest-plenary' },
    { src = GH .. 'nvim-neotest/neotest-python' },
    { src = GH .. 'linux-cultist/venv-selector.nvim' },
    { src = GH .. 'jay-babu/mason-nvim-dap.nvim' },
}

local dap = require 'dap'
local widgets = require 'dap.ui.widgets'
local neotest = require 'neotest'
require 'mason-nvim-dap'.setup({
    automatic_setup = true,
    ensure_installed = { 'debugpy' }
})
require 'dap-python'.setup('debugpy-adapter')
require('venv-selector').setup({})
require('nvim-dap-virtual-text').setup {}
neotest.setup {
    adapters = {
        require 'neotest-python' {
            dap = {
                args = function()
                    return { "--log-level", "DEBUG", "-s", "-o", string.format([[pythonpath=%s]], vim.loop.cwd()) }
                end,
                justMyCode = false,
            },
        },
    },
}
dap.set_log_level('TRACE')
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', {
    text = '•',
    texthl = 'DapBreakpoint',
    linehl = 'DapBreakpoint',
    numhl =
    'DapBreakpoint'
})
vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.keymap.set('n', '<leader>vs', function()
    vim.cmd(':VenvSelect')
end)

--DAP gets <leader>d namespace
vim.keymap.set('n', '<leader>dp', function()
    neotest.run.run()
end, { desc = 'Run nearest test' })
vim.keymap.set('n', '<leader>dd', function()
    neotest.run.run { strategy = 'dap', suite = false }
end, { desc = 'Debug nearest test' })
vim.keymap.set('n', '<leader>dl', function()
    neotest.run.run_last { strategy = 'dap', suite = false }
end, { desc = 'Debug last test' })
vim.keymap.set('n', '<leader>da', function()
    neotest.run.run(vim.fn.expand '%')
end, { desc = 'Run file' })
vim.keymap.set('n', '<leader>dq', function()
    neotest.run.attach()
end, { desc = 'Attach to tests' })
vim.keymap.set('n', '<leader>db', function()
    dap.toggle_breakpoint()
end, { desc = 'Breakpoint' })
vim.keymap.set('n', '<leader>ds', function()
    dap.continue()
end, { desc = 'Run Program' })
vim.keymap.set('n', '<leader>dr', function()
    dap.restart()
end, { desc = 'Restart' })
vim.keymap.set('n', '<leader>dk', function()
    dap.terminate()
    neotest.run.stop()
end, { desc = 'Stop' })
vim.keymap.set('n', '<leader>dn', function()
    dap.step_over()
end, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>di', function()
    dap.step_into()
end, { desc = 'Step In' })
vim.keymap.set('n', '<leader>do', function()
    dap.step_out()
end, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>dc', function()
    dap.run_to_cursor()
end, { desc = 'Go to cursor' })
vim.keymap.set('n', '<F7>', function()
    dap.step_over()
end)
vim.keymap.set('n', '<F8>', function()
    dap.step_into()
end)
vim.keymap.set('n', '<leader>du', function()
    neotest.output_panel.toggle()
end, { desc = 'Debug panel' })
vim.keymap.set('n', '<leader>dz', function()
    neotest.output_panel.clear()
end, { desc = 'Debug panel' })
vim.keymap.set('n', '<leader>de', function()
    neotest.summary.toggle()
end, { desc = 'Test suite summary' })
vim.keymap.set('n', '<leader>dh', function()
    widgets.hover()
end, { desc = 'Hover' })
vim.keymap.set('n', '<leader>dv', '<cmd>DapViewToggle<CR>', { desc = 'DAP View' })
vim.keymap.set('n', '<leader>dw', '<cmd>DapViewWatch<CR>', { desc = 'Add watch' })
