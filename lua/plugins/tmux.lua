return {
    'aserowy/tmux.nvim',

    lazy = 'WinEnter',

    init = function()
        local map = vim.keymap.set
        map('n', '<M-h>', '<cmd>lua require("tmux").resize_left()<cr>', { noremap = true, silent = true })
        map('n', '<M-j>', '<cmd>lua require("tmux").resize_bottom()<cr>', { noremap = true, silent = true })
        map('n', '<M-k>', '<cmd>lua require("tmux").resize_top()<cr>', { noremap = true, silent = true })
        map('n', '<M-l>', '<cmd>lua require("tmux").resize_right()<cr>', { noremap = true, silent = true })
        map('n', '<C-h>', '<cmd>lua require("tmux").move_left()<cr>', { noremap = true, silent = true })
        map('n', '<C-j>', '<cmd>lua require("tmux").move_bottom()<cr>', { noremap = true, silent = true })
        map('n', '<C-k>', '<cmd>lua require("tmux").move_top()<cr>', { noremap = true, silent = true })
        map('n', '<C-l>', '<cmd>lua require("tmux").move_right()<cr>', { noremap = true, silent = true })
    end,

    config = function()
        require('tmux').setup({
            copy_sync = {
                -- enables copy sync. by default, all registers are synchronized.
                -- to control which registers are synced, see the `sync_*` options.
                enable = true,

                -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
                -- first buffer or named_buffer_name = true to ignore a named tmux
                -- buffer with name named_buffer_name :)
                ignore_buffers = { empty = false },

                -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
                -- clipboard by tmux
                redirect_to_clipboard = false,

                -- offset controls where register sync starts
                -- e.g. offset 2 lets registers 0 and 1 untouched
                register_offset = 0,

                -- overwrites vim.g.clipboard to redirect * and + to the system
                -- clipboard using tmux. If you sync your system clipboard without tmux,
                -- disable this option!
                sync_clipboard = true,

                -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
                sync_registers = true,

                -- syncs deletes with tmux clipboard as well, it is adviced to
                -- do so. Nvim does not allow syncing registers 0 and 1 without
                -- overwriting the unnamed register. Thus, ddp would not be possible.
                sync_deletes = true,

                -- syncs the unnamed register with the first buffer entry from tmux.
                sync_unnamed = true,
            },
            navigation = {
                -- cycles to opposite pane while navigating into the border
                cycle_navigation = true,

                -- enables default keybindings (C-hjkl) for normal mode
                enable_default_keybindings = false,

                -- prevents unzoom tmux when navigating beyond vim border
                persist_zoom = false,
            },
            resize = {
                -- enables default keybindings (A-hjkl) for normal mode
                enable_default_keybindings = false,

                -- sets resize steps for x axis
                resize_step_x = 1,

                -- sets resize steps for y axis
                resize_step_y = 1,
            },
        })
    end,
}