return {
    'mfussenegger/nvim-lint',

    event = { 'BufRead', 'BufNewFile' },

    keys = {
        {
            '<leader>ll',
            function() require('lint').try_lint() end,
            mode = 'n',
            desc = 'lint',
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
            -- python = { 'pylint' },
            cpp = { 'clangtidy' },
            cmake = { 'cmakelint' },
            bash = { 'shellcheck' },
            zsh = { 'shellcheck' },
            vimscript = { 'vint' },
            -- lua = { 'luacheck' },
        }

        -- automatically lint
        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function() lint.try_lint() end,
        })
    end,
}
