local map = vim.keymap.set

-- map('n', '<leader>pc', function()
--     local file = vim.fn.expand('%:p')
--     local dir = vim.fn.expand('%:p:h')
--     return ':TermExec cmd="ipython && %run ' .. vim.fn.expand('%:p') .. ' <CR>" dir=' .. dir
-- end, { desc = 'run', expr = true, noremap = true, silent = true })

map('n', '<leader>pi', function()
    local dir = vim.fn.expand('%:p:h')
    return ':TermExec cmd=ipython dir=' .. dir .. ' <CR>'
end, { desc = 'ipython', expr = true, noremap = true, silent = true })

map('n', '<leader>pc', '', { desc = 'run', noremap = true, silent = true })

map('n', '<leader>pci', function()
    local file = vim.fn.expand('%:p')
    local dir = vim.fn.expand('%:p:h')
    return ":TermExec cmd='\\%run " .. file .. "' dir=" .. dir .. ' <CR>'
end, { desc = 'ipython', expr = true, noremap = true, silent = true })

map('n', '<leader>pcp', function()
    local file = vim.fn.expand('%:p')
    local dir = vim.fn.expand('%:p:h')
    return ":TermExec cmd='python " .. file .. "' dir=" .. dir .. ' <CR>'
end, { desc = 'python', expr = true, noremap = true, silent = true })
