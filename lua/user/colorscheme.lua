---- This uses a single specified colorscheme
local colorscheme = "vague"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    print("Colorscheme " .. colorscheme .. " not found!")
    return
end

---- This creates a dynamic colorscheme based on the wallpaper
-- local status_ok, pywal = pcall(require, "pywal16")
-- if not status_ok then
--     print("Failed to load pywal")
--     return
-- end
--
-- pywal.setup()
