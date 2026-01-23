local map = vim.keymap.set

map('n', '<space>pc', ':VimtexCompile<CR>', { desc = 'compile', noremap = true, silent = true })
map('n', '<space>pv', ':VimtexView<CR>', { desc = 'view pdf', noremap = true, silent = true })

-- vim.opt_local.conceallevel = 2
-- vim.opt_local.concealcursor = ''
-- vim.g.tex_conceal = 'abdmgs'

vim.b.tex_stylish = 1
vim.g.tex_flavor = 'latex'

-- Create a server for inverse searching between windows and wsl
local function is_wsl()
    local f = io.open('/proc/version', 'r')
    if f then
        local version = f:read('*a')
        f:close()
        return version:lower():find('wsl') ~= nil or version:lower():find('microsoft') ~= nil
    end
    return false
end

