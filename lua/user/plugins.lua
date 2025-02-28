local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Failed to load packer")
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
    use {                        -- Markdown preview in browser
        "iamcco/markdown-preview.nvim",
        run = function() fn["mkdp#util#install"]() end,
    }
    use "nvim-pack/nvim-spectre"   -- Tool to replace all text in entire git repo
    use {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
    }
    use "tamton-aquib/duck.nvim"   -- Absolutely not useful...
    use "HiPhish/rainbow-delimiters.nvim"
    use "windwp/nvim-autopairs"    -- Autopairs, integrates with both cmp and treesitter
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"
    use "folke/which-key.nvim"
    use "nvim-lualine/lualine.nvim"
    use "tpope/vim-sleuth"
    use "echasnovski/mini.nvim"
    use "folke/neodev.nvim"        -- Adds lua docs in neovim for neovim config files
    use "lommix/godot.nvim"

    -- Colorschemes
    use "rebelot/kanagawa.nvim"
    use "savq/melange-nvim"
    use {
        "ribru17/bamboo.nvim",
        config = function()
            require("bamboo").setup()
        end
    }

    -- cmp plugins
    use "hrsh7th/nvim-cmp"      -- The completion plugin
    use "hrsh7th/cmp-buffer"    -- buffer completions
    use "hrsh7th/cmp-path"      -- path completions
    use "hrsh7th/cmp-cmdline"   -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- Snippets
    use "L3MON4D3/LuaSnip"           --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig"           -- enable LSP
    use "williamboman/mason.nvim"         -- simple to use language server installer
    use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim" -- LSP diagnostics and code actions
    use "RRethy/vim-illuminate"

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-media-files.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Mercurial
    use "jackysee/telescope-hg.nvim"

    -- Debugging
    use "mfussenegger/nvim-dap"
    use "joshua-holmes/dap-projects.nvim"
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    use "nvim-telescope/telescope-dap.nvim"

    -- AI Code Completion
    use({
      "jackMort/ChatGPT.nvim",
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "folke/trouble.nvim",
          "nvim-telescope/telescope.nvim"
        }
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
