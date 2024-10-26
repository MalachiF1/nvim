vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ''
vim.g.tex_conceal = 'abdmgs'
vim.b.tex_stylish = 1

vim.g.markdown_fenced_languages = { 'html', 'css', 'python', 'lua', 'vim', 'typescript', 'javascript', 'c', 'cpp', 'rust', 'bash=sh' }

vim.keymap.set('n', '<leader>pv', '<cmd>QuartoPreview<CR>', { silent = true, noremap = true, desc = 'preview' })
