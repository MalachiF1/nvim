return {
    'mason-org/mason.nvim',

    event = 'VeryLazy',

    cmd = {
        'Mason',
        'MasonInstall',
        'MasonUninstall',
        'MasonUninstallAll',
        'MasonLog',
        'MasonUpdate',
        'MasonToolsUpdate',
        'MasonToolsInstall',
        'MasonToolsUninstall',
    },

    dependencies = {
        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
    },

    opts = {
        ui = {
            icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗',
            },
            border = 'single',
            check_outdated_packages_on_open = true,
        },
        max_concurrent_installers = 10,
    },

    config = function(_, opts)
        require('mason').setup(opts)

        -- make mason window semi-tranparent
        vim.cmd([[autocmd FileType mason setlocal winblend=8]])

        require('mason-tool-installer').setup({
            ensure_installed = {
                'lua-language-server',
                'luacheck',
                'stylua',
                'clangd',
                'clang-format',
                'cmake-language-server',
                'cmakelint',
                'pyright',
                'debugpy',
                'ruff',
                'typescript-language-server',
                'eslint_d',
                'prettier',
                'jsonls',
                'html-lsp',
                'css-lsp',
                'stylelint',
                'sqlls',
                'vim-language-server',
                'vint',
                'shellcheck',
                'bash-language-server',
                'beautysh',
                'editorconfig-checker',
                -- 'codespell',
                'taplo',
                'texlab',
                'latexindent',
                -- 'ltex-ls',
                'matlab-language-server',
                'codelldb',
            },
            auto_update = false, -- update manually with :MasonToolsUpdate
            run_on_start = true,
            start_delay = 3000, --ms
            integrations = {
                ['mason-lspconfig'] = true,
                -- ['mason-null-ls'] = true,
                -- ['mason-nvim-dap'] = true,
            },
        })
    end,
}
