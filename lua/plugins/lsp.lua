return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                -- for lua debugging, need to be loaded before lspconfig
                "folke/neodev.nvim",
            },
        },
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'onsails/lspkind.nvim',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'rafamadriz/friendly-snippets',
            }
        },
    },

    config = function()
        -- for debugging neovim configuration
        local neodev = require('neodev')
        neodev.setup({})

        local lsp = require('lsp-zero')

        lsp.preset({
            name = 'recommended',
            manage_nvim_cmp = false, -- override settings from the preset (i do this manualy down the file)
        })

        lsp.ensure_installed({
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
        })

        -- gutter signs for diagnostics
        lsp.set_sign_icons({
            error = '', -- ✘, ,
            warn = '', -- ▲, ,
            hint = '', -- ⚑, , 
            info = '' -- », , 
        })

        -- lsp keybinds
        local telescope = require("telescope.builtin")
        lsp.on_attach(function(client, bufnr)
            local keymap = vim.keymap.set
            local opts = function(desc) return { buffer = bufnr, remap = false, desc = desc } end

            keymap("n", "<leader>lgd", function() telescope.lsp_definitions() end, opts('definition'))
            keymap("n", "<leader>ld", function() telescope.lsp_definitions({ jump_type = "never" }) end,
                opts('view definition'))
            keymap("n", "<leader>li", function() telescope.lsp_implementations() end, opts('implementations'))
            keymap("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts('show documentation'))
            keymap("n", "<leader>lw", function() telescope.lsp_workspace_symbols({ bufnr = 0 }) end,
                opts('workspace symbols'))
            keymap("n", "<leader>lgn", function() vim.diagnostic.goto_next() end, opts('next diagnostic'))
            keymap("n", "<leader>lgp", function() vim.diagnostic.goto_prev() end, opts('previous diagnostic'))
            keymap("n", "<leader>lc", function() vim.lsp.buf.code_action() end, opts('code actions'))
            keymap("n", "<leader>lr", function() telescope.lsp_references() end, opts('references'))
            keymap("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts('rename'))
            keymap("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, opts('signature help'))
            keymap("n", "<leader>lv", function()
                telescope.diagnostics({
                    severity_limit = vim.diagnostic.severity.HINT,
                    severity_bound = vim.diagnostic.severity.ERROR,
                    bufnr = 0,
                })
            end, opts('view diagnostics'))
            keymap("n", "<leader>lf", function() vim.lsp.buf.format() end, opts('format'))
        end)

        -- cmp
        local cmp = require('cmp')
        local lspkind = require('lspkind') -- vscode like icons for cmp
        local cmp_action = lsp.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- load snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            mapping = {
                ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(cmp_select), { 'i', 'c' }),
                ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(cmp_select), { 'i', 'c' }),
                ['<tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

                -- Navigatge between snippet placeholders
                ['<C-n>'] = cmp_action.luasnip_jump_forward(),
                ['<C-p>'] = cmp_action.luasnip_jump_backward(),
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = 'none',
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    scrollbar = false,
                }),
                documentation = cmp.config.window.bordered({
                    border = 'none',
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
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
            }
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        -- need to put this at the end
        lsp.setup()
    end,

}
