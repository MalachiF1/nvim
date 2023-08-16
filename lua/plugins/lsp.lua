return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',             -- Required
        'williamboman/mason.nvim',           -- Optional
        'williamboman/mason-lspconfig.nvim', -- Optional

        -- Autocompletion
        'hrsh7th/nvim-cmp',     -- Required
        'hrsh7th/cmp-nvim-lsp', -- Required
        'L3MON4D3/LuaSnip',     -- Required
        'rafamadriz/friendly-snippets',
    },

    config = function()
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

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
            ['<tab>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
        })

        -- lsp.set_preferences({})

        lsp.set_sign_icons({
            error = '', -- ✘, ,
            warn = '', -- ▲, ,
            hint = '', -- ⚑, ,
            info = '' -- », ,
        })

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "<leader>lgd", function() telescope.lsp_definitions {} end, opts)                       -- go to definition
            vim.keymap.set("n", "<leader>lvd", function() telescope.lsp_definitions { jump_type = "never" } end, opts) -- view defintion
            vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)                                -- show documentation
            vim.keymap.set("n", "<leader>lw", function() telescope.lsp_workspace_symbols { bufnr = 0 } end, opts)
            vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.goto_next() end, opts)                            -- go to next diagnostic
            vim.keymap.set("n", "<leader>lp", function() vim.lsp.buf.goto_prev() end, opts)                            -- go to previos diagnostic
            vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)                         -- view available code actions
            vim.keymap.set("n", "<leader>lrr", function() telescope.lsp_references() end, opts)                        -- view references
            vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)                              -- smart rename
            vim.keymap.set("n", "<leader>lsh", function() vim.lsp.buf.signature_help() end, opts)                      -- show signature help
            vim.keymap.set("n", "<leader>lsd", function() telescope.diagnostics { bufnr = 0 } end, opts)               -- show all diagnostics
            vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)                               -- formats buffer
        end)

        lsp.setup()
    end,

}
