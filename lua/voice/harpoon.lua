local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
	}

local harpoon = require("harpoon")
harpoon.setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true
	}
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<F1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<F2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<F3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<F4>", function() harpoon:list():select(4) end)
