return {
    'neovim/nvim-lspconfig',

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim', -- for lua debugging, need to be loaded before lspconfig
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    },

    cmd = 'LspInfo',

    event = { 'BufRead', 'BufNewFile' },

    config = function()
        -- for debugging neovim configuration
        local neodev = require('neodev')
        neodev.setup({})

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
            map('n', '<leader>lgn', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts('next diagnostic'))
            map('n', '<leader>lgp', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts('previous diagnostic'))
            map('n', '<leader>lc', function() require('actions-preview').code_actions() end, opts('code actions'))
            map('n', '<leader>lr', function() telescope.lsp_references() end, opts('references'))
            map('n', '<leader>ln', function() vim.lsp.buf.rename() end, opts('rename'))
            map('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, opts('signature help'))
            -- map('n', '<leader>lf', function()
            --     vim.lsp.buf.format({ filter = function(client) return client.name ~= 'lau_ls' end })
            -- end, opts('format'))
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
                    capabilities = lsp_capabilities,
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
            -- signs = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.HINT] = '󰌵',
                    [vim.diagnostic.severity.INFO] = '󰋼',
                    -- ['DapBreakpoint'] = '●',
                    -- ['DapBreakpointCondition'] = '●',
                    -- ['DapLogPoint'] = '◆',
                },
                line_hl = {
                    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                    -- ['DapBreakpoint'] = 'DapBreakpoint',
                    -- ['DapBreakpointCondition'] = 'DapBreakpointCondition',
                    -- ['DapLogPoint'] = 'DapLogPoint',
                },
                num_hl = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.HINT] = '',
                    [vim.diagnostic.severity.INFO] = '',
                    -- ['DapBreakpoint'] = '',
                    -- ['DapBreakpointCondition'] = '',
                    -- ['DapLogPoint'] = '',
                },
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- gutter signs for diagnostics
        -- local sign = vim.fn.sign_define
        -- sign('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError', numhl = '' })
        -- sign('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn', numhl = '' })
        -- sign('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint', numhl = '' })
        -- sign('DiagnosticSignInfo', { text = '󰋼', texthl = 'DiagnosticSignInfo', numhl = '' })
    end,
}
