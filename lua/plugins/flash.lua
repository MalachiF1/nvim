return {
    'folke/flash.nvim',

    event = 'VeryLazy',

    ---@type Flash.Config
    opts = {
        jump = {

            autojump = true, -- automatically jump when there is only one match
            nohlsearch = true, -- clear highlight after jump
        },
        label = {
            after = false, -- show the label before the match, not after
            before = true,
            reuse = 'all', -- reuse uppercase labels too when typing more characters
            min_pattern_length = 2, -- minimum pattern length to show labels
        },
        highlight = {
            backdrop = false,
        },
        -- smooth-scroll to the jump target
        action = function(match, state)
            require('cinnamon').scroll(function()
                require('flash.jump').jump(match, state)
                require('flash.jump').on_jump(state)
            end)
        end,

        modes = {
            -- flash labels during regular `/` and `?` search
            search = {
                enabled = true,
            },
            -- `f`, `F`, `t`, `T`, `;` and `,` motions
            char = {
                enabled = true,
                jump_labels = true,
                multi_line = false, -- only the current line
                highlight = { backdrop = false },
            },
        },
    },

    keys = {
        {
            's',
            mode = { 'n', 'x', 'o' },
            function() require('flash').jump() end,
            desc = 'Flash',
        },
        {
            'S',
            mode = { 'n', 'o', 'x' },
            function() require('flash').treesitter() end,
            desc = 'Flash Treesitter',
        },
        {
            'r',
            mode = 'o',
            function() require('flash').remote() end,
            desc = 'Remote Flash',
        },
        {
            '<C-s>',
            mode = { 'n', 'o', 'x' },
            function() require('flash').treesitter_search() end,
            desc = 'Treesitter Search',
        },
        -- {
        -- 	"<c-s>",
        -- 	mode = { "c" },
        -- 	function()
        -- 		require("flash").toggle()
        -- 	end,
        -- 	desc = "Toggle Flash Search",
        -- },
    },
}
