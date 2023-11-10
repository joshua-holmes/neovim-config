local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    print("Failed to load null-ls")
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    ---------------
    -- NOTE: Required for clang_format warning about multiple offset_encoding values set at the same time
    -- on_init = function(new_client, _)
    --     new_client.offset_encoding = "utf-8"
    -- end,
    ---------------

    debug = false,
    sources = {
        formatting.prettier.with({
            extra_args = {
                "--tab-width", "2",
                "--semi", "true",
            }
        }),
        formatting.black.with({ extra_args = { "--line-length", "120" } }),
        formatting.stylua,
        formatting.sqlfmt,
        formatting.clang_format,
        -- diagnostics.flake8
    },
})
