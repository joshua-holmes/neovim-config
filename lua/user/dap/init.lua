local dap_projects_ok, dap_projects = pcall(require, "dap-projects")
if not dap_projects_ok then
	print("Failed to load dap-projects")
	return
end

require "user.dap.adapters"
require "user.dap.configurations"

vim.fn.sign_define("DapBreakpoint", { text = "🛑" })
vim.fn.sign_define("DapStopped", { text = "↪" })

dap_projects.search_project_config() -- this line must be at bottom of file
