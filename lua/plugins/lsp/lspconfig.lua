return {
    'neovim/nvim-lspconfig',

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'mason-org/mason.nvim',
    },

    cmd = 'LspInfo',

    event = 'VeryLazy',

    config = function()
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- enable folding for nvim-ufo
        lsp_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        local lsp_attach = function(client, bufnr)
            -- resolved on first use, so attaching a server doesn't load telescope
            local telescope = setmetatable({}, { __index = function(_, picker) return require('telescope.builtin')[picker] end })
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
                        no_sign = true,
                    })
                end,
                opts('view diagnostics')
            )
        end

        -- configure every server before enabling them.
        vim.lsp.config('*', { capabilities = lsp_capabilities })
        -- pyright provides hover in python, ruff's would be shown in the same float
        vim.lsp.config('ruff', {
            on_attach = function(client) client.server_capabilities.hoverProvider = false end,
        })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('malachi_lsp_attach', { clear = true }),
            callback = function(event) lsp_attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf) end,
        })

        -- servers installed by mason (plugins/lsp/mason.lua), by their nvim-lspconfig names
        -- (mason-lspconfig enables them one at a time, retrying every server for every open buffer each time)
        vim.lsp.enable({
            'bashls',
            'clangd',
            'cmake',
            'cssls',
            'html',
            'jsonls',
            'lua_ls',
            'matlab_ls',
            'pyright',
            'ruff',
            'sqlls',
            'taplo',
            'texlab',
            'ts_ls',
            'vimls',
        })

        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = { current_line = true },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.HINT] = '󰌵',
                    [vim.diagnostic.severity.INFO] = '󰋼',
                },
                line_hl = {
                    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                },
                num_hl = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.HINT] = '',
                    [vim.diagnostic.severity.INFO] = '',
                },
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })
    end,
}
