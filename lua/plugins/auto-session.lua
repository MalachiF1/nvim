return {
    'rmagatti/auto-session',

    -- dependencies = {
    -- 'nvim-telescope/telescope.nvim',
    -- },

    cmd = {
        'AutoSession restore',
        'SessionRestore',
        'SessionSave',
        'SessionDelete',
        'SessionSearch',
        'SessionToggleAutoSave',
        'SessionPurgeOrphaned',
        'Telescope session-lens',
    },

    event = 'BufReadPost',

    lazy = false,

    init = function() vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions' end,

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        auto_restore = false,
        auto_restore_last_session = false,
        auto_save = true,
        close_unsupported_windows = true,
        continue_restore_on_error = true,
        cwd_change_handling = true,
        enabled = true,
        lazy_support = true,
        log_level = 'error',
        root_dir = vim.fn.stdpath('data') .. '/sessions/',
        session_lens = {
            load_on_setup = false,
            picker_opts = {
                border = true,
            },
            previewer = false,
        },
    },
}
