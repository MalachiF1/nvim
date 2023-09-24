return {
    'romgrk/barbar.nvim',
    dependencies = {
        -- "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },

    event = 'BufEnter',

    init = function() vim.g.barbar_auto_setup = false end,

    config = function()
        require('barbar').setup({
            -- Enable/disable animations
            animation = true,

            -- Enable/disable auto-hiding the tab bar when there is a single buffer
            auto_hide = true,

            -- Enable/disable current/total tabpages indicator (top right corner)
            tabpages = true,

            -- Enables/disable clickable tabs
            --  - left-click: go to buffer
            --  - middle-click: delete buffer
            clickable = true,

            -- Excludes buffers from the tabline
            exclude_ft = {},
            exclude_name = {},

            icons = {
                -- Configure the base icons on the bufferline.
                -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
                buffer_index = false,
                buffer_number = false,
                button = '×',
                -- Enables / disables diagnostic symbols
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
                    [vim.diagnostic.severity.WARN] = { enabled = false, icon = ' ' },
                    [vim.diagnostic.severity.INFO] = { enabled = false, icon = ' ' },
                    [vim.diagnostic.severity.HINT] = { enabled = false, icon = ' ' },
                },
                gitsigns = {
                    added = { enabled = false, icon = '+' },
                    changed = { enabled = false, icon = '~' },
                    deleted = { enabled = false, icon = '-' },
                },
                filetype = {
                    -- Sets the icon's highlight group.
                    -- If false, will use nvim-web-devicons colors
                    custom_colors = false,

                    enabled = true,
                },
                separator = { left = '│', right = '' },

                -- If true, add an additional separator at the end of the buffer list
                separator_at_end = false,

                -- Configure the icons on the bufferline when modified or pinned.
                -- Supports all the base icon options.
                modified = { button = '●' },
                pinned = { button = '', filename = true },

                -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
                preset = 'default',
            },
            --
            -- If true, new buffers will be inserted at the start/end of the list.
            -- Default is to insert after current buffer.
            insert_at_end = true,
            -- insert_at_start = false,

            -- Sets the maximum padding width with which to surround each tab
            maximum_padding = 1,

            -- Sets the minimum padding width with which to surround each tab
            minimum_padding = 0,

            -- Sets the maximum buffer name length.
            maximum_length = 30,

            -- Sets the minimum buffer name length.
            minimum_length = 0,

            -- If set, the letters for each buffer in buffer-pick mode will be
            -- assigned based on their name. Otherwise or in case all letters are
            -- already assigned, the behavior is to assign letters in order of
            -- usability (see order below)
            semantic_letters = true,

            -- Set the filetypes which barbar will offset itself for
            sidebar_filetypes = {
                dapui_scopes = true,
                -- dapui_watches = true,
                -- dapui_breakpoints = true,
                -- dapui_console = true,
                -- dapui_stacks = true,
                -- ["dapui-repl"] = true,
            },

            -- New buffer letters are assigned in this order. This order is
            -- optimal for the qwerty keyboard layout but might need adjustment
            -- for other layouts.
            letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
        })

        local map = vim.keymap.set

        -- Move to previous/next
        -- Pin/unpin buffer
        map('n', '<leader>bp', '<Cmd>BufferPin<CR>', { desc = 'pin', noremap = true, silent = true })
        -- Magic buffer-picking mode
        map('n', '<leader>bs', '<Cmd>BufferPick<CR>', { desc = 'select', noremap = true, silent = true })
        -- Re-order to previous/next
        map('n', '<leader>bmh', '<Cmd>BufferMovePrevious<CR>', { desc = 'right', noremap = true, silent = true })
        map('n', '<leader>bml', '<Cmd>BufferMoveNext<CR>', { desc = 'left', noremap = true, silent = true })
    end,
}
