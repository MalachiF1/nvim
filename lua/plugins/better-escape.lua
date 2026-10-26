return {
    'max397574/better-escape.nvim',

    event = { 'InsertEnter', 'CmdlineEnter', 'TermEnter' },

    opts = {
        timeout = vim.o.timeoutlen,
        -- the defaults also map `j` in visual/select mode, which overrides `j` -> `gj` (config/keymaps.lua)
        default_mappings = false,
        mappings = {
            i = {
                j = {
                    k = '<Esc>',
                    j = '<Esc>',
                },
            },
            c = {
                j = {
                    k = '<Esc>',
                    j = '<C-c>',
                },
            },
            t = {
                j = {
                    k = '<C-\\><C-n>',
                },
            },
        },
    },
}
