local servers = {
    "asm_lsp",
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "gdscript",
    "glsl_analyzer",
    "html",
    "jsonls",
    "lemminx",
    "ltex",
    "lua_ls",
    "marksman",
    "pyright",
    "rust", -- we use rustaceanvim for lsp, but setup is different for it
    "rust_analyzer",
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
    "rust",
    "gdscript",
}
for _, s in pairs(servers) do
    local is_excluded = false
    for _, e in pairs(excluded_from_check) do
        if e == s then
            is_excluded = true
            break
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
    automatic_enable = {
        exclude = {
            "rust_analyzer", -- letting rustaceanvim handle it
            "pyright",       -- something already starts this, not sure what
            "bashls",        -- something already starts this, not sure what
            "zls",           -- something already starts this, not sure what
        }
    }
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

    if server == "rust_analyzer" then
        goto continue
    end

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        if server == "rust" then
            -- merge on_attach
            local old_fn = conf_opts.server.on_attach
            conf_opts.server.on_attach = function(client, bufnr)
                opts.on_attach(client, bufnr)
                old_fn(client, bufnr)
            end
            conf_opts.server.capabilities = opts.capabilities
            vim.g.rustaceanvim = conf_opts
            goto continue
        end
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
    ::continue::
end
