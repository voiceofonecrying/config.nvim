local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add { gh("akinsho/toggleterm.nvim"), }

require("toggleterm").setup()

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	count = 2,
	direction = "float",
	float_opts = {
		border = "double",
	},
})

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>tm", "<cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<leader>tg", function()
	lazygit:toggle()
end)
