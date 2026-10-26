local map = vim.keymap.set

-- map('n', '<leader>pc', function()
--     local file = vim.fn.expand('%:p')
--     local dir = vim.fn.expand('%:p:h')
--     return ':TermExec cmd="ipython && %run ' .. vim.fn.expand('%:p') .. ' <CR>" dir=' .. dir
-- end, { desc = 'run', expr = true, noremap = true, silent = true })

map('n', '<leader>pi', function()
    local dir = vim.fn.expand('%:p:h')
    return ':TermExec cmd=ipython dir=' .. dir .. ' <CR>'
end, { desc = 'ipython', buffer = true, expr = true, noremap = true, silent = true })

-- group label for mini.clue (buffer-local, a real mapping here would shadow <leader>pci/<leader>pcp)
vim.b.miniclue_config = { clues = { { mode = 'n', keys = '<leader>pc', desc = 'run' } } }

map('n', '<leader>pci', function()
    local file = vim.fn.expand('%:p')
    local dir = vim.fn.expand('%:p:h')
    return ":TermExec cmd='\\%run " .. file .. "' dir=" .. dir .. ' <CR>'
end, { desc = 'ipython', buffer = true, expr = true, noremap = true, silent = true })

map('n', '<leader>pcp', function()
    local file = vim.fn.expand('%:p')
    local dir = vim.fn.expand('%:p:h')
    return ":TermExec cmd='python " .. file .. "' dir=" .. dir .. ' <CR>'
end, { desc = 'python', buffer = true, expr = true, noremap = true, silent = true })
