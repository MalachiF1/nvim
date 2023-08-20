return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        }
    },

    config = function()
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local themes = require('telescope.themes')
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                    }
                }
            },
            pickers = {},
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
                ["ui-select"] = {
                    themes.get_dropdown {
                        -- even more opts
                    }
                },
            }
        })
        telescope.load_extension("fzf")
        telescope.load_extension("ui-select")


        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'files', noremap = true, silent = true })
        vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'git files', noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = 'grep string', noremap = true, silent = true })
        vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = 'undo', noremap = true, silent = true })
    end,
}
