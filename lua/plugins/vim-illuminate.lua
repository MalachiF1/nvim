return {
    'RRethy/vim-illuminate',

    event = 'VeryLazy',

    config = function()
        require('illuminate').configure({
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            filetypes_denylist = {
                'dirvish',
                'fugitive',
            },
            min_count_to_highlight = 2,
            large_file_cutoff = 10000,
        })
    end,
}
