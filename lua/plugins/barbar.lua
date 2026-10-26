return {
    'romgrk/barbar.nvim',

    dependencies = {
        -- "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },

    event = 'BufEnter',

    keys = {
        { '<leader>bp', ':BufferPin<CR>', mode = 'n', desc = 'pin', noremap = true, silent = true },
        { '<leader>bs', ':BufferPick<CR>', mode = 'n', desc = 'select', noremap = true, silent = true },
        { '<leader>bmh', ':BufferMovePrevious<CR>', mode = 'n', desc = 'right', noremap = true, silent = true },
        { '<leader>bml', ':BufferMoveNext<CR>', mode = 'n', desc = 'left', noremap = true, silent = true },
    },

    init = function() vim.g.barbar_auto_setup = false end,

    opts = {
        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = 1,
        icons = {
            -- Configure the base icons on the bufferline.
            -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
            buffer_index = false,
            buffer_number = false,
            button = '×',
            -- show error counts only
            diagnostics = {
                [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
            },

            separator = { left = '┃', right = '' }, -- │, ❙, ∣, ⎸, │, ┃
            inactive = {
                separator = { left = '│', right = '' },
            },

            separator_at_end = false,

            modified = { button = '●' },
            pinned = { button = ' ', filename = true },
        },

        -- new buffers are inserted at the end of the list (default: after the current buffer)
        insert_at_end = true,

        maximum_padding = 1,

        -- filetypes barbar offsets itself for
        sidebar_filetypes = {
            dapui_scopes = true,
        },
    },
}
