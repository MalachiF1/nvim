return {
    'glepnir/dashboard-nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    event = 'VimEnter',

    opts = function()
        local ascii = require('plugins.dashboard.banner').random_ascii

        return {
            theme = 'doom',
            config = {
                header = ascii,
                center = {
                    {
                        icon = '   ',
                        icon_hl = 'Title',
                        desc = 'New file',
                        desc_hl = 'String',
                        key = 'e',
                        key_hl = 'Number',
                        action = 'ene | startinsert',
                    },
                    {
                        icon = '󰱼   ',
                        icon_hl = 'Title',
                        desc = 'Find file',
                        desc_hl = 'String',
                        key = 'f',
                        key_hl = 'Number',
                        action = 'Telescope find_files',
                    },
                    {
                        icon = '󰈢   ',
                        icon_hl = 'Title',
                        desc = 'Recent files',
                        desc_hl = 'String',
                        key = 'r',
                        key_hl = 'Number',
                        action = 'Telescope oldfiles',
                    },
                    {
                        icon = '󰈬   ',
                        icon_hl = 'Title',
                        desc = 'Grep string',
                        desc_hl = 'String',
                        key = 'g',
                        key_hl = 'Number',
                        -- action = "lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })",
                        action = "lua require('telescope.builtin').live_grep()",
                    },
                    {
                        icon = '   ',
                        icon_hl = 'Title',
                        desc = 'Last session',
                        desc_hl = 'String',
                        key = 's',
                        key_hl = 'Number',
                        action = 'SessionRestore',
                    },
                    {
                        icon = '   ',
                        icon_hl = 'Title',
                        desc = 'NVIM configuration',
                        desc_hl = 'String',
                        key = 'c',
                        key_hl = 'Number',
                        action = 'edit ~/.config/nvim/init.lua',
                    },
                    {
                        icon = '   ',
                        icon_hl = 'Title',
                        desc = 'Update plugins',
                        desc_hl = 'String',
                        key = 'u',
                        key_hl = 'Number',
                        action = 'Lazy update',
                    },
                    {
                        icon = '󰗼   ',
                        icon_hl = 'Title',
                        desc = 'Quit NVIM',
                        desc_hl = 'String',
                        key = 'q',
                        key_hl = 'Number',
                        action = 'qa',
                    },
                },
            },
        }
    end,
}
