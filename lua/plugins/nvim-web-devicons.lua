return {
    'nvim-tree/nvim-web-devicons',

    Lazy = true,

    opts = {
        override = {
            zsh = {
                icon = '',
                -- color = '#428850',
                name = 'Zsh',
            },
            bash = {
                icon = '',
                -- color = '#428850',
                name = 'bash',
            },
            matlab = {
                icon = '',
                color = '#e16745',
                name = 'Matlab',
            },
        },
        override_by_extension = {
            ['m'] = {
                icon = '',
                color = '#e16745',
                name = 'Matlab',
            },
        },
    },
}
