return {
    'neovim/nvim-lspconfig',

    cmd = 'LspInfo',

    event = { 'BufRead', 'BufNewFile' },

    dependencies = {
        'jose-elias-alvarez/null-ls.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'jay-babu/mason-null-ls.nvim',
        'folke/neodev.nvim', -- for lua debugging, need to be loaded before lspconfig
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    },

    config = function()
        -- for debugging neovim configuration
        local neodev = require('neodev')
        neodev.setup({})

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'tsserver',
                'eslint',
                'lua_ls',
                'rust_analyzer',
                'clangd',
                'cmake',
                'html',
                'cssls',
                'texlab',
                'pyright',
                'sqlls',
                'taplo',
            },
        })
        -- automatically install formatters with mason
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
        -- automatically install dap addapters with mason
        require('mason-nvim-dap').setup({
            ensure_installed = { 'python' },
            automatic_installation = false,
        })

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- enable folding for nvim-ufo
        lsp_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        local lsp_attach = function(client, bufnr)
            local telescope = require('telescope.builtin')
            local map = vim.keymap.set
            local opts = function(desc) return { buffer = bufnr, remap = false, desc = desc } end

            map('n', '<leader>lgd', function()
                telescope.lsp_definitions() -- <C-o> to return
            end, opts('definition'))
            map('n', '<leader>ld', function() telescope.lsp_definitions({ jump_type = 'never' }) end, opts('view definition'))
            map('n', '<leader>li', function() telescope.lsp_implementations() end, opts('implementations'))
            map('n', '<leader>lh', function() vim.lsp.buf.hover() end, opts('show documentation'))
            map('n', '<leader>lw', function() telescope.lsp_workspace_symbols({ bufnr = 0 }) end, opts('workspace symbols'))
            map('n', '<leader>lgn', function() vim.diagnostic.goto_next() end, opts('next diagnostic'))
            map('n', '<leader>lgp', function() vim.diagnostic.goto_prev() end, opts('previous diagnostic'))
            map('n', '<leader>lc', function() vim.lsp.buf.code_action() end, opts('code actions'))
            map('n', '<leader>lr', function() telescope.lsp_references() end, opts('references'))
            map('n', '<leader>ln', function() vim.lsp.buf.rename() end, opts('rename'))
            map('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, opts('signature help'))
            map('n', '<leader>lf', function()
                vim.lsp.buf.format({ filter = function(client) return client.name ~= 'lau_ls' end })
            end, opts('format'))
            map(
                'n',
                '<leader>lv',
                function()
                    telescope.diagnostics({
                        severity_limit = vim.diagnostic.severity.HINT,
                        severity_bound = vim.diagnostic.severity.ERROR,
                        bufnr = 0,
                    })
                end,
                opts('view diagnostics')
            )
        end

        local lspconfig = require('lspconfig')
        require('mason-lspconfig').setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    on_attach = lsp_attach,
                    capablities = lsp_capabilities,
                })
            end,
        })

        require('lsp_lines').setup()
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = {
                only_current_line = true,
                highlight_whole_line = false,
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- gutter signs for diagnostics
        local sign = vim.fn.sign_define
        sign('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', numhl = '' })
        sign('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', numhl = '' })
        sign('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', numhl = '' })
        sign('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', numhl = '' })

        require('null-ls').setup()
    end,
}
