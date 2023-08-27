return {
    'echasnovski/mini.clue',

    version = false,

    event = 'VeryLazy',

    config = function()
        local miniclue = require('mini.clue')
        miniclue.setup({
            -- Array of extra clues to show
            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),

                { mode = 'n', keys = '<leader>w', desc = '+Window' },
                { mode = 'n', keys = '<leader>b', desc = '+Buffer' },
                { mode = 'n', keys = '<leader>s', desc = '+Save' },
                { mode = 'n', keys = '<leader>q', desc = '+Quit' },
                { mode = 'n', keys = '<leader>p', desc = '+Project' },
                { mode = 'n', keys = '<leader>g', desc = '+Git' },
                { mode = 'n', keys = '<leader>l', desc = '+Lsp' },
                { mode = 'n', keys = '<leader>d', desc = '+Debug' },
                { mode = 'n', keys = '<leader>t', desc = '+Terminal' },
                { mode = 'n', keys = '<leader>f', desc = '+Fold' },
                { mode = 'n', keys = '<leader>o', desc = '+Options' },
                { mode = 'n', keys = '<leader>lg', desc = '+Go to' },
                { mode = 'n', keys = '<leader>bm', desc = '+Move' },
                { mode = 'n', keys = '<leader>w<', postkeys = '<leader>w' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>w>', postkeys = '<leader>w' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>w-', postkeys = '<leader>w' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>w+', postkeys = '<leader>w' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>lgn', postkeys = '<leader>lg' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>lgp', postkeys = '<leader>lg' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>bmh', postkeys = '<leader>bm' }, -- for hydra like submodes
                { mode = 'n', keys = '<leader>bml', postkeys = '<leader>bm' }, -- for hydra like submodes
            },

            -- Array of opt-in triggers which start custom key query process.
            -- **Needs to have something in order to show clues**.
            triggers = {
                { mode = 'n', keys = '<Leader>' },
            },

            -- Clue window settings
            window = {
                -- Floating window config
                config = {
                    width = 'auto',
                    border = 'single',
                    anchor = 'SE',
                },

                -- Delay before showing clue window
                delay = 800,

                -- Keys to scroll inside the clue window
                scroll_down = '<C-j>',
                scroll_up = '<C-k>',
            },
        })
    end,
}
