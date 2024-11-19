local nvim_dap_ok, nvim_dap_projects = pcall(require, "nvim-dap-projects")
if not nvim_dap_ok then
	print("Failed to load nvim-dap-projects")
	return
end

require "user.dap.adapters"
require "user.dap.configurations"

vim.fn.sign_define("DapBreakpoint", { text = "🛑" })
vim.fn.sign_define("DapStopped", { text = "↪" })

nvim_dap_projects.search_project_config() -- this line must be at bottom of file
