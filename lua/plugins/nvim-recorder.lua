return {

    'chrisgrieser/nvim-recorder',

    dependencies = {
        'rcarriga/nvim-notify', -- optional
    },

    keys = {
        -- these must match the keys in the mapping config below ##
        { 'q', desc = ' Start Recording' },
        { 'Q', desc = ' Play Recording' },
    },

    opts = {
        -- Named registers where macros are saved (single lowercase letters only).
        -- The first register is the default register used as macro-slot used after
        -- startup.
        slots = { 'a', 'b' },
        mapping = {
            startStopRecording = 'q',
            playMacro = 'Q',
            switchSlot = '<C-q>',
            editMacro = 'cq',
            yankMacro = 'yq',
            addBreakPoint = '##', -- ⚠️ this should be a string you don't use in insert mode during a macro
        },

        -- Clears all macros-slots on startup.
        clear = false,

        -- Log level used for any notification, mostly relevant for nvim-notify.
        -- (Note that by default, nvim-notify does not show the levels trace & debug.)
        logLevel = vim.log.levels.INFO,

        -- If enabled, only critical notifications are sent.
        -- If you do not use a plugin like nvim-notify, set this to `true`
        -- to remove otherwise annoying messages.
        lessNotifications = false,

        -- Performance optimizations for macros with high count. When `playMacro` is
        -- triggered with a count higher than the threshold, nvim-recorder
        -- temporarily changes changes some settings for the duration of the macro.
        performanceOpts = {
            countThreshold = 100,
            lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
            noSystemClipboard = true, -- remove `+`/`*` from clipboard option
            autocmdEventsIgnore = { -- temporarily ignore these autocmd events
                'TextChangedI',
                'TextChanged',
                'InsertLeave',
                'InsertEnter',
                'InsertCharPre',
            },
        },
    },

    config = function(_, opts)
        require('recorder').setup(opts)

        local lualineZ = require('lualine').get_config().sections.lualine_z or {}
        local lualineY = require('lualine').get_config().sections.lualine_y or {}
        table.insert(lualineZ, { require('recorder').recordingStatus })
        table.insert(lualineY, { require('recorder').displaySlots })

        require('lualine').setup({
            sections = {
                lualine_y = lualineY,
                lualine_z = lualineZ,
            },
        })
    end,
}
