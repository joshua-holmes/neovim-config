local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	print("Failed to load which-key")
	return
end

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

which_key.add({
	nowait = true,
	remap = false,
	{
		"<leader>;",
		"<cmd>Alpha<cr>",
		desc = "Dashboard",
	},
	{
		"<leader>M",
		":MarkdownPreviewToggle<cr>",
		desc = "Markdown Preview Toggle",
	},
	{
		"<leader>P",
		"<cmd>lua require('telescope').extensions.projects.projects()<cr>",
		desc = "Projects",
	},
	{
		"<leader>[",
		"<Plug>(MatchitNormalMultiBackward)",
		desc = "Jump to start of contianer",
	},
	{
		"<leader>]",
		"<Plug>(MatchitNormalMultiForward)",
		desc = "Jump to end of contianer",
	},
	{
		"<leader>b",
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		desc = "Buffers",
	},
	{
		"<leader>c",
		"<cmd>Bdelete!<CR>",
		desc = "Close Buffer",
	},
	{ "<leader>d", group = "Debug" },
	{
		"<leader>db",
		":lua require('dap').toggle_breakpoint()<cr>",
		desc = "Toggle breakpoint",
	},
	{
		"<leader>dc",
		":lua require('dap').continue()<cr>",
		desc = "Continue",
	},
	{
		"<leader>di",
		":lua require('dap').step_into()<cr>",
		desc = "Step into",
	},
	{
		"<leader>dl",
		":lua require('dap').run_last()<cr>",
		desc = "Run last",
	},
	{
		"<leader>do",
		":lua require('dap').step_over()<cr>",
		desc = "Step over",
	},
	{
		"<leader>dr",
		":lua require('dap').repl.open()<cr>",
		desc = "Inspect state using REPL",
	},
	{
		"<leader>du",
		":lua require('dapui').toggle()<cr>",
		desc = "Toggle DAP UI",
	},
	{
		"<leader>e",
		"<cmd>NvimTreeToggle<cr>",
		desc = "Explorer",
	},
	{ "<leader>f", group = "Find" },
	{
		"<leader>ff",
		":Telescope find_files<CR>",
		desc = "Find files",
	},
	{
		"<leader>fp",
		"<cmd>Telescope media_files<CR>",
		desc = "Find photos",
	},
	{
		"<leader>ft",
		"<cmd>Telescope live_grep theme=ivy<CR>",
		desc = "Find text",
	},
	{ "<leader>g", group = "Git" },
	{
		"<leader>gR",
		"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
		desc = "Reset Buffer",
	},
	{
		"<leader>gb",
		"<cmd>Telescope git_branches<cr>",
		desc = "Checkout branch",
	},
	{
		"<leader>gc",
		"<cmd>Telescope git_commits<cr>",
		desc = "Checkout commit",
	},
	{
		"<leader>gd",
		"<cmd>Gitsigns diffthis HEAD vertical=true<cr>",
		desc = "Diff",
	},
	{
		"<leader>gg",
		"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
		desc = "Lazygit",
	},
	{
		"<leader>gj",
		"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
		desc = "Next Hunk",
	},
	{
		"<leader>gk",
		"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
		desc = "Prev Hunk",
	},
	{
		"<leader>gl",
		"<cmd>lua require 'gitsigns'.blame_line()<cr>",
		desc = "Blame",
	},
	{
		"<leader>go",
		"<cmd>Telescope git_status<cr>",
		desc = "Open changed file",
	},
	{
		"<leader>gp",
		"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
		desc = "Preview Hunk",
	},
	{
		"<leader>gr",
		"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
		desc = "Reset Hunk",
	},
	{
		"<leader>gs",
		"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
		desc = "Stage Hunk",
	},
	{
		"<leader>gu",
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		desc = "Undo Stage Hunk",
	},
	{
		"<leader>h",
		"<cmd>nohlsearch<CR><cmd>lua require('mini.map').refresh()<CR>",
		desc = "No Highlight",
	},
	{ "<leader>l", group = "LSP" },
	{
		"<leader>lI",
		"<cmd>NullLsInfo<cr>",
		desc = "Formater Info",
	},
	{
		"<leader>lS",
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		desc = "Workspace Symbols",
	},
	{
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<cr>",
		desc = "Code Action",
	},
	{
		"<leader>ld",
		"<cmd>Telescope diagnostics bufnr=0<cr>",
		desc = "Document Diagnostics",
	},
	{
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format{async=true}<cr>",
		desc = "Format",
	},
	{
		"<leader>li",
		"<cmd>LspInfo<cr>",
		desc = "Info",
	},
	{
		"<leader>lj",
		"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
		desc = "Next Diagnostic",
	},
	{
		"<leader>lk",
		"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
		desc = "Prev Diagnostic",
	},
	{
		"<leader>ll",
		"<cmd>lua vim.lsp.codelens.run()<cr>",
		desc = "CodeLens Action",
	},
	{
		"<leader>lq",
		"<cmd>lua vim.diagnostic.setloclist()<cr>",
		desc = "Quickfix",
	},
	{
		"<leader>lr",
		"<cmd>lua vim.lsp.buf.rename()<cr>",
		desc = "Rename",
	},
	{
		"<leader>ls",
		"<cmd>Telescope lsp_document_symbols<cr>",
		desc = "Document Symbols",
	},
	{
		"<leader>lw",
		"<cmd>Telescope diagnostics<cr>",
		desc = "Workspace Diagnostics",
	},
	{ "<leader>m", group = "MiniMap" },
	{
		"<leader>mc",
		"<cmd>lua require('mini.map').close()<cr>",
		desc = "Close",
	},
	{
		"<leader>mm",
		"<cmd>lua require('mini.map').toggle()<cr>",
		desc = "Toggle",
	},
	{
		"<leader>mo",
		"<cmd>lua require('mini.map').open()<cr>",
		desc = "Open",
	},
	{
		"<leader>mr",
		"<cmd>lua require('mini.map').refresh()<cr>",
		desc = "Refresh",
	},
	{ "<leader>p", group = "Packer" },
	{
		"<leader>pS",
		"<cmd>PackerStatus<cr>",
		desc = "Status",
	},
	{
		"<leader>pc",
		"<cmd>PackerCompile<cr>",
		desc = "Compile",
	},
	{
		"<leader>pi",
		"<cmd>PackerInstall<cr>",
		desc = "Install",
	},
	{
		"<leader>ps",
		"<cmd>PackerSync<cr>",
		desc = "Sync",
	},
	{
		"<leader>pu",
		"<cmd>PackerUpdate<cr>",
		desc = "Update",
	},
	{
		"<leader>q",
		"<cmd>q!<CR>",
		desc = "Quit",
	},
	{ "<leader>s", group = "Search" },
	{
		"<leader>sC",
		"<cmd>Telescope commands<cr>",
		desc = "Commands",
	},
	{
		"<leader>sM",
		"<cmd>Telescope man_pages<cr>",
		desc = "Man Pages",
	},
	{
		"<leader>sR",
		"<cmd>Telescope registers<cr>",
		desc = "Registers",
	},
	{
		"<leader>sc",
		"<cmd>Telescope colorscheme<cr>",
		desc = "Colorscheme",
	},
	{
		"<leader>sh",
		"<cmd>Telescope help_tags<cr>",
		desc = "Find Help",
	},
	{
		"<leader>sk",
		"<cmd>Telescope keymaps<cr>",
		desc = "Keymaps",
	},
	{
		"<leader>sr",
		"<cmd>Telescope oldfiles<cr>",
		desc = "Open Recent File",
	},
	{
		"<leader>sw",
		"<cmd>Spectre<cr>",
		desc = "Find and replace across repo",
	},
	{ "<leader>t", group = "Terminal" },
	{
		"<leader>tf",
		"<cmd>ToggleTerm direction=float<cr>",
		desc = "Float",
	},
	{
		"<leader>th",
		"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
		desc = "Horizontal",
	},
	{
		"<leader>tv",
		"<cmd>ToggleTerm size=80 direction=vertical<cr>",
		desc = "Vertical",
	},
	{
		"<leader>w",
		"<cmd>w!<CR>",
		desc = "Save",
	},
	{
		"<leader>/",
		"gcc",
		desc = "Comment",
		remap = true,
	},
	{
		mode = { "v" },
		{ "<leader>/", "gc", desc = "Comment", remap = true },
	},
})

which_key.setup(setup)
