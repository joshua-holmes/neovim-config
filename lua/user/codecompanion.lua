local status_ok, cc = pcall(require, "codecompanion")
if not status_ok then
    print("Failed to load codecompanion")
    return
end

cc.setup({
    display = {
        diff = {
            provider = "mini_diff",
        },
    },
    strategies = {
        chat = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
        cmd = { adapter = "anthropic" },
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
