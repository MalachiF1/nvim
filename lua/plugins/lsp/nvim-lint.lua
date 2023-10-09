return {
    'mfussenegger/nvim-lint',

    event = { 'BufRead', 'BufNewFile' },

    keys = {
        {
            '<leader>ll',
            function()
                if not vim.g.linting_enabled then
                    vim.g.linting_enabled = true
                    require('lint').try_lint()
                else
                    vim.g.linting_enabled = false
                    vim.diagnostic.reset()
                    vim.cmd([[LspRestart]])
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
            javasriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            svelte = { 'eslint_d' },
            css = { 'stylelint' },
            scss = { 'stylelint' },
            sass = { 'stylelint' },
            python = { 'pylint' },
            cpp = { 'clangtidy' },
            cmake = { 'cmakelint' },
            bash = { 'shellcheck' },
            zsh = { 'shellcheck' },
            vimscript = { 'vint' },
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
