return {
    'AckslD/nvim-neoclip.lua',

    dependencies = {
        'kkharji/sqlite.lua',
        'nvim-telescope/telescope.nvim',
    },

    cmd = { 'Telescope neoclip' },

    event = { 'TextYankPost' },

    keys = {
        {
            '<leader>n',
            ':lua require("telescope").extensions.neoclip.default()<CR>',
            mode = 'n',
            desc = 'neoclip',
            noremap = true,
            silent = true,
        },
    },

    opts = {
        history = 1000,
        enable_persistent_history = true,
        length_limit = 1048576,
        continuous_sync = false,
        db_path = vim.fn.stdpath('data') .. '/databases/neoclip.sqlite3',
        preview = true,
        content_spec_column = true,
        prompt = nil,
        default_register = '+',
        default_register_macros = 'a',
        enable_macro_history = false,
        keys = {
            telescope = {
                i = {
                    select = '<CR>',
                    paste = '<M-p>',
                    paste_behind = '<M-k>',
                    delete = '<M-d>', -- delete an entry
                    edit = '<M-e>',   -- edit an entry
                    custom = {},
                },
                n = {
                    select = '<CR>',
                    paste = 'p',
                    paste_behind = { 'P', 'k' },
                    delete = 'd',
                    edit = 'e',
                    custom = {},
                },
            },
        },
    },

    config = function(_, opts)
        require('neoclip').setup(opts)
        require('telescope').load_extension('neoclip')
    end,
}
