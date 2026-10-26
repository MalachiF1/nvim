return {
    'mfussenegger/nvim-lint',

    -- event = { 'BufRead', 'BufNewFile' },

    keys = {
        {
            '<leader>ll',
            function()
                local lint = require('lint')
                vim.g.linting_enabled = not vim.g.linting_enabled
                if vim.g.linting_enabled then
                    lint.try_lint()
                else
                    -- clear only nvim-lint's diagnostics, LSP diagnostics are left alone
                    for _, linters in pairs(lint.linters_by_ft) do
                        for _, name in ipairs(linters) do
                            vim.diagnostic.reset(lint.get_namespace(name))
                        end
                    end
                end
            end,
            mode = 'n',
            desc = 'toggle linting',
            noremap = true,
            silent = true,
        },
    },

    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            svelte = { 'eslint_d' },
            css = { 'stylelint' },
            scss = { 'stylelint' },
            sass = { 'stylelint' },
            python = { 'ruff' },
            -- cpp = { 'clangtidy' },
            cmake = { 'cmakelint' },
            sh = { 'shellcheck' },
            bash = { 'shellcheck' },
            vim = { 'vint' },
            lua = { 'luacheck' },
        }

        -- automatically lint
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.g.linting_enabled = false
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                if vim.g.linting_enabled then lint.try_lint() end
            end,
        })
    end,
}
