return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    dependencies = {
        'williamboman/mason.nvim',
    },

    opts = {
        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        ensure_installed = {
            'lua-language-server',
            'stylua',
            'clangd',
            'clang-format',
            'cmakelang',
            'pyright',
            'debugpy',
            'isort',
            'black',
            'typescript-language-server',
            'eslint_d',
            'prettierd',
            'html-lsp',
            'css-lsp',
            'sqlls',
            'rust_analyzer',
            'rustfmt',
            'vim-language-server',
            'vint',
            'shellcheck',
            'beautysh',
            'editorconfig-checker',
            'codespell',
            'taplo',
            'texlab',
        },

        auto_update = true,
        run_on_start = true,
        start_delay = 0,
    },

    config = function(_, opts)
        require('mason').setup()
        require('mason-tool-installer').setup(opts)
    end,
}
