local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- leader key needs to be set before lazy.nvim is loaded
-- config.keymaps is loaded before config.lazy in init.lua, so this is ok
vim.g.mapleader = " "

-- use jk to exit insert mode (and hebrew equevalent)
keymap("i", "jk", "<ESC>:set iminsert=0<CR>", opts)
keymap("i", "חל", "<ESC>:set iminsert=0<CR>", opts)
keymap("i", "<ESC>", "<ESC>:set iminsert=0<CR>", opts)
keymap("i", "<C-[>", "<C-[>:set iminsert=0<CR>", opts)

-- clear highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- don't copy into register when deleting single character
keymap("n", "x", '"_x', opts)

-- paste over text without without copying into register
keymap("x", "<leader>p", "\"_dP", opts)

-- keep mouse in the middle of the screen when searching or using ctrl+u/ctrl+d
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- take cursor to the start/end of line when using gg/G
keymap("n", "gg", "gg0", opts)
keymap("v", "gg", "gg0", opts)
keymap("n", "G", "G$", opts)
keymap("v", "G", "G$", opts)

-- search and replace
keymap("n", "S", ":%s//g<left><left>", opts)

-- window management
keymap("n", "<leader>wv", ":vsplit<CR>", opts)  -- split window vertically
keymap("n", "<leader>wh", ":split<CR>", opts)   -- split window horizontally
keymap("n", "<leader>wx", ":close<CR>", opts)   -- close current window
keymap("n", "<leader>bx", ":bdelete<CR>", opts) -- close current buffer

-- move highlighted text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- save and quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>wq", ":wq<CR>", opts)

-- open netrw
keymap("n", "<leader>pv", ":Ex<CR>", opts)

-- switch to hebrew in insert mode (and back to english)
keymap("i", "<A-h>", "<C-^>", opts)
