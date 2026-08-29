local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
	gh("CopilotC-Nvim/CopilotChat.nvim"),
	gh("github/copilot.vim"),
	}

require("CopilotChat").setup({
	model = 'auto',
	temperature = 0.1, -- Lower = focused, higher = creative
	trusted_tools = nil,
	window = {
		layout = 'vertical',
		width = 0.3,
		border = 'rounded',
		title = '🤖 AI Assistant',
	},
	headers = {
		user = '👤 You',
		assistant = '🤖 Copilot',
		tool = '🔧 Tool',
	},
	separator = '━━',
	auto_fold = true,
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
vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#7C3AED', bg = 'none', bold = true })
vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#374151', bg = 'none' })
vim.keymap.set('n', "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat: toggle" })
vim.keymap.set('n', "<leader>cp", "<cmd>CopilotChatPrompts<cr>", { desc = "CopilotChat: prompts" })
vim.keymap.set('n', "<leader>cx", "<cmd>CopilotChatReset<cr>", { desc = "CopilotChat: reset" })
