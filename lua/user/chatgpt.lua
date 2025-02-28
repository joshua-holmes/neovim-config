local cmp_status_ok, chatgpt = pcall(require, "chatgpt")
if not cmp_status_ok then
    print("Failed to load chatgpt")
    return
end

local home = vim.fn.expand("$HOME")
chatgpt.setup({
    api_key_cmd = "gpg --decrypt " .. home .. "/.secrets/openai_api_key.gpg",
    openai_params = {
        model = "gpt-4o-mini",
        max_tokens = 1000,
    }
})
