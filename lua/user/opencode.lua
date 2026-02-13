local status_ok, opencode = pcall(require, "opencode")
if not status_ok then
    print("Failed to load opencode")
    return
end


vim.g.opencode_opts = {}

vim.o.autoread = true

vim.keymap.set({ "n", "t" }, "<C-.>", function() opencode.toggle() end, { desc = "Toggle opencode" })
vim.keymap.set({ "n", "t" }, "<C-u>", function() opencode.command("session.half.page.up") end, { desc = "Scroll up in opencode" })
vim.keymap.set({ "n", "t" }, "<C-d>", function() opencode.command("session.half.page.down") end, { desc = "Scroll down in opencode" })
