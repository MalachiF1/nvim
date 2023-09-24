return {
    'nvim-telescope/telescope.nvim',

    branch = '0.1.x',

    -- event = "VimEnter",
    cmd = 'Telescope',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        },
        'debugloop/telescope-undo.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },

    init = function()
        local map = vim.keymap.set
        map('n', '<leader>pf', ':Telescope find_files<CR>', { desc = 'files', noremap = true, silent = true })
        map('n', '<leader>pg', ':Telescope git_files<CR', { desc = 'git files', noremap = true, silent = true })
        map('n', '<leader>pr', ':Telescope oldfiles<CR>', { desc = 'recent files', noremap = true, silent = true })
        map(
            'n',
            '<leader>ps',
            -- ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<CR>",
            ":lua require('telescope.builtin').live_grep()<CR>",
            { desc = 'grep string', noremap = true, silent = true }
        )
        map('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = 'undo', noremap = true, silent = true })
        map(
            'n',
            '<space>pb',
            ':Telescope file_browser path=%:p:h select_buffer=true <CR>',
            { desc = 'browser', noremap = true, silent = true }
        )
        map('n', '<leader>oc', ':Telescope colorscheme<CR>', { desc = 'colorscheme', noremap = true, silent = true })
        map(
            'n',
            '<leader>r',
            ":lua require('auto-session').setup_session_lens(); vim.cmd[[Telescope session-lens]]<CR>",
            { desc = 'restore session', noremap = true, silent = true }
        )
    end,

    config = function()
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local themes = require('telescope.themes')
        local telescope = require('telescope')

        telescope.setup({
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
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┙', '┕' },
                -- ┚ ┕
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
            },
        })
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
        telescope.load_extension('undo')
        telescope.load_extension('file_browser')
        telescope.load_extension('session-lens')
    end,
}
