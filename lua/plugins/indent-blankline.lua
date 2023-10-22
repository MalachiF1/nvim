return {
    'lukas-reineke/indent-blankline.nvim',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },

    main = 'ibl',

    event = 'BufReadPre',

    opts = {
        scope = {
            enabled = true,
            show_start = true,
            show_end = true,
            injected_languages = true,
            show_exact_scope = true,
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
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
    },
}
