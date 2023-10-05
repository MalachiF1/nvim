return {

    'jay-babu/mason-null-ls.nvim',

    dependencies = {
        'nvimtools/none-ls.nvim', -- maintained fork of null-ls - just need to change the name here
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
