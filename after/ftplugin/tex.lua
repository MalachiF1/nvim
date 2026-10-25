local map = vim.keymap.set

map('n', '<leader>pc', ':VimtexCompile<CR>', { desc = 'compile', buffer = true, noremap = true, silent = true })
map('n', '<leader>pv', ':VimtexView<CR>', { desc = 'view pdf', buffer = true, noremap = true, silent = true })

-- vim.opt_local.conceallevel = 2
-- vim.opt_local.concealcursor = ''
-- vim.g.tex_conceal = 'abdmgs'

vim.b.tex_stylish = 1

