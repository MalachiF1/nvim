return {
    'NeogitOrg/neogit',

    lazy = true,

    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'nvim-telescope/telescope.nvim', -- optional
        'sindrets/diffview.nvim', -- optional
    },

    cmd = 'Neogit',

    keys = {
        { '<leader>gs', '<cmd>Neogit<CR>', mode = 'n', desc = 'status', noremap = true, silent = true },
    },

    opts = {
        graph_style = 'unicode',
        telescope_sorter = function() return require('telescope').extensions.fzf.native_fzf_sorter() end,
        highlight = {
            italic = true,
            bold = true,
            underline = true,
        },
        popup = {
            kind = 'split',
        },
        preview_buffer = {
            kind = 'split',
        },
        integrations = {
            telescope = true,
            diffview = true,
        },
    },
}
