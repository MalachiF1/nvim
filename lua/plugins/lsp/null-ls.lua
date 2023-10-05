return {

    'jay-babu/mason-null-ls.nvim',

    dependencies = {
        'jose-elias-alvarez/null-ls.nvim',
        'williamboman/mason.nvim',
    },

    cmd = 'LspInfo',

    event = { 'BufRead', 'BufNewFile' },

    config = function()
        -- automatically install formatters with mason
        require('mason').setup()
        require('mason-null-ls').setup({
            ensure_installed = {
                'clang-format',
                'isort',
                'black',
                'stylua',
                'prettier',
            },
            automatic_installation = true,
            handlers = {},
        })

        require('null-ls').setup()
    end,
}
