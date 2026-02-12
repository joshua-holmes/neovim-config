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
    {
        "windwp/nvim-autopairs",
        config = function()
            require("user.autopairs")
        end
    }, -- Autopairs, integrates with both cmp and treesitter
    { "kyazdani42/nvim-web-devicons" },
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("user.nvim-tree")
        end
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("user.bufferline")
        end
    },
    { "moll/vim-bbye" },
    { "ahmedkhalf/project.nvim",
        config = function()
            require("user.project")
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("user.indentline")
        end
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("user.alpha")
        end
    },
    {
        "folke/which-key.nvim",
        config = function()
            require("user.whichkey")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("user.lualine")
        end
    },
    { "tpope/vim-sleuth" },
    { "echasnovski/mini.nvim",
        config = function()
            require("user.mini_map")
            require("user.mini_comment")
            require("user.mini_diff")
        end
    },
    { "folke/neodev.nvim" }, -- Adds lua docs in neovim for neovim config files
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
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("user.cmp")
        end
    }, -- The completion plugin
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
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("user.telescope")
        end
    },
    { "nvim-telescope/telescope-media-files.nvim" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("user.treesitter")
        end
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },

    -- Git
    { "sindrets/diffview.nvim" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("user.gitsigns")
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "sindrets/diffview.nvim", -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            require("user.neogit")
        end
    },
    { "mrloop/telescope-git-branch.nvim" },

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("user.dap")
        end
    },
    { "joshua-holmes/dap-projects.nvim" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("user.dapui")
        end
    },
    { "nvim-telescope/telescope-dap.nvim" },

    --AI
    {
      "nickjvandyke/opencode.nvim",
      dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
      },
      config = function()
          require("user.opencode")
      end
    }
}, {
    ui = {
        border = "rounded",
    },
})
