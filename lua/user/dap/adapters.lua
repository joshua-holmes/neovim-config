local status_ok, dap = pcall(require, "dap")
if not status_ok then
    print("Failed to load dap")
    return
end

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--quiet", "--interpreter=dap", }
}

dap.adapters.rust_gdb = {
    type = "executable",
    command = "rust-gdb",
    args = { "--quiet", "--interpreter=dap", }
}

dap.adapters.lldb_dap = {
    type = "executable",
    command = "lldb-dap",
}

dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}
