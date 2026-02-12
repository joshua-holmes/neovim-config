-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- Core dependencies
    { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    
    { -- Markdown preview in browser
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    
    { "nvim-pack/nvim-spectre" }, -- Tool to replace all text in entire git repo
    
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
    },
    
    { "tamton-aquib/duck.nvim" }, -- Absolutely not useful...
    { "HiPhish/rainbow-delimiters.nvim" },
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
    { "kyazdani42/nvim-web-devicons" },
    { "kyazdani42/nvim-tree.lua" },
    { "akinsho/bufferline.nvim" },
    { "moll/vim-bbye" },
    { "ahmedkhalf/project.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },
    { "goolord/alpha-nvim" },
    { "folke/which-key.nvim" },
    { "nvim-lualine/lualine.nvim" },
    { "tpope/vim-sleuth" },
    { "echasnovski/mini.nvim" },
    -- { "folke/neodev.nvim" }, -- Adds lua docs in neovim for neovim config files
    { "lommix/godot.nvim" },

    -- Colorschemes
    { "rebelot/kanagawa.nvim" },
    { "savq/melange-nvim" },
    { "ribru17/bamboo.nvim" },
    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup()
        end
    },

    -- cmp plugins
    { "hrsh7th/nvim-cmp" }, -- The completion plugin
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "hrsh7th/cmp-cmdline" }, -- cmdline completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },

    -- Snippets
    { "L3MON4D3/LuaSnip" }, --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

    -- LSP
    { "neovim/nvim-lspconfig" }, -- enable LSP
    { "williamboman/mason.nvim" }, -- simple to use language server installer
    { "williamboman/mason-lspconfig.nvim" }, -- simple to use language server installer
    { "nvimtools/none-ls.nvim" }, -- LSP diagnostics and code actions
    { "RRethy/vim-illuminate" },

    -- Telescope
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },

    -- Git
    { "sindrets/diffview.nvim" },
    { "lewis6991/gitsigns.nvim" },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
    },
    { "mrloop/telescope-git-branch.nvim" },

    -- Debugging
    { "mfussenegger/nvim-dap" },
    { "joshua-holmes/dap-projects.nvim" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },
    { "nvim-telescope/telescope-dap.nvim" },
}, {
    ui = {
        border = "rounded",
    },
})
