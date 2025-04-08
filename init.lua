-- Replacement for "impatient.nvim" project, as of nvim v0.9
vim.loader.enable()

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
require "user.mini_map"
require "user.mini_comment"
require "user.dapui"
require "user.dap"
require "user.neogit"
require "user.codecompanion"

-- order matters
require "user.neodev" -- before lsp
require "user.lsp"    -- after neodev
--

