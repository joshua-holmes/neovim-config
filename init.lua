-- Replacement for "impatient.nvim" project, as of nvim v0.9
vim.loader.enable()

require("user.plugins") -- Load plugins first with lazy.nvim
require("user.options")
require("user.keymaps")
require("user.colorscheme")
require("user.autocommands")
require("user.lsp")
