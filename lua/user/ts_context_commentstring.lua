local status_ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if not status_ok then
    print("Failed to load ts-context-commentstring")
    return
end

ts_context_commentstring.setup()

vim.g.skip_ts_context_commentstring_module = true
