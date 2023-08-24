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
keymap("n", "<C-n>", ":nohl<CR>", opts)

-- don't copy into register when deleting single character
keymap("n", "x", '"_x', opts)

-- paste over text without without copying into register
keymap("x", "<leader>p", '"_dP', { desc = "paste", noremap = true, silent = true })

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

--search and replace
keymap("n", "S", ":%s//g<left><left>", opts)

-- window management
keymap("n", "<leader>wv", ":vsplit<CR>", { desc = "vertically split", noremap = true, silent = true })
keymap("n", "<leader>wh", ":split<CR>", { desc = "horizontally split", noremap = true, silent = true })
keymap("n", "<leader>wx", ":close<CR>", { desc = "close", noremap = true, silent = true })
keymap("n", "<leader>w>", ":vertical resize +2.5<CR>", { desc = "increase width", noremap = true, silent = true })
keymap("n", "<leader>w<", ":vertical resize -2.5<CR>", { desc = "decrease width", noremap = true, silent = true })
keymap("n", "<leader>w+", ":resize +2.5<CR>", { desc = "increase height", noremap = true, silent = true })
keymap("n", "<leader>w-", ":resize -2.5<CR>", { desc = "decrease height", noremap = true, silent = true })
keymap(
	"n",
	"<leader>w|",
	":set ead=hor ea noea<CR>",
	{ desc = "equalize windows width", noremap = true, silent = true }
)
keymap(
	"n",
	"<leader>w_",
	":set ead=ver ea noea<CR>",
	{ desc = "equalize windows hight", noremap = true, silent = true }
)
keymap("n", "<leader>wJ", "<C-w>J", { desc = "move down", noremap = true, silent = true })
keymap("n", "<leader>wK", "<C-w>K", { desc = "move up", noremap = true, silent = true })
keymap("n", "<leader>wH", "<C-w>H", { desc = "move left", noremap = true, silent = true })
keymap("n", "<leader>wL", "<C-w>L", { desc = "move right", noremap = true, silent = true })

-- buffer management
keymap("n", "<leader>bx", ":bdelete<CR>", { desc = "close", noremap = true, silent = true })

-- buffer navigation
keymap("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
keymap("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)

-- move highlighted text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- save and quit
keymap("n", "<leader>ss", ":w<CR>", { desc = "save", noremap = true, silent = true })
keymap("n", "<leader>qq", ":q<CR>", { desc = "quit", noremap = true, silent = true })
keymap("n", "<leader>qf", ":q!<CR>", { desc = "force quit", noremap = true, silent = true })
keymap("n", "<leader>sq", ":wq<CR>", { desc = "save and quit", noremap = true, silent = true })

-- open netrw
keymap("n", "<leader>pv", ":Ex<CR>", { desc = "netrw", noremap = true, silent = true })

-- switch to hebrew in insert mode (and back to english)
keymap("i", "<A-h>", "<C-^>", opts)
