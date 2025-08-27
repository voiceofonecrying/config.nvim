local GH = 'https://github.com/'
vim.pack.add {
    { src = GH .. 'mfussenegger/nvim-dap' },
    { src = GH .. 'mfussenegger/nvim-dap-python' },
    { src = GH .. 'igorlfs/nvim-dap-view' },
    { src = GH .. 'theHamsta/nvim-dap-virtual-text' },
    { src = GH .. 'nvim-neotest/nvim-nio' },
    { src = GH .. 'nvim-neotest/neotest' },
    { src = GH .. 'nvim-neotest/neotest-plenary' },
    { src = GH .. 'nvim-neotest/neotest-vim-test' },
    { src = GH .. 'nvim-neotest/neotest-python' },
    --{ src = GH .. 'linux-cultist/venv-selector.nvim' },
}

local dap = require 'dap'
local widgets = require 'dap.ui.widgets'
local dap_python = require 'dap-python'
local neotest = require 'neotest'
require('nvim-dap-virtual-text').setup {}
neotest.setup {

    adapters = {
        require 'neotest-python' {
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG' },
            runner = 'pytest',
            python = 'python3',

            --        }),
            require 'neotest-plenary',
            require 'neotest-vim-test' {
                ignore_file_types = { 'python', 'vim', 'lua' },
            },
        },
    },
}
dap_python.setup 'python3'
dap_python.test_runner = 'pytest'

vim.keymap.set('n', '<leader>dp', function()
    neotest.run.run()
end)
vim.keymap.set('n', '<leader>dd', function()
    neotest.run.run { strategy = 'dap', suite = false }
end)
vim.keymap.set('n', '<leader>da', function()
    neotest.run.run(vim.fn.expand '%')
end)
vim.keymap.set('n', '<leader>dq', function()
    neotest.run.attach()
end)

--DAP gets <leader>d namespace
vim.keymap.set('n', '<leader>db', function()
    dap.toggle_breakpoint()
end)
vim.keymap.set('n', '<leader>ds', function()
    dap.continue()
    vim.cmd ':DapViewOpen'
end)
vim.keymap.set('n', '<leader>dr', function()
    dap.restart()
end)
vim.keymap.set('n', '<leader>dk', function()
    dap.terminate()
    neotest.run.stop()
end)
vim.keymap.set('n', '<leader>dn', function()
    dap.step_over()
end)
vim.keymap.set('n', '<leader>di', function()
    dap.step_into()
end)
vim.keymap.set('n', '<leader>do', function()
    dap.step_out()
end)
vim.keymap.set('n', '<leader>dc', function()
    dap.run_to_cursor()
end)
vim.keymap.set('n', '<F7>', function()
    dap.step_over()
end)
vim.keymap.set('n', '<F8>', function()
    dap.step_into()
end)

vim.keymap.set('n', '<leader>du', function()
    neotest.output_panel.toggle()
end)

vim.keymap.set('n', '<leader>dw', function()
    neotest.summary.toggle()
end)

vim.keymap.set('n', '<leader>dh', function()
    widgets.hover()
end)
