return {
    'NeogitOrg/neogit',

    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'nvim-telescope/telescope.nvim', -- optional
        'sindrets/diffview.nvim', -- optional
    },

    cmd = 'Neogit',

    keys = {
        { '<leader>gs', ':Neogit<CR>', mode = 'n', desc = 'status', noremap = true, silent = true },
    },

    opts = {
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        -- disable_commit_confirmation = false,
        disable_insert_on_commit = 'auto',
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        -- Value used for `--sort` option for `git branch` command
        -- By default, branches will be sorted by commit date descending
        -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
        -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
        sort_branches = '-committerdate',
        -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
        -- events.
        filewatcher = {
            interval = 1000,
            enabled = true,
        },
        -- Used to generate URL's for branch popup action "pull request".
        git_services = {
            ['github.com'] = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
            ['bitbucket.org'] = 'https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1',
            ['gitlab.com'] = 'https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}',
            ['azure.com'] = 'https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}',
        },
        -- "ascii"   is the graph the git CLI generates
        -- "unicode" is the graph like https://github.com/rbong/vim-flog
        graph_style = 'unicode',
        -- disable_builtin_notifications = false,
        -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example
        -- below will use the native fzf sorter instead.
        telescope_sorter = function() return require('telescope').extensions.fzf.native_fzf_sorter() end,
        -- Persist the values of switches/options within and across sessions
        remember_settings = true,
        -- Scope persisted settings on a per-project basis
        use_per_project_settings = true,
        -- Change the default way of opening neogit
        -- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
        --   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
        ignored_settings = {},
        -- Configure highlight group features
        highlight = {
            italic = true,
            bold = true,
            underline = true,
        },
        -- Set to false if you want to be responsible for creating _ALL_ keymappings
        use_default_keymaps = true,
        -- Change the default way of opening neogit
        kind = 'tab',
        -- Disable line numbers and relative line numbers
        disable_line_numbers = true,
        -- The time after which an output console is shown for slow running commands
        console_timeout = 2000,
        -- Automatically show console if a command takes more than console_timeout milliseconds
        auto_show_console = true,
        -- -- Automatically close the console if the process exits with a 0 (success) status
        auto_close_console = true,
        -- Change the default way of opening the commit popup
        commit_popup = {
            kind = 'split',
        },
        -- Change the default way of opening the preview buffer
        preview_buffer = {
            kind = 'split',
        },
        -- Change the default way of opening popups
        popup = {
            kind = 'split',
        },
        commit_editor = {
            kind = 'tab',
            show_staged_diff = true,
            -- Accepted values:
            -- "split" to show the staged diff below the commit editor
            -- "vsplit" to show it to the right
            -- "split_above" Like :top split
            -- "vsplit_left" like :vsplit, but open to the left
            -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
            staged_diff_split_kind = 'split',
            spell_check = true,
        },
        commit_select_view = {
            kind = 'tab',
        },
        commit_view = {
            kind = 'vsplit',
            verify_commit = vim.fn.executable('gpg') == 1, -- Can be set to true or false, otherwise we try to find the binary
        },
        log_view = {
            kind = 'tab',
        },
        rebase_editor = {
            kind = 'auto',
        },
        reflog_view = {
            kind = 'tab',
        },
        merge_editor = {
            kind = 'auto',
        },
        tag_editor = {
            kind = 'auto',
        },
        -- customize displayed signs
        signs = {
            -- { CLOSED, OPENED }
            section = { '>', 'v' },
            item = { '>', 'v' },
            hunk = { '', '' },
        },
        -- Each Integration is auto-detected through plugin presence. Disabled by setting to `false`
        integrations = {
            -- If enabled, use telescope for menu selection rather than vim.ui.select.
            -- Allows multi-select and some things that vim.ui.select doesn't.
            telescope = true,

            -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
            -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
            --
            -- Requires you to have `sindrets/diffview.nvim` installed.
            diffview = true,
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
            untracked = {
                folded = false,
                hidden = false,
            },
            unstaged = {
                folded = false,
                hidden = false,
            },
            staged = {
                folded = false,
                hidden = false,
            },
            stashes = {
                folded = true,
                hidden = false,
            },
            unpulled = {
                folded = true,
                hidden = false,
            },
            unmerged = {
                folded = false,
                hidden = false,
            },
            recent = {
                folded = true,
                hidden = false,
            },
        },
        -- override/add mappings
        mappings = {
            -- modify status buffer mappings
            status = {
                -- Adds a mapping with "B" as key that does the "BranchPopup" command
                -- ['B'] = 'BranchPopup',
                -- Removes the default mapping of "s"
                -- ["s"] = false,
                --...
            },
            -- Modify fuzzy-finder buffer mappings
            finder = {
                -- Binds <cr> to trigger select action
                ['<cr>'] = 'Select',
                --...
            },
        },
    },
}
