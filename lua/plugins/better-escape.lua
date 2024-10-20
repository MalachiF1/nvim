return {
    'max397574/better-escape.nvim',

    event = 'InsertEnter',

    opts = {
        timeout = vim.o.timeoutlen,
        default_mappings = true,
        mappings = {
            i = {
                j = {
                    -- These can all also be functions
                    k = '<Esc>',
                },
            },
            c = {
                j = {
                    k = '<Esc>',
                },
            },
            t = {
                j = {
                    k = '<C-\\><C-n>',
                },
            },
            v = {
                j = {
                    k = '<Esc>',
                },
            },
            s = {
                j = {
                    k = '<Esc>',
                },
            },
        },
    },
}
