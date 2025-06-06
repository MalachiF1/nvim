return {
    'mfussenegger/nvim-dap',

    dependencies = {
        {
            'mfussenegger/nvim-dap-python',
            ft = 'python',
        },
        {
            'Weissle/persistent-breakpoints.nvim',
            event = 'BufReadPre',
        },
        'nvim-telescope/telescope.nvim',
        'nvim-telescope/telescope-dap.nvim',
    },

    cmd = {
        'DapToggleBreakpoint',
        'DapContinue',
        'DapStepOut',
        'DapStepInto',
        'DapStepOver',
        'PBToggleBreakpoint',
        'PBSetConditionalBreakpoint',
        'PBClearAllBreakpoints',
    },

    keys = {
        {
            '<leader>db',
            -- ':PBToggleBreakpoint<CR>',
            '<cmd>lua require("persistent-breakpoints.api").toggle_breakpoint()<CR>',
            mode = 'n',
            desc = 'toggle breakpoint',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dt',
            -- ':PBSetConditionalBreakpoint<CR>',
            '<cmd>lua require("persistent-breakpoints.api").set_conditional_breakpoint()<CR>',
            mode = 'n',
            desc = 'conditional breakpoint',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dC',
            -- ':PBClearAllBreakpoints<CR>',
            '<cmd>lua require("persistent-breakpoints.api").clear_all_breakpoints()<CR>',
            mode = 'n',
            desc = 'clear breakpoints',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dlc',
            ':Telescope dap commands<CR>',
            mode = 'n',
            desc = 'commands',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dlf',
            ':Telescope dap configurations<CR>',
            mode = 'n',
            desc = 'configurations',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dlb',
            ':Telescope dap list_breakpoints<CR>',
            mode = 'n',
            desc = 'breakpoints',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dlv',
            ':Telescope dap variables<CR>',
            mode = 'n',
            desc = 'variables',
            noremap = true,
            silent = true,
        },
        {
            '<leader>dlf',
            ':Telescope dap frames<CR>',
            mode = 'n',
            desc = 'frames',
            noremap = true,
            silent = true,
        },
    },

    config = function()
        require('plugins.daps.adapters.debugpy')
        require('plugins.daps.adapters.lldb')

        require('plugins.daps.settings.python')
        require('plugins.daps.settings.cpp')
        require('plugins.daps.settings.rust')

        local persistent_breakpoints = require('persistent-breakpoints')
        persistent_breakpoints.setup({
            load_breakpoints_event = { 'BufReadPost' },
            save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
            -- when to load the breakpoints? "BufReadPost" is recommended.
            on_load_breakpoint = nil,
        })

        local sign = vim.fn.sign_define
        sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

        vim.cmd([[PBLoad]]) -- load persistent breakpoints when dap is loaded

        require('telescope').load_extension('dap')
    end,
}
