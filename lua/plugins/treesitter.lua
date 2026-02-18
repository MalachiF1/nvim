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
                'bash',
                'toml',
                'yaml',
                'python',
                'regex',
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
            require('nvim-treesitter.install').prefer_git = true

            -- install parsers from custom opts.ensure_installed
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                require('nvim-treesitter').install(opts.ensure_installed)
                -- register and start parsers for filetypes
                for _, parser in ipairs(opts.ensure_installed) do
                    local filetypes = parser -- In this case, parser is the filetype/language name
                    vim.treesitter.language.register(parser, filetypes)

                    vim.api.nvim_create_autocmd({ 'FileType' }, {
                        pattern = filetypes,
                        callback = function(event) vim.treesitter.start(event.buf, parser) end,
                    })
                end
            end

            -- Auto-install and start parsers for any buffer
            vim.api.nvim_create_autocmd({ 'BufRead' }, {
                callback = function(event)
                    local bufnr = event.buf
                    local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })

                    -- Skip if no filetype
                    if filetype == '' then return end

                    -- -- Skip if in disable list
                    -- if opts.disable and vim.tbl_contains(opts.disable, filetype) then return end

                    -- Check if this filetype is already handled by explicit opts.ensure_installed config
                    for _, filetypes in pairs(opts.ensure_installed) do
                        local ft_table = type(filetypes) == 'table' and filetypes or { filetypes }
                        if vim.tbl_contains(ft_table, filetype) then
                            return -- Already handled above
                        end
                    end

                    -- Get parser name based on filetype
                    local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
                    if not parser_name then return end
                    -- Try to get existing parser (helpful check if filetype was returned above)
                    local parser_configs = require('nvim-treesitter.parsers')
                    if not parser_configs[parser_name] then
                        return -- Parser not available, skip silently
                    end

                    local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if not parser_installed then
                        -- If not installed, install parser synchronously
                        require('nvim-treesitter').install({ parser_name }):wait(30000)
                    end

                    -- let's check again
                    parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if parser_installed and not (opts.disable and vim.tbl_contains(opts.disable, filetype)) then
                        -- Start treesitter for this buffer
                        vim.treesitter.start(bufnr, parser_name)
                    end
                end,
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
    },

    {

        'windwp/nvim-ts-autotag',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
    },

    {

        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },

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
