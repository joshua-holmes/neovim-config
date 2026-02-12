require("nvim-treesitter.configs")
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    print("Failed to load nvim-treesitter.configs")
    return
end

configs.setup({
    ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "ipkg" }, -- list of problematic parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = { }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true,
        -- disable = { "python", "css" }
    },
    install_dir = vim.fn.stdpath('data') .. '/site',
})
