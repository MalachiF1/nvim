return {
    {
        'nvim-telescope/telescope.nvim',

        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install',
                build = 'make',
            },
        },

        lazy = true,

        version = '*',

        cmd = 'Telescope',

        keys = {
            {
                '<leader>pf',
                ':Telescope find_files hidden=true<CR>',
                mode = 'n',
                desc = 'files',
                noremap = true,
                silent = true,
            },
            {
                '<leader>gf',
                ':Telescope git_files<CR>',
                mode = 'n',
                desc = 'git files',
                noremap = true,
                silent = true,
            },
            {
                '<leader>pr',
                ':Telescope oldfiles<CR>',
                mode = 'n',
                desc = 'recent files',
                noremap = true,
                silent = true,
            },
            {
                '<leader>ps',
                ':lua require("telescope.builtin").live_grep()<CR>',
                mode = 'n',
                desc = 'grep string',
                noremap = true,
                silent = true,
            },
            keys = {
                '<leader>pb',
                ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
                mode = 'n',
                desc = 'file browser',
                noremap = true,
                silent = true,
            },
            {
                '<leader>oc',
                ':Telescope colorscheme<CR>',
                mode = 'n',
                desc = 'colorscheme',
                noremap = true,
                silent = true,
            },
            {
                '<leader>r',
                -- ':lua require("auto-session").setup_session_lens(); vim.cmd[[Telescope session-lens]]<CR>',
                ':Telescope session-lens<CR>',
                mode = 'n',
                desc = 'restore session',
                noremap = true,
                silent = true,
            },
        },

        opts = function()
            local actions = require('telescope.actions')
            local themes = require('telescope.themes')
            -- local bibtex_actions = require('telescope-bibtex.actions')

            return {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-j>'] = actions.move_selection_next,
                        },
                    },
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = {
                            preview_cutoff = 25,
                            preview_height = 0.60,
                            prompt_position = 'top',
                            mirror = true,
                        },
                    },
                    -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┙', '┕' },
                    borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                    winblend = 7,
                    dynamic_preveiew_title = true,
                    file_sorter = require('telescope.sorters').get_fuzzy_file,
                    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
                    path_display = { 'truncate' },
                    set_env = { ['COLORTERM'] = 'truecolor' },
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--no-ignore-vcs',
                        '--hidden',
                    },
                },
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    },
                    ['ui-select'] = {
                        themes.get_dropdown(),
                    },
                    undo = {
                        side_by_side = true,
                        layout_strategy = 'vertical',
                        layout_config = {
                            preview_cutoff = 0,
                            preview_height = 0.60,
                        },
                    },
                    file_browser = {
                        theme = 'ivy',
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        hidden = {
                            file_browser = true,
                            folder_browser = true,
                        },
                        display_stat = {
                            date = true,
                            size = true,
                            mode = false,
                        },
                        mappings = {
                            ['i'] = {
                                -- your custom insert mode mappings
                            },
                            ['n'] = {
                                -- your custom normal mode mappings
                            },
                        },
                    },
                    bibtex = {
                        -- Depth for the *.bib file
                        depth = 1,
                        -- Custom format for citation label
                        custom_formats = {},
                        -- Format to use for citation label.
                        -- Try to match the filetype by default, or use 'plain'
                        format = '',
                        -- Path to global bibliographies (placed outside of the project)
                        global_files = { '~/latex/bibliographies/bibliography.bib' },
                        -- Define the search keys to use in the picker
                        search_keys = { 'author', 'year', 'title' },
                        -- Template for the formatted citation
                        citation_format = '{{author}} ({{year}}), {{title}}.',
                        -- Only use initials for the authors first name
                        citation_trim_firstname = true,
                        -- Max number of authors to write in the formatted citation
                        -- following authors will be replaced by "et al."
                        citation_max_auth = 2,
                        -- Context awareness disabled by default
                        context = false,
                        -- Fallback to global/directory .bib files if context not found
                        -- This setting has no effect if context = false
                        context_fallback = true,
                        -- Wrapping in the preview window is disabled by default
                        wrap = false,
                        -- user defined mappings
                        -- mappings = {
                        --     i = {
                        --         ['<CR>'] = bibtex_actions.key_append('%s'), -- format is determined by filetype if the user has not set it explictly
                        --         ['<C-e>'] = bibtex_actions.entry_append,
                        --         ['<C-c>'] = bibtex_actions.citation_append('{{author}} ({{year}}), {{title}}.'),
                        --     },
                        -- },
                    },
                },
            }
        end,

        config = function(_, opts)
            local telescope = require('telescope')

            telescope.setup(opts)
            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')
            telescope.load_extension('noice')
            telescope.load_extension('session-lens')
        end,
    },

    {
        'nvim-telescope/telescope-file-browser.nvim',

        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },

        keys = {
            {
                '<leader>pb',
                function()
                    require('telescope').extensions.file_browser.file_browser({
                        path = '%:p:h',
                        select_buffer = true,
                    })
                end,
                mode = 'n',
                desc = 'file browser',
                noremap = true,
                silent = true,
            },
        },

        config = function() require('telescope').load_extension('file_browser') end,
    },

    {
        'debugloop/telescope-undo.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        keys = {
            {
                '<leader>u',
                '<cmd>Telescope undo<CR>',
                mode = 'n',
                desc = 'undo',
                noremap = true,
                silent = true,
            },
        },
        config = function() require('telescope').load_extension('undo') end,
    },

    {
        'nvim-telescope/telescope-bibtex.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        keys = {
            {
                '<leader>pl',
                '<cmd>Telescope bibtex<CR>',
                mode = 'n',
                desc = 'bibtex',
                noremap = true,
                silent = true,
            },
        },
        config = function() require('telescope').load_extension('bibtex') end,
    },
}
