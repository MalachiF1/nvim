return {
    'lukas-reineke/indent-blankline.nvim',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },

    main = 'ibl',

    event = 'BufReadPre',

    config = function()
        local highlights = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        }

        require('ibl').setup({
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                injected_languages = true,
                highlight = highlights,
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
