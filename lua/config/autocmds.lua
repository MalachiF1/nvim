local function augroup(name) return vim.api.nvim_create_augroup('malachi_' .. name, { clear = true }) end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup('checktime'),
    command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 }) end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = augroup('resize_splits'),
    callback = function() vim.cmd('tabdo wincmd =') end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    group = augroup('last_loc'),
    callback = function()
        local exclude = { 'gitcommit' }
        local buf = vim.api.nvim_get_current_buf()
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('close_with_q'),
    pattern = {
        'PlenaryTestPopup',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'spectre_panel',
        'startuptime',
        'checkhealth',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('wrap_spell'),
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- disable whitespace characters on some file types
vim.api.nvim_create_autocmd('FileType', {
    group = augroup('no_list'),
    pattern = { 'help', 'qf', 'gitcommit', 'markdown', 'text' },
    callback = function() vim.opt_local.list = false end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = augroup('auto_create_dir'),
    callback = function(event)
        if event.match:match('^%w%w+://') then return end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
})

-- enable cursorline only on focused window
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter', 'WinLeave', 'FileType' }, {
    group = augroup('cursorline'),
    callback = function(event)
        if event.event == 'WinLeave' or vim.bo.filetype == 'TelescopePrompt' then
            vim.opt_local.cursorline = false
        else
            vim.opt_local.cursorline = true
        end
    end,
})

-- set filetypes by extensions for unrecognized filetypes
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
    pattern = '*.in',
    command = 'set filetype=in',
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
    pattern = '*.out',
    command = 'set filetype=out',
})
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
    pattern = '*.nw',
    command = 'set filetype=nw',
})

-- write server address to a temperorary file for neovim-remote commands
vim.cmd([[
function! s:write_server_name() abort
  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
  call writefile([v:servername], nvim_server_file)
endfunction

augroup vimtex_common
  autocmd!
  autocmd FileType tex call s:write_server_name()
augroup END
]])
