local status_ok, dap = pcall(require, "dap")
if not status_ok then
    print("Failed to load dap")
    return
end

local base_config = {
    name = "${workspaceFolderBasename}",
    request = "launch",
    cwd = "${workspaceFolder}",
}

----------------- put custom configs here -----------------
-- NOTE: property "type" must match dap.configurations.<type> in adapters.lua
-- NOTE: env var "DEBUG_EP" will override the "program" property
local configs = {
    rust = {
        type = "rust_gdb",
        program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
    },
    zig = {
        type = "gdb",
        program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
    },
    python = {
        type = "python",
        program = "${file}",
        justMyCode = false,
    }
}
-----------------------------------------------------------

-- copy base_config into each config, without overwriting, then set dap.configurations
local ep = os.getenv("DEBUG_EP")
if ep then
    vim.notify("[config] Using debug endpoint \"" .. ep .. "\"", vim.log.levels.INFO, nil)
end
for lang, config in pairs(configs) do
    for key, value in pairs(base_config) do
        if config[key] == nil then
            config[key] = value
        end
        config.program = os.getenv("DEBUG_EP") or config.program
    end
    dap.configurations[lang] = { configs[lang] }
end
