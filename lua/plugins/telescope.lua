return {
    'nvim-telescope/telescope.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build =
            'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
        'debugloop/telescope-undo.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },

    branch = '0.1.x',

    cmd = 'Telescope',

    keys = {
        {
            '<leader>pf',
            ':Telescope find_files<CR>',
            mode = 'n',
            desc = 'files',
            noremap = true,
            silent = true,
        },
        {
            '<leader>pg',
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
        {
            '<leader>u',
            ':Telescope undo<CR>',
            mode = 'n',
            desc = 'undo',
            noremap = true,
            silent = true,
        },
        {
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
            ':lua require("auto-session").setup_session_lens(); vim.cmd[[Telescope session-lens]]<CR>',
            mode = 'n',
            desc = 'restore session',
            noremap = true,
            silent = true,
        },
    },

    opts = function()
        local actions = require('telescope.actions')
        local themes = require('telescope.themes')

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
                winblend = 5,
                dynamic_preveiew_title = true,
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
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
            },
        }
    end,

    config = function(_, opts)
        local telescope = require('telescope')

        telescope.setup(opts)
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
        telescope.load_extension('undo')
        telescope.load_extension('file_browser')
        telescope.load_extension('session-lens')
        telescope.load_extension('noice')
    end,
}
