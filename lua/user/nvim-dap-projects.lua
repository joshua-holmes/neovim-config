local status_ok, nvim_dap_projects = pcall(require, "nvim-dap-projects")
if not status_ok then
	print("Failed to load nvim-dap-projects")
	return
end

nvim_dap_projects.search_project_config()
