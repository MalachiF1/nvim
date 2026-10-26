return {
    'lewis6991/gitsigns.nvim',

    event = 'VeryLazy',

    keys = {
        { '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', mode = 'n', desc = 'blame', noremap = true, silent = true },
    },

    opts = {
        signs = {
            add = { text = '│' },
            change = { text = '│' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        signs_staged = {
            add = { text = '│' },
            change = { text = '│' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<summary> • <author_time:%d/%m/%y %H:%M:%S> • <author>', -- same as git-blame.nvim had
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1,
        },
        on_attach = function(bufnr)
            local gs = require('gitsigns')
            local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true }) end

            -- navigation
            map('n', ']h', function() gs.nav_hunk('next') end, 'next hunk')
            map('n', '[h', function() gs.nav_hunk('prev') end, 'previous hunk')

            -- actions
            map('n', '<leader>ghs', gs.stage_hunk, 'stage hunk')
            map('n', '<leader>ghr', gs.reset_hunk, 'reset hunk')
            map('v', '<leader>ghs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'stage hunk')
            map('v', '<leader>ghr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'reset hunk')
            map('n', '<leader>ghS', gs.stage_buffer, 'stage buffer')
            map('n', '<leader>ghR', gs.reset_buffer, 'reset buffer')
            map('n', '<leader>ghp', gs.preview_hunk_inline, 'preview hunk')
            map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'blame line')
            map('n', '<leader>ghd', gs.diffthis, 'diff against index')

            -- text object
            map({ 'o', 'x' }, 'ih', gs.select_hunk, 'hunk')
        end,
    },
}
