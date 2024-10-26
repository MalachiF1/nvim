local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- leader key needs to be set before lazy.nvim is loaded
-- config.keymaps is loaded before config.lazy in init.lua, so this is ok
vim.g.mapleader = ' '

-- enter command mode with `;`
map('n', ';', ':', opts)

-- use jk to exit insert mode (and hebrew equevalent)
map('i', 'jk', '<ESC>:set iminsert=0<CR>', opts)
map('i', 'חל', '<ESC>:set iminsert=0<CR>', opts)
map('i', '<ESC>', '<ESC>:set iminsert=0<CR>', opts)
map('i', '<C-[>', '<C-[>:set iminsert=0<CR>', opts)

-- clear highlights
map('n', '<C-n>', ':nohl<CR>', opts)

-- toggle whitespace indicators
map('n', '<leader>ow', ':set list!<CR>', { desc = 'whitespace', noremap = true, silent = true })

-- toggle line numbers
map('n', '<leader>on', ':set number! |  set relativenumber!<CR>', { desc = 'line numbers', noremap = true, silent = true })

-- don't copy into register when deleting single character
map('n', 'x', '"_x', opts)

-- paste over text without without copying into register
map('x', '<leader>p', '"_dP', { desc = 'paste', noremap = true, silent = true })

-- keep mouse in the middle of the screen when searching or using ctrl+u/ctrl+d
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

-- take cursor to the start/end of line when using gg/G
map('n', 'gg', 'gg0', opts)
map('v', 'gg', 'gg0', opts)
map('n', 'G', 'G$', opts)
map('v', 'G', 'G$', opts)

-- navigate visual lines when wrapping is enabled
map('n', 'j', 'gj', opts)
map('v', 'j', 'gj', opts)

map('n', 'k', 'gk', opts)
map('v', 'k', 'gk', opts)

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

--search and replace
map('n', '<M-r>', ':%s/<C-r><C-w>//gI<Left><Left><Left>', opts) -- cword
map('v', '<M-r>', 'y:%s/<C-R>"//gI<Left><Left><Left>', opts) -- selection

-- window management
map('n', '<leader>wv', ':vsplit<CR>', { desc = 'vertically split', noremap = true, silent = true })
map('n', '<leader>wh', ':split<CR>', { desc = 'horizontally split', noremap = true, silent = true })
map('n', '<leader>wx', ':close<CR>', { desc = 'close', noremap = true, silent = true })
map('n', '<leader>w>', ':vertical resize +2.5<CR>', { desc = 'increase width', noremap = true, silent = true })
map('n', '<leader>w<', ':vertical resize -2.5<CR>', { desc = 'decrease width', noremap = true, silent = true })
map('n', '<leader>w+', ':resize +2.5<CR>', { desc = 'increase height', noremap = true, silent = true })
map('n', '<leader>w-', ':resize -2.5<CR>', { desc = 'decrease height', noremap = true, silent = true })
map('n', '<leader>w|', ':set ead=hor ea noea<CR>', { desc = 'equalize windows width', noremap = true, silent = true })
map('n', '<leader>w_', ':set ead=ver ea noea<CR>', { desc = 'equalize windows height', noremap = true, silent = true })
map('n', '<leader>wJ', '<C-w>J', { desc = 'move down', noremap = true, silent = true })
map('n', '<leader>wK', '<C-w>K', { desc = 'move up', noremap = true, silent = true })
map('n', '<leader>wH', '<C-w>H', { desc = 'move left', noremap = true, silent = true })
map('n', '<leader>wL', '<C-w>L', { desc = 'move right', noremap = true, silent = true })

-- buffer management
map('n', '<leader>bx', ':bdelete<CR>', { desc = 'close', noremap = true, silent = true })

-- buffer navigation
map('n', '<S-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<S-l>', '<Cmd>BufferNext<CR>', opts)

-- move highlighted text
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- save and quit
map('n', '<leader>ss', ':w<CR>', { desc = 'save', noremap = true, silent = true })
map('n', '<leader>qq', ':q<CR>', { desc = 'quit', noremap = true, silent = true })
map('n', '<leader>qf', ':q!<CR>', { desc = 'force quit', noremap = true, silent = true })
map('n', '<leader>sq', ':wq<CR>', { desc = 'save and quit', noremap = true, silent = true })

-- open netrw
-- map("n", "<leader>pv", ":Ex<CR>", { desc = "netrw", noremap = true, silent = true })

-- switch to hebrew in insert mode (and back to english)
map('i', '<A-h>', '<C-^>', opts)
