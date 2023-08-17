return {
    'echasnovski/mini.animate',
    version = false,

    config = function()
        local is_many_wins = function(sizes_from, sizes_to)
            return vim.tbl_count(sizes_from) >= 3
        end

        local animate = require('mini.animate')

        animate.setup({
            -- Cursor path
            cursor = {
                -- Whether to enable this animation
                enable = false,

                -- Timing of animation (how steps will progress in time)
                -- timing = function: implements linear total 250ms animation duration>,

                -- Path generator for visualized cursor movement
                -- path = function: implements shortest line path>,
            },

            -- Vertical scroll
            scroll = {
                -- Whether to enable this animation
                enable = true,

                -- Timing of animation (how steps will progress in time)
                timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),

                -- Animate equally but with at most 120 steps instead of default 60
                subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),

                -- Timing of animation (how steps will progress in time)
                -- timing = function: implements linear total 250ms animation duration>,

                -- Subscroll generator based on total scroll
                -- subscroll = --<function: implements equal scroll with at most 60 steps>,
            },

            -- Window resize
            resize = {
                -- Whether to enable this animation
                enable = false, -- broken?

                -- Animate for 200 milliseconds with linear easing
                timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),

                -- Animate only if there are at least 3 windows
                subresize = animate.gen_subscroll.equal({ predicate = is_many_wins }),

                -- Subresize generator for all steps of resize animations
                -- subresize = function: implements equal linear steps>,
            },

            -- Window open
            open = {
                -- Whether to enable this animation
                enable = false,

                -- Timing of animation (how steps will progress in time)
                -- timing = function: implements linear total 250ms animation duration>,

                -- Floating window config generator visualizing specific window
                -- winconfig = function: implements static window for 25 steps>,

                -- 'winblend' (window transparency) generator for floating window
                -- winblend = function: implements equal linear steps from 80 to 100>,
            },

            -- Window close
            close = {
                -- Whether to enable this animation
                enable = false,

                -- Timing of animation (how steps will progress in time)
                -- timing = function: implements linear total 250ms animation duration>,

                -- Floating window config generator visualizing specific window
                -- winconfig = function: implements static window for 25 steps>,

                -- 'winblend' (window transparency) generator for floating window
                -- winblend = function: implements equal linear steps from 80 to 100>,
            },
        })
    end,
}
