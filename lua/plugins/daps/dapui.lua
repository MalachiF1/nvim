return {
    'rcarriga/nvim-dap-ui',

    dependencies = {
        'mfussenegger/nvim-dap',
        'theHamsta/nvim-dap-virtual-text',
    },

    cmd = {
        'DapContinue',
        'DapStepOut',
        'DapStepInto',
        'DapStepOver',
    },

    keys = {
        {
            '<leader>ds',
            function()
                require('dapui').open()
                require('dap').continue()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false) -- Spaces buffers evenly
            end,
            mode = 'n',
            desc = 'start',
            noremap = true,
            silent = true,
        },
        {
            '<leader>de',
            function()
                require('dapui').close()
                require('dap').terminate()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
            end,
            mode = 'n',
            desc = 'close',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dv',
            ':lua require("dapui").eval()<CR>',
            mode = 'n',
            desc = 'eval',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dc',
            ':DapContinue<CR>',
            mode = 'n',
            desc = 'continue',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dn',
            ':DapStepOver<CR>',
            mode = 'n',
            desc = 'step over',
            noremap = true,
            silent = true,
        },
        {
            '<leader>di',
            ':DapStepInto<CR>',
            mode = 'n',
            desc = 'step into',
            noremap = true,
            silent = true,
        },
        {
            '<leader>do',
            ':DapStepOut<CR>',
            mode = 'n',
            desc = 'step out',
            noremap = true,
            silent = true,
        },
    },

    opts = {
        controls = {
            element = 'repl',
            enabled = true,
            icons = {
                disconnect = '',
                pause = '',
                play = '',
                run_last = '',
                step_back = '',
                step_into = '',
                step_out = '',
                step_over = '',
                terminate = '',
            },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            max_height = nil,
            max_width = nil,
            border = 'single',
            mappings = {
                close = { 'q', '<Esc>', '<C-[>' },
            },
        },
        force_buffers = true,
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        layouts = {
            {
                elements = {
                    {
                        id = 'scopes',
                        size = 0.4,
                    },
                    {
                        id = 'watches',
                        size = 0.3,
                    },
                    {
                        id = 'breakpoints',
                        size = 0.3,
                    },
                },
                size = 0.2,
                position = 'right',
            },
            {
                elements = {
                    {
                        id = 'repl',
                        size = 0.5,
                    },
                    {
                        id = 'console',
                        size = 0.5,
                    },
                },
                size = 0.3,
                position = 'bottom',
            },
        },
        mappings = {
            open = 'o',
            remove = 'd',
            edit = 'e',
            repl = 'r',
            toggle = 't',
        },
        render = {
            max_type_length = nil,
            max_value_lines = 100,
            indent = 1,
        },
        windows = { indent = 1 },
    },

    config = function(_, opts)
        require('nvim-dap-virtual-text').setup({})
        require('dapui').setup(opts)

        -- fix highlights for DapUi float menus
        vim.api.nvim_set_hl(0, 'DapUIFloatNormal', { link = 'Pmenu' })
        vim.api.nvim_set_hl(0, 'DapUIFloatBorder', { link = 'FloatBorder' })
    end,
}
