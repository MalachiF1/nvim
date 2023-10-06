return {
    'stevearc/conform.nvim',

    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    cmd = { 'ConformInfo' },

    -- event = { 'BufWritePre' }, -- if formatting on save

    keys = {
        {
            -- Customize or remove this keymap to your liking
            '<leader>lf',
            function() require('conform').format({ async = true, lsp_fallback = true }) end,
            mode = 'n',
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
            javascript = { 'prettierd', 'eslint_d' },
            typescript = { 'prettierd', 'eslint_d' },
            python = { 'isort', 'black' },
            rust = { 'rustfmt' },
            -- Use the "*" filetype to run formatters on all filetypes.
            ['*'] = { 'codespell' },
            -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
            ['_'] = { 'trim_whitespace' },
        },
        format_on_save = function() return false end, -- disable formatting on save
        format_after_save = function() return false end,

        log_level = vim.log.levels.ERROR,
        notify_on_error = true,
    },
}
