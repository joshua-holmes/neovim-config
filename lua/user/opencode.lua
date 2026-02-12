local status_ok, opencode = pcall(require, "opencode")
if not status_ok then
    print("Failed to load opencode")
    return
end


vim.g.opencode_opts = {}

vim.o.autoread = true

vim.keymap.set({ "n", "t" }, "<C-.>", function() opencode.toggle() end, { desc = "Toggle opencode" })
