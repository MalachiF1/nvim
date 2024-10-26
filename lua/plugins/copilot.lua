return {
    'zbirenbaum/copilot.lua',

    cmd = 'Copilot',

    event = 'InsertEnter',

    keys = {
        {
            '<leader>cp',
            function() require('copilot.panel').open() end,
            mode = 'n',
            desc = 'panel',
            noremap = true,
            silent = true,
        },
        {
            '<leader>cs',
            ':Copilot<CR>',
            mode = 'n',
            desc = 'status',
            noremap = true,
            silent = true,
        },
        {
            '<leader>cd',
            ':Copilot detach<CR>',
            mode = 'n',
            desc = 'detach',
            noremap = true,
            silent = true,
        },
        {
            '<leader>ca',
            ':Copilot attach<CR>',
            mode = 'n',
            desc = 'attach',
            noremap = true,
            silent = true,
        },
        {
            '<leader>cu',
            ':Copilot auth<CR>',
            mode = 'n',
            desc = 'auth',
            noremap = true,
            silent = true,
        },
    },

    config = function()
        require('copilot').setup({
            panel = {
                enabled = false,
                auto_refresh = false,
                keymap = {
                    jump_prev = '<S-k>',
                    jump_next = '<S-j>',
                    accept = '<CR>',
                    refresh = 'gr',
                    open = '<S-CR>',
                },
                layout = {
                    position = 'bottom', -- | top | left | right
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = '<M-l>',
                    accept_word = false,
                    accept_line = false,
                    next = '<M-j>',
                    prev = '<M-k>',
                    dismiss = '<M-x>',
                },
            },
            filetypes = {
                yaml = false,
                -- markdown = false,
                markdown = true,
                quarto = true,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ['.'] = true,
            },
            copilot_node_command = 'node', -- Node.js version must be > 16.x
            server_opts_overrides = {},
        })
    end,
}
