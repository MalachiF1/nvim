return {
    'declancm/cinnamon.nvim',

    event = 'BufReadPost',

    keymaps = {
        -- Enable the provided 'basic' keymaps
        basic = true,
        -- Enable the provided 'extra' keymaps
        extra = true,
    },

    opts = {
        -- The scrolling mode
        -- `cursor`: animate cursor and window scrolling for any movement
        -- `window`: animate window scrolling ONLY when the cursor moves out of view
        mode = 'cursor',

        -- Only animate scrolling if a count is provided
        count_only = false,

        -- Delay between each movement step (in ms)
        delay = 3,

        max_delta = {
            -- Maximum distance for line movements before scroll
            -- animation is skipped. Set to `false` to disable
            line = 100,
            -- Maximum distance for column movements before scroll
            -- animation is skipped. Set to `false` to disable
            column = 100,
            -- Maximum duration for a movement (in ms). Automatically scales the
            -- delay and step size
            time = 150,
        },

        step_size = {
            -- Number of cursor/window lines moved per step
            vertical = 1,
            -- Number of cursor/window columns moved per step
            horizontal = 2,
        },
    },

    config = function(_, opts)
        if vim.g.neovide then return end -- don't load this plugin in neovide, it's very laggy

        require('cinnamon').setup(opts)

        vim.keymap.set({ 'n', 'x' }, 'gg', function() require('cinnamon').scroll('ggzz0') end)
        vim.keymap.set({ 'n', 'x' }, 'G', function() require('cinnamon').scroll('Gzz$') end)
        vim.keymap.set({ 'n', 'x' }, '<C-U>', function() require('cinnamon').scroll('<C-U>zz') end)
        vim.keymap.set({ 'n', 'x' }, '<C-D>', function() require('cinnamon').scroll('<C-D>zz') end)
        vim.keymap.set({ 'n', 'x' }, 'zz', function() require('cinnamon').scroll('zz') end)
    end,
}
