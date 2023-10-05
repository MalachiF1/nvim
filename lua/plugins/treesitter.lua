return {
    'nvim-treesitter/nvim-treesitter',

    dependencies = {
        'nvim-treesitter/playground',
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
                additional_vim_regex_highlighting = false,
            },

            indent = {
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
    end,
}
