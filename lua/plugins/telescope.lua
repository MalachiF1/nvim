return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim'
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
                ["ui-select"] = {
                    themes.get_dropdown {
                        -- even more opts
                    }
                }
            }
        })
        telescope.load_extension("ui-select")


        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'files', noremap = true, silent = true })
        vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'git files', noremap = true, silent = true })
        -- vim.keymap.set('n', '<C-j>', builtin.move_selection_next, {})
        -- vim.keymap.set('n', '<C-k>', builtin.move_selection_previous, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = 'grep string', noremap = true, silent = true })
    end,
}
