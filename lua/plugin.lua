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
	gh("HosseyNJF/behave-lsp.nvim"),
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
	gh("CopilotC-Nvim/CopilotChat.nvim"),
	gh("github/copilot.vim"),
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
	gh('rcarriga/nvim-notify'),
	gh('folke/noice.nvim'),
	gh('nvim-neotest/nvim-nio'),
	gh('antoinemadec/FixCursorHold.nvim'),
	gh('nvim-neotest/neotest'),
	gh('nvim-neotest/neotest-python'),
}

require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			python = ".venv/bin/python",
		}),
	},
})
vim.keymap.set("n", "<leader>tt", function()
				vim.api.nvim_set_current_dir(vim.fs.dirname(vim.fn.expand("%:p")))
				require("neotest").run.run()
end, { desc = "Neotest: run test" })
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Neotest: run file" })


require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
	},
	cmdline = {
		view = "cmdline",
	}
})
vim.keymap.set("n", "<leader>nn", "<cmd>NoiceHistory<cr>", { desc = "Noice: history" })


-- Copilot Chat Integration
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

local function open_terminal(cmd)
	local term = Terminal:new({
		cmd = cmd,
		hidden = true,
		direction = "horizontal",
		size = 12,
		close_on_exit = false,
	})
	term:open()
end

local function current_pytest_target()
	local file = vim.fn.expand("%:p")
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)

	for i = #lines, 1, -1 do
		local line = lines[i]
		local func = line:match("^%s*def%s+(test[%w_]*)%s*%(")
		if func then
			local func_indent = #line:match("^(%s*)")
			local class_name

			for j = i - 1, 1, -1 do
				local class_line = lines[j]
				local class_name_match = class_line:match("^%s*class%s+(Test[%w_]*)%s*[%(:]")
				if class_name_match and #class_line:match("^(%s*)") < func_indent then
					class_name = class_name_match
					break
				end
			end

			if class_name then
				return file .. "::" .. class_name .. "::" .. func
			end

			return file .. "::" .. func
		end
	end

	return file
end
local function project_root_for_current_file()
	local file_dir = vim.fn.expand("%:p:h")
	return vim.fs.root(file_dir, { "pyproject.toml", ".git" }) or vim.fn.getcwd()
end

local function normalize_pytest_target(target, root)
	local file_part, node_part = target:match("^(.-)(::.*)$")
	if not file_part then
		file_part = target
		node_part = ""
	end

	local rel_file = vim.fs.relpath(root, file_part)
	if rel_file and rel_file ~= "" then
		file_part = rel_file
	end

	return file_part .. node_part
end

local function run_pytest_target(target)
	local root = project_root_for_current_file()
	local normalized_target = normalize_pytest_target(target, root)
	local cmd = string.format("poetry run pytest %s", normalized_target)
	open_terminal(cmd)
end

local function run_current_file_pytest()
	run_pytest_target(vim.fn.expand("%:p"))
end

local function run_current_test_pytest()
	run_pytest_target(current_pytest_target())
end

vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>tm", "<cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<leader>tg", function()
	lazygit:toggle()
end)
-- vim.keymap.set("n", "<leader>tf", run_current_file_pytest, { desc = "Pytest: current file" })
-- vim.keymap.set("n", "<leader>td", run_current_test_pytest, { desc = "Pytest: current test" })
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

local harpoon = require("harpoon")
harpoon.setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<F1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<F2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<F3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<F4>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<F9>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<F10>", function() harpoon:list():next() end)


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
