local status_ok, dap = pcall(require, "dap")
if not status_ok then
    print("Failed to load dap")
    return
end

local cwd = vim.fn.getcwd()
local last_slash_i = string.len(cwd) - string.find(string.reverse(cwd), "/") + 2
local basename = string.sub(cwd, last_slash_i)

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}

dap.configurations.rust = {
    {
        name = basename,
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/" .. basename
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

