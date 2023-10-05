return {
    'rcarriga/nvim-dap-ui',

    dependencies = {
        'mfussenegger/nvim-dap',
        'theHamsta/nvim-dap-virtual-text',
        'mfussenegger/nvim-dap-python',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'nvim-telescope/telescope-dap.nvim',
        'Weissle/persistent-breakpoints.nvim',
    },

    cmd = {
        'DapToggleBreakpoint',
        'DapContinue',
        'PBToggleBreakpoint',
        'PBSetConditionalBreakpoint',
        'PBClearAllBreakpoints',
    },

    keys = {
        {
            '<leader>ds',
            function()
                require('dapui').toggle({})
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
                require('dapui').toggle({})
                require('dap').terminate()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
            end,
            mode = 'n',
            desc = 'close',
            noremap = true,
            silent = true,
        },
        {
            '<leader>db',
            ':PBToggleBreakpoint<CR>',
            mode = 'n',
            desc = 'toggle breakpoint',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dt',
            ':PBSetConditionalBreakpoint<CR>',
            mode = 'n',
            desc = 'conditional breakpoint',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dC',
            ':PBClearAllBreakpoints<CR>',
            mode = 'n',
            desc = 'clear breakpoints',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dl',
            ':lua require("dap.ui.widgets").hover<CR>',
            mode = 'n',
            desc = 'get values',
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

    config = function()
        local dap = require('dap')

        -- automatically install dap addapters with mason
        require('mason').setup()
        require('mason-nvim-dap').setup({
            ensure_installed = { 'python' },
            automatic_installation = false,
        })

        require('plugins.daps.adapters.debugpy')
        require('plugins.daps.adapters.lldb')

        require('plugins.daps.settings.python')
        require('plugins.daps.settings.cpp')
        require('plugins.daps.settings.rust')

        require('nvim-dap-virtual-text').setup({})

        local dapui = require('dapui')
        dapui.setup({
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
        })

        local persistent_breakpoints = require('persistent-breakpoints')
        persistent_breakpoints.setup({
            save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
            -- when to load the breakpoints? "BufReadPost" is recommanded.
            load_breakpoints_event = 'BufReadPost',
            on_load_breakpoint = function() print('breakpoint loaded!') end,
        })

        local sign = vim.fn.sign_define
        sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

        vim.cmd([[PBLoad]]) -- load persistent breakpoints when dap is loaded
    end,
}
