return {
    'nvim-treesitter/nvim-treesitter',

    dependencies = {
        'nvim-treesitter/playground',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag',
        'nvim-treesitter/nvim-treesitter-context',
    },

    version = false,

    build = ':TSUpdate',

    event = 'BufReadPre',

    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { 'markdown' },
            },

            indent = {
                enable = true,
            },

            autotag = {
                enable = true,
            },

            ensure_installed = {
                'javascript',
                'lua',
                'c',
                'cpp',
                'rust',
                'typescript',
                'tsx',
                'json',
                'html',
                'css',
                'markdown',
                'markdown_inline',
                'bash',
                'vim',
                'gitignore',
                'latex',
                'scss',
                'regex',
                'sql',
                'bash',
                'toml',
                'yaml',
                'python',
                'regex',
                'comment',
                'vimdoc',
                'jsonc',
                'dockerfile',
            },

            sync_install = false,
            auto_install = true,
        })

        require('treesitter-context').setup({
            enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })

        require('ts_context_commentstring').setup({
            enable_autocmd = false,
        })

        -- jump to context (upwards)
        vim.keymap.set(
            'n',
            '<C-c>',
            function() require('treesitter-context').go_to_context() end,
            { desc = 'jump to context', noremap = true, silent = true }
        )
        -- toggle context
        vim.keymap.set('n', '<leader>ox', ':TSContextToggle<CR>', { desc = 'show context', noremap = true, silent = true })
    end,
}
