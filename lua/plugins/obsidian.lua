return {
    'epwalsh/obsidian.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'hrsh7th/nvim-cmp',
    },

    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        'BufReadPre /mnt/c/Users/malac/Notes/**.md',
    },

    keys = {
        {
            '<leader>nn',
            function()
                vim.ui.input({ prompt = 'Title: ' }, function(input) vim.cmd('ObsidianNew ' .. input) end)
            end,
            mode = 'n',
            desc = 'new note',
            noremap = true,
            silent = true,
        },
        { '<leader>no', ':ObsidianOpen<CR>', mode = 'n', desc = 'open in obsidian', noremap = true, silent = true },
        { '<leader>nq', ':ObsidianQuickSwitch<CR>', mode = 'n', desc = 'quick switch', noremap = true, silent = true },
        { '<leader>nf', ':ObsidianFollowLink<CR>', mode = 'n', desc = 'follow link', noremap = true, silent = true },
        { '<leader>nb', ':ObsidianBackLinks<CR>', mode = 'n', desc = 'get references', noremap = true, silent = true },
        { '<leader>nd', ':ObsidianToday<CR>', mode = 'n', desc = 'daily note', noremap = true, silent = true },
        { '<leader>ny', ':ObsidianYesterday<CR>', mode = 'n', desc = "yeserday's daily note", noremap = true, silent = true },
        { '<leader>nt', ':ObsidianTemplate<CR>', mode = 'n', desc = 'insert template', noremap = true, silent = true },
        { '<leader>ns', ':ObsidianSearch<CR>', mode = 'n', desc = 'search', noremap = true, silent = true },
        { '<leader>nl', ':ObsidianLink<CR>', mode = 'v', desc = 'link a note', noremap = true, silent = true },
        { '<leader>nw', ':ObsidianLinkNew<CR>', mode = 'v', desc = 'link a new note', noremap = true, silent = true },
    },

    opts = {
        dir = '/mnt/c/Users/malac/Notes/**.md', -- no need to call 'vim.fn.expand' here

        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = 'Daily Notes',
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = '%d-%m-%y',
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = '%d-%m0%y',
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil,
        },

        -- Optional, completion.
        completion = {
            -- If using nvim-cmp, otherwise set to false
            nvim_cmp = true,
            -- Trigger completion at 2 chars
            min_chars = 1,
            -- Where to put new notes created from completion. Valid options are
            --  * "current_dir" - put new notes in same directory as the current buffer.
            --  * "notes_subdir" - put new notes in the default notes subdirectory.
            new_notes_location = 'current_dir',

            -- Whether to add the output of the node_id_func to new notes in autocompletion.
            -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
            prepend_note_id = true,
        },

        -- Optional, key mappings.
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ['gf'] = {
                action = function() return require('obsidian').util.gf_passthrough() end,
                opts = { noremap = false, expr = true, buffer = true },
            },
        },
        -- Optional, if set to true, the specified mappings in the `mappings`
        -- table will overwrite existing ones. Otherwise a warning is printed
        -- and the mappings are not applied.
        overwrite_mappings = false,

        -- Optional, set to true if you don't want obsidian.nvim to manage frontmatter.
        disable_frontmatter = false,
    },

    -- Optional, for templates (see below).
    templates = {
        subdir = 'Templates',
        date_format = '%d-%m-%y',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
    },

    -- Optional, set to true if you use the Obsidian Advanced URI plugin.
    -- https://github.com/Vinzent03/obsidian-advanced-uri
    use_advanced_uri = true,

    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = false,

    -- Optional, by default commands like `:ObsidianSearch` will attempt to use
    -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
    -- first one they find. By setting this option to your preferred
    -- finder you can attempt it first. Note that if the specified finder
    -- is not installed, or if it the command does not support it, the
    -- remaining finders will be attempted in the original order.
    finder = 'telescope.nvim',

    -- Optional, determines whether to open notes in a horizontal split, a vertical split,
    -- or replacing the current buffer (default)
    -- Accepted values are "current", "hsplit" and "vsplit"
    open_notes_in = 'current',
}
