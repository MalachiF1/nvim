return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/playground',
        },
        build = ':TSUpdate',

        config = function()
            require 'nvim-treesitter.configs'.setup({
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },

                ensure_installed = {
                    "javascript",
                    "lua",
                    "c",
                    "cpp",
                    "rust",
                    "typescript",
                    "tsx",
                    "json",
                    "html",
                    "css",
                    "markdown",
                    "bash",
                    "vim",
                    "gitignore",
                    "latex",
                    "scss",
                    "regex",
                    "sql",
                    "bash",
                    "toml",
                    "yaml",
                },

                sync_install = false,
                auto_install = true,

            })
        end
    },

}
