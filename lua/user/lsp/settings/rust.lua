local executors = require("rustaceanvim.executors")

return {
	-- Plugin configuration
	tools = {
		executor = executors.toggleterm,
	},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "<leader>la", function()
				vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
				-- or vim.lsp.buf.codeAction() if you don't want grouping.
			end, { silent = true, buffer = bufnr })
			vim.keymap.set("n", "gh", function()
				vim.cmd.RustLsp({ "hover", "actions" })
			end, { silent = true, buffer = bufnr })
		end,
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
				-- put cargo features here as a list of strings
				cargo_features = {},
			},
		},
	},
	-- DAP configuration
	dap = {},
}
