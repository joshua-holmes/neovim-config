local status_ok, cc = pcall(require, "codecompanion")
if not status_ok then
    print("Failed to load codecompanion")
    return
end

local is_work_pc = os.getenv("MY_NVIM_TARGET") == "work"
local adapter = (is_work_pc and "copilot") or "anthropic"

cc.setup({
    display = {
        diff = {
            provider = "mini_diff",
        },
    },
    strategies = {
        chat = { adapter = adapter },
        inline = { adapter = adapter },
        cmd = { adapter = adapter },
    },
    adapters = {
        http = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = "cmd:gpg --decrypt --quiet ~/.secrets/anthropic_api_key.gpg",
                    },
                })
            end,
        }
    },
})
