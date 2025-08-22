local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   all modes = "",
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- All modes --
-- Select all text
keymap("", "<C-z>", "<esc>gg<S-v><S-g>", opts)
keymap("", "<C-s>", "<esc><C-s>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-s>", ":write<CR>", opts)
keymap("n", "<C-;>", ":split<CR>", opts)
keymap("n", "<C-'>", ":vsplit<CR>", opts)

-- Resize with arrows
keymap("n", "<A-K>", ":resize -2<CR>", opts)
keymap("n", "<A-J>", ":resize +2<CR>", opts)
keymap("n", "<A-H>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-L>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts) -- was previously to move cursor to middle of screen
keymap("n", "<S-h>", ":bprevious<CR>", opts) -- was previously to move cursor to middle of screen
keymap("n", "<S-k>", "<cmd>Bdelete!<CR>", opts) -- was previously python manual (weird feature)

-- Move text up and down
keymap("n", "<C-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-k>", ":m .-2<CR>==", opts)

-- Better intendation
keymap("n", "<", "<<", opts)
keymap("n", ">", ">>", opts)

-- Macro shortcuts
keymap("n", "M", "@q", opts)
keymap("n", "m", "@", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Insert --
