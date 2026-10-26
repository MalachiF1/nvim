return {
    {
        'nvim-treesitter/nvim-treesitter',

        branch = 'main',

        version = false,

        build = ':TSUpdate',

        event = { 'BufRead', 'BufNewFile' },

        ---@class TSConfig
        opts = {
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
                'vimdoc',
                'gitignore',
                'latex',
                'scss',
                'regex',
                'sql',
                'toml',
                'yaml',
                'python',
                'comment',
                'dockerfile',
                'matlab',
                'gnuplot',
            },

            disable = {
                'tex',
            },
        },

        config = function(_, opts)
            local ts = require('nvim-treesitter')
            ts.install(opts.ensure_installed) -- async, skips parsers that are already installed

            local function start(buf, lang)
                if vim.api.nvim_buf_is_valid(buf) and vim.treesitter.language.add(lang) then vim.treesitter.start(buf, lang) end
            end

            -- start treesitter for any filetype with a parser, installing missing parsers in the background
            local group = vim.api.nvim_create_augroup('malachi_treesitter', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                callback = function(event)
                    local filetype = vim.bo[event.buf].filetype
                    if vim.b[event.buf].bigfile or vim.tbl_contains(opts.disable, filetype) then return end
                    local lang = vim.treesitter.language.get_lang(filetype)
                    if not lang then return end

                    if vim.treesitter.language.add(lang) then
                        vim.treesitter.start(event.buf, lang)
                    elseif require('nvim-treesitter.parsers')[lang] then
                        ts.install(lang):await(function(err)
                            if not err then vim.schedule(function() start(event.buf, lang) end) end
                        end)
                    end
                end,
            })

            -- buffers opened before this plugin was loaded
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.bo[buf].filetype ~= '' then vim.api.nvim_exec_autocmds('FileType', { group = group, buffer = buf }) end
            end

            -- jump to context (upwards)
            vim.keymap.set(
                'n',
                '<C-c>',
                function() require('treesitter-context').go_to_context() end,
                { desc = 'jump to context', noremap = true, silent = true }
            )
            -- toggle context
            vim.keymap.set('n', '<leader>ox', ':TSContext toggle<CR>', { desc = 'show context', noremap = true, silent = true })
        end,
    },

    {

        'windwp/nvim-ts-autotag',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },

        ft = { 'html', 'xml', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'markdown' },

        opts = {},
    },

    {

        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },

        cmd = 'TSContext',

        opts = {
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
        },
    },

    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
    },
}
