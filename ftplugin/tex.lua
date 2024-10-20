local map = vim.keymap.set

map('n', '<space>pc', ':VimtexCompile<CR>', { desc = 'compile', noremap = true, silent = true })
map('n', '<space>pv', ':VimtexView<CR>', { desc = 'view pdf', noremap = true, silent = true })
