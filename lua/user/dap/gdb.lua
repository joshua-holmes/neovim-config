local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("Failed to load dap")
	return
end

local cwd = vim.fn.getcwd()
local last_slash_i = string.len(cwd) - string.find(string.reverse(cwd), "/") + 2

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
    args = { "--quiet", "--interpreter=dap" }
}

local base_config = {
	type = "gdb",
	name = "${workspaceFolderBasename}",
	request = "launch",
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
}

----------------- put custom configs here -----------------
local configs = {
	rust = {
		program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
	},
}
-----------------------------------------------------------

-- copy base_config into each config, without overwriting
for _, config in pairs(configs) do
	for key, value in pairs(base_config) do
		if config[key] == nil then
			config[key] = value
		end
	end
end

dap.configurations.rust = { configs.rust }
