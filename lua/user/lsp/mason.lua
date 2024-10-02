local servers = {
    "asm_lsp",
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "glsl_analyzer",
    "html",
    "jsonls",
    "lemminx",
    "ltex",
    "lua_ls",
    "marksman",
    "pyright",
    "rust-tools", -- `rust-tools` handles setting lspconfig with rust, so call lspconfig with this instead of rust_analyzer
    "sqlls",
    "terraformls",
    "ts_ls",
    "vimls",
    "yamlls",
    "zls",
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

local servers_to_ensure_installed = {}
local excluded_from_check = { -- add servers to exclude form mason's lspconfig compatibility check here
    "rust-tools",
    "glsl_analyzer",
}
for _,s in pairs(servers) do
    local is_excluded = false;
    for _,e in pairs(excluded_from_check) do
        if e == s then
            is_excluded = true;
            break;
        end
    end
    if not is_excluded then
        table.insert(servers_to_ensure_installed, s)
    end
end
require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = servers_to_ensure_installed,
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    print("Failed to load lspconfig")
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    -- use `rust-tools` instead of `rust_analyzer`
    if server == "rust-tools" then
        local rust_tools_ok, rt = pcall(require, "rust-tools")
        if not rust_tools_ok then
            print("Failed to load rust-tools")
            goto continue
        end
        opts.on_attach = function(client, bufnr)
            -- run normal `on_attach` function
            opts.on_attach(client, bufnr)
            -- override `whichkey` code action bind just for this buffer
            vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
            vim.keymap.set("n", "gh", rt.hover_actions.hover_actions, { buffer = bufnr })
        end
        rt.setup({
            server = opts
        })
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
