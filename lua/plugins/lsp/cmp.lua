return {
    'hrsh7th/nvim-cmp',

    dependencies = {
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },

    event = { 'InsertEnter', 'CmdlineEnter' },

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
                { name = 'path' },
                { name = 'buffer' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',  -- symbol/text/symbol_text
                    maxwidth = 30,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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
        -- automatically add `(` after selecting a function or method
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local handlers = require('nvim-autopairs.completion.handlers')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done({
                filetypes = {
                    -- "*" is a alias to all filetypes
                    ['*'] = {
                        ['('] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = handlers['*'],
                        },
                    },
                },
            })
        )

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
}
