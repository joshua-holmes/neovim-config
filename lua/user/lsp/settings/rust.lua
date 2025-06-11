local executors = require("rustaceanvim.executors")

return {
    -- Plugin configuration
    tools = {
        executor = executors.toggleterm,
    },
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>la", function()
                vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
                -- or vim.lsp.buf.codeAction() if you don't want grouping.
            end, { silent = true, buffer = bufnr })
            vim.keymap.set("n", "gh", function()
                vim.cmd.RustLsp({ "hover", "actions" })
            end, { silent = true, buffer = bufnr })

            -- force border around hover windows
            local orig_open_floating_preview = vim.lsp.util.open_floating_preview
            vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
              opts = opts or {}
              opts.border = opts.border or "rounded"
              return orig_open_floating_preview(contents, syntax, opts, ...)
            end
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
                cargo = {
                    -- desired target as string, if target is different than host
                    target_os = nil,
                    -- cargo features here as a list of strings
                    features = {},
                },
            },
        },
    },
    -- DAP configuration
    dap = {},
}
