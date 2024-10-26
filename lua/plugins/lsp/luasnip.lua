return {

    'L3MON4D3/LuaSnip',

    build = 'make install_jsregexp',

    dependencies = {
        'rafamadriz/friendly-snippets',
        'evesdropper/luasnip-latex-snippets.nvim',
    },

    lazy = true,

    config = function()
        local ls = require('luasnip')

        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_lua').lazy_load({ paths = { vim.fn.stdpath('config') .. '/lua/snippets' } })

        ls.config.setup({
            enable_autosnippets = true,
            store_selection_keys = '<Tab>',
        })
    end,
}
