return {
    'max397574/better-escape.nvim',

    event = 'InsertEnter',

    opts = {
        mapping = { 'jk' }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = function() -- keys used for escaping, if it is a function will use the result everytime
            return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
        end,
    },
}
