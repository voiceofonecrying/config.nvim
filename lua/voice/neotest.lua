local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh('nvim-neotest/neotest'),
	gh('nvim-neotest/neotest-python'),
	}

local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			args = { "--log-level", "DEBUG" },
		}),
	},
})

vim.keymap.set("n", "<leader>tr", function() neotest.run.run() end, { desc = "Neotest: run test" })
vim.keymap.set("n", "<leader>td", function()
				require('dap-python').resolve_python()
				neotest.run.run({ strategy = "dap" })
end, { desc = "Neotest: debug test" })
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Neotest: run file" })
vim.keymap.set("n", "<leader>tq", function() neotest.run.stop() end, { desc = "Neotest: stop" })
vim.keymap.set("n", "<leader>to", function() neotest.output_panel.toggle() end, { desc = "Neotest: output" })
vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Neotest: summary" })

