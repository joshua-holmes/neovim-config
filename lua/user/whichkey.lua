local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	print("Failed to load which-key")
	return
end

vim.cmd([[
autocmd FileType cpp lua C_INCLUDE_HEADER_CLEANUP()
autocmd FileType c lua C_INCLUDE_HEADER_CLEANUP()
]])

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 30, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
		ellipsis = "…",
		-- set to false to disable all mapping icons,
		-- both those explicitely added in a mapping
		-- and those from rules
		mappings = true,
		--- See `lua/which-key/icons.lua` for more details
		--- Set to `false` to disable keymap icons from rules
		---@type wk.IconRule[]|false
		rules = {},
		-- use the highlights from mini.icons
		-- When `false`, it will use `WhichKeyIcon` instead
		colors = true,
		-- used by key format
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	},
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = true,
		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		-- row = math.huge,
		border = "rounded",
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = {
		{ "<auto>", mode = "nxsot" },
	},
}

local default_opts = {
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local function create_opts_table(mode, noremap)
	local new_table = {}
	for k, v in pairs(default_opts) do
		new_table[k] = v
	end
	new_table["mode"] = mode
	new_table["noremap"] = noremap
	return new_table
end

local n_opts = create_opts_table("n", true)
local n_opts_remap = create_opts_table("n", false)
local v_opts_remap = create_opts_table("v", false)

local n_mappings = {
	[";"] = { "<cmd>Alpha<cr>", "Dashboard" },
	["["] = { "<Plug>(MatchitNormalMultiBackward)", "Jump to start of contianer" },
	["]"] = { "<Plug>(MatchitNormalMultiForward)", "Jump to end of contianer" },
	b = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	d = {
		name = "Debug",
		b = { ":lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
		c = { ":lua require('dap').continue()<cr>", "Continue" },
		o = { ":lua require('dap').step_over()<cr>", "Step over" },
		i = { ":lua require('dap').step_into()<cr>", "Step into" },
		r = { ":lua require('dap').repl.open()<cr>", "Inspect state using REPL" },
		l = { ":lua require('dap').run_last()<cr>", "Run last" },
		u = { ":lua require('dapui').toggle()<cr>", "Toggle DAP UI" },
	},
	e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	w = { "<cmd>w!<CR>", "Save" },
	W = { ":lua require('pywal16').setup()<cr>", "Reload pywal colorscheme" },
	q = { "<cmd>q!<CR>", "Quit" },
	c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	h = { "<cmd>nohlsearch<CR><cmd>lua require('mini.map').refresh()<CR>", "No Highlight" },
	f = {
		name = "Find",
		f = {
			":Telescope find_files<CR>",
			"Find files",
		},
		t = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find text" },
		p = { "<cmd>Telescope media_files<CR>", "Find photos" },
	},
	P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>NullLsInfo<cr>", "Formater Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	m = {
		name = "MiniMap",
		m = { "<cmd>lua require('mini.map').toggle()<cr>", "Toggle" },
		r = { "<cmd>lua require('mini.map').refresh()<cr>", "Refresh" },
		o = { "<cmd>lua require('mini.map').open()<cr>", "Open" },
		c = { "<cmd>lua require('mini.map').close()<cr>", "Close" },
	},
	M = { ":MarkdownPreviewToggle<cr>", "Markdown Preview Toggle" },
	s = {
		name = "Search",
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		w = { "<cmd>Spectre<cr>", "Find and replace across repo" },
	},

	t = {
		name = "Terminal",
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}

local n_mappings_remap = {
	["/"] = { "gcc", "Comment" },
}

local v_mappings_remap = {
	["/"] = { "gc", "Comment" },
}

which_key.setup(setup)
which_key.register(n_mappings, n_opts)
which_key.register(n_mappings_remap, n_opts_remap)
which_key.register(v_mappings_remap, v_opts_remap)
