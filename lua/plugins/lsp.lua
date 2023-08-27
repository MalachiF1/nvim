return {
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        },
        config = function()
            -- cmp
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local lspkind = require('lspkind') -- vscode like icons for cmp
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            -- load snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                mapping = {
                    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(cmp_select), { 'i', 'c' }),
                    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(cmp_select), { 'i', 'c' }),
                    ['<tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

                    -- Navigatge between snippet placeholders
                    ['<C-n>'] = function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end,
                    ['<C-p>'] = function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = 'none',
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                        scrollbar = false,
                    }),
                    documentation = cmp.config.window.bordered({
                        border = 'none',
                        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
                        scrollbar = false,
                    }),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text', -- symbol/text/symbol_text
                        maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        -- before = function(entry, vim_item)
                        --     ...
                        --     return vim_item
                        -- end
                    }),
                },
            })

            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' },
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })
        end,
    },
    {

        -- LSP Support
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

            local lsp_capablities = require('cmp_nvim_lsp').default_capabilities()
            -- enable folding for nvim-ufo
            lsp_capablities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            local lsp_attach = function(client, bufnr)
                local telescope = require('telescope.builtin')
                local keymap = vim.keymap.set
                local opts = function(desc) return { buffer = bufnr, remap = false, desc = desc } end

                keymap('n', '<leader>lgd', function()
                    telescope.lsp_definitions() -- <C-o> to return
                end, opts('definition'))
                keymap('n', '<leader>ld', function() telescope.lsp_definitions({ jump_type = 'never' }) end, opts('view definition'))
                keymap('n', '<leader>li', function() telescope.lsp_implementations() end, opts('implementations'))
                keymap('n', '<leader>lh', function() vim.lsp.buf.hover() end, opts('show documentation'))
                keymap('n', '<leader>lw', function() telescope.lsp_workspace_symbols({ bufnr = 0 }) end, opts('workspace symbols'))
                keymap('n', '<leader>lgn', function() vim.diagnostic.goto_next() end, opts('next diagnostic'))
                keymap('n', '<leader>lgp', function() vim.diagnostic.goto_prev() end, opts('previous diagnostic'))
                keymap('n', '<leader>lc', function() vim.lsp.buf.code_action() end, opts('code actions'))
                keymap('n', '<leader>lr', function() telescope.lsp_references() end, opts('references'))
                keymap('n', '<leader>ln', function() vim.lsp.buf.rename() end, opts('rename'))
                keymap('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, opts('signature help'))
                keymap('n', '<leader>lf', function() vim.lsp.buf.format() end, opts('format'))
                keymap(
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
                        capablities = lsp_capablities,
                    })
                end,
            })

            -- gutter signs for diagnostics
            local sign = vim.fn.sign_define
            sign('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', numhl = '' })
            sign('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', numhl = '' })
            sign('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint', numhl = '' })
            sign('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo', numhl = '' })

            require('null-ls').setup()
        end,
    },
}
