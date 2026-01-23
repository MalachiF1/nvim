return {
    'aznhe21/actions-preview.nvim',

    dependencies = {
        'nvim-telescope/telescope.nvim',
    },

    cmd = 'LspInfo',

    event = { 'LspAttach' },

    opts = function()
        return {
            -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
            diff = {
                ctxlen = 3,
            },
            -- priority list of preferred backend
            backend = { 'telescope', 'nui' },

            -- options related to telescope.nvim
            telescope = require('telescope.builtin'),
        }
    end,
}
