local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

local os_name = vim.loop.os_uname().sysname
local is_mac = string.match(string.lower(os_name), "darwin")
if is_mac then
    ALT_KEY = "CS"
else
    ALT_KEY = "A"
end

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
keymap("n", "<" .. ALT_KEY .. "-k>", ":resize -2<CR>", opts)
keymap("n", "<" .. ALT_KEY .. "-j>", ":resize +2<CR>", opts)
keymap("n", "<" .. ALT_KEY .. "-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<" .. ALT_KEY .. "-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-c>", "<cmd>Bdelete!<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Better intendation
keymap("n", "<", "<<", opts)
keymap("n", ">", ">>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)


-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
