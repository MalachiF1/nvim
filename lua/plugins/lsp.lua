return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {
            'neovim/nvim-lspconfig', -- Required
            dependencies = {
                -- for lua debugging
                "folke/neodev.nvim", -- Optional, but needs to be loaded before lspconfig
            },
        },
        'williamboman/mason.nvim', -- Optional
        'williamboman/mason-lspconfig.nvim', -- Optional

        -- Autocompletion
        'hrsh7th/nvim-cmp', -- Required
        'hrsh7th/cmp-nvim-lsp', -- Required
        'hrsh7th/cmp-buffer', -- Optional
        'hrsh7th/cmp-path', -- Optional
        'hrsh7th/cmp-cmdline', -- Optional
        'L3MON4D3/LuaSnip', -- Required
        'saadparwaiz1/cmp_luasnip', -- Optional
        'rafamadriz/friendly-snippets', -- Optional
    },

    config = function()
        local neodev = require('neodev')
        neodev.setup({
            library = {
                enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = true, -- runtime path
                types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = {"nvim-dap-ui", "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            override = function(root_dir, options) end,
            -- With lspconfig, Neodev will automatically setup your lua-language-server
            -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
            -- in your lsp start options
            lspconfig = true,
            -- much faster, but needs a recent built of lua-language-server
            -- needs lua-language-server >= 3.6.0
            pathStrict = true,
        })

        local lsp = require('lsp-zero')
        local telescope = require("telescope.builtin")

        lsp.preset('recommended')

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

        require("luasnip.loaders.from_vscode").lazy_load()


        local cmp = require('cmp')
        local cmp_action = lsp.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
            ['<tab>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),

            -- Navigatge between snippet placeholders
            ['<C-n>'] = cmp_action.luasnip_jump_forward(),
            ['<C-p>'] = cmp_action.luasnip_jump_backward(),
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })


        cmp.setup({
            window = {
                completion = cmp.config.window.bordered({
                    border = 'rounded',
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    scrollbar = false,
                }),
                documentation = cmp.config.window.bordered({
                    border = 'rounded',
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    scrollbar = false,
                }),
            },
            snippet = {
                expand = function(args)
                    --  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'snippy' }, -- For snippy users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
            }, {
                { name = 'buffer' },
            })
        })

        lsp.set_sign_icons({
            error = '', -- ✘, ,
            warn = '', -- ▲, ,
            hint = '', -- ⚑, , 
            info = '' -- », , 
        })

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.on_attach(function(client, bufnr)
            vim.keymap.set("n", "<leader>lgd", function() telescope.lsp_definitions {} end,
                { buffer = bufnr, remap = false, desc = 'definition' })
            vim.keymap.set("n", "<leader>ld", function() telescope.lsp_definitions { jump_type = "never" } end,
                { buffer = bufnr, remap = false, desc = 'view definition' })
            vim.keymap.set("n", "<leader>li", function() telescope.lsp_implementations() end,
                { buffer = bufnr, remap = false, desc = 'implementations' })
            vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end,
                { buffer = bufnr, remap = false, desc = 'show documentation' })
            vim.keymap.set("n", "<leader>lw", function() telescope.lsp_workspace_symbols { bufnr = 0 } end,
                { buffer = bufnr, remap = false, desc = 'workspace symbols' })
            vim.keymap.set("n", "<leader>lgn", function() vim.diagnostic.goto_next() end,
                { buffer = bufnr, remap = false, desc = 'next diagnostic' })
            vim.keymap.set("n", "<leader>lgp", function() vim.diagnostic.goto_prev() end,
                { buffer = bufnr, remap = false, desc = 'previous diagnostic' })
            vim.keymap.set("n", "<leader>lc", function() vim.lsp.buf.code_action() end,
                { buffer = bufnr, remap = false, desc = 'code actions' })
            vim.keymap.set("n", "<leader>lr", function() telescope.lsp_references() end,
                { buffer = bufnr, remap = false, desc = 'references' })
            vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end,
                { buffer = bufnr, remap = false, desc = 'rename' })
            vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end,
                { buffer = bufnr, remap = false, desc = 'signature help' })
            vim.keymap.set("n", "<leader>lv", function() telescope.diagnostics({
                    severity_limit = vim.diagnostic.severity.HINT,
                    severity_bound = vim.diagnostic.severity.ERROR,
                    bufnr = 0,
                })
            end,
                { buffer = bufnr, remap = false, desc = 'view diagnostics' })
            vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end,
                { buffer = bufnr, remap = false, desc = 'format' })
        end)

        lsp.setup()
    end,

}
