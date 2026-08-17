local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("Aejkatappaja/cendre"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("cohama/lexima.vim"),
	{ src = gh("HosseyNJF/behave-lsp.nvim"),      build = "cd lsp_server && uv tool install . --force --reinstall" },
	gh("lewis6991/gitsigns.nvim"),
	gh("akinsho/toggleterm.nvim"),
	gh("nickkadutskyi/jb.nvim"),
	gh("linux-cultist/venv-selector.nvim"),
	gh("NumToStr/Comment.nvim"),
	gh("saghen/blink.lib"),
	gh("saghen/frizbee"),
	gh("saghen/blink.cmp"),
	gh("nvim-neo-tree/neo-tree.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("sschleemilch/slimline.nvim"),
	{ src = gh("CopilotC-Nvim/CopilotChat.nvim"), build = "make tiktoken" }
}


require("CopilotChat").setup({
	model = 'auto', -- AI model to use
	temperature = 0.1, -- Lower = focused, higher = creative
	trusted_tools = nil, -- Require approval for all tool calls
	window = {
		layout = 'vertical', -- 'vertical', 'horizontal', 'float'
		width = 0.3, -- 30% of screen width
		border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
		title = '🤖 AI Assistant',
	},
	headers = {
		user = '👤 You',
		assistant = '🤖 Copilot',
		tool = '🔧 Tool',
	},
	separator = '━━',
	auto_fold = true, -- Automatically folds non-assistant messages
})
-- Auto-command to customize chat buffer behavior
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = 'copilot-chat',
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.opt_local.conceallevel = 0
	end,
})
-- In your colorscheme or init.lua
vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#7C3AED', bg = 'none', bold = true })
vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#374151', bg = 'none' })
vim.keymap.set('n', "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat: toggle" })
vim.keymap.set('n', "<leader>cp", "<cmd>CopilotChatPrompts<cr>", { desc = "CopilotChat: prompts" })
vim.keymap.set('n', "<leader>cx", "<cmd>CopilotChatReset<cr>", { desc = "CopilotChat: reset" })

vim.keymap.set('n', "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat: explain" })
vim.keymap.set('n', "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "CopilotChat: review" })
vim.keymap.set('n', "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "CopilotChat: fix" })
vim.keymap.set('n', "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "CopilotChat: optimize" })
vim.keymap.set('n', "<leader>cd", "<cmd>CopilotChatDocs<cr>", { desc = "CopilotChat: docs" })
vim.keymap.set('n', "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "CopilotChat: tests" })

require("slimline").setup({})
require("neo-tree").setup({})
vim.keymap.set('n', '<leader>pv', '<cmd>Neotree toggle<cr>')
require("venv-selector").setup()
vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>")
require("toggleterm").setup()
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<cr>')
require('Comment').setup({})

require('telescope').setup({
	extensions = {
		["ui_select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
})
require('telescope').load_extension('ui-select')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = { preset = "super-tab" },
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				documentation = { auto_show = false },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})

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
