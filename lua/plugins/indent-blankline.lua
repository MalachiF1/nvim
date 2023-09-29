return {
    'lukas-reineke/indent-blankline.nvim',

    main = 'ibl',

    event = 'BufReadPre',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },

    config = function()
        require('ibl').setup({
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                injected_languages = true,
                highlight = { 'Function', 'Label' },
            },
            exclude = {
                filetypes = {
                    'lspinfo',
                    'packer',
                    'checkhealth',
                    'help',
                    'man',
                    'gitcommit',
                    'TelescopePrompt',
                    'TelescopeResults',
                    'qf',
                    'trouble',
                },
                buftypes = {
                    'terminal',
                    'nofile',
                    'quickfix',
                    'Prompt',
                },
            },
        })
    end,
}
