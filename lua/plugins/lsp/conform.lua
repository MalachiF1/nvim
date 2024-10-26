return {
    'stevearc/conform.nvim',

    cmd = { 'ConformInfo' },

    -- event = { 'BufWritePre' }, -- if formatting on save

    keys = {
        {
            -- Customize or remove this keymap to your liking
            '<leader>lf',
            function() require('conform').format({ async = true, fallback = true }) end,
            mode = { 'n', 'v' },
            desc = 'format',
            noremap = true,
            silent = true,
        },
    },

    opts = {
        -- Map of filetype to formatters
        formatters_by_ft = {
            lua = { 'stylua' },
            cpp = { 'clang-format' },
            cmake = { 'cmake_format' },
            bash = { 'beautysh' },
            zsh = { 'beautysh' },
            toml = { 'taplo' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescriptreact = { 'prettier' },
            svelte = { 'prettier' },
            html = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            sass = { 'prettier' },
            json = { 'prettier' },
            yaml = { 'prettier' },
            graphql = { 'prettier' },
            python = { 'isort', 'black' },
            rust = { 'rustfmt' },
            tex = { 'latexindent' },
            markdown = { 'prettier', --[[ 'injected' ]] },
            -- quarto = { 'injected' },
            -- Use the "*" filetype to run formatters on all filetypes.
            -- ['*'] = function(bufnr)
            --     if vim.bo[bufnr].filetype ~= 'markdown' and vim.bo[bufnr].filetype ~= 'tex' then return { 'codespell' } end
            -- end,
            -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
            ['_'] = { 'trim_whitespace' },
        },
        format_on_save = function() return false end, -- disable formatting on save
        format_after_save = function() return false end,

        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
    },
}
