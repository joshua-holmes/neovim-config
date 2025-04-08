local status_ok, cc = pcall(require, "codecompanion")
if not status_ok then
	print("Failed to load codecompanion")
	return
end

cc.setup({
    strategies = {
        chat = {adapter = "openai"},
        inline = {adapter = "openai"},
        cmd = {adapter = "openai"},
    },
    adapters = {
        openai = function()
            return require("codecompanion.adapters").extend("openai", {
                env = {
                    api_key = "cmd:gpg --decrypt --quiet ~/.secrets/openai_api_key.gpg"
                },
            })
        end,
    }
})
