return {
    'kevinhwang91/nvim-bqf',

    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },

    ft = 'qf',

    opts = {
        auto_enable = true,
        -- Give the window magic, when the window is splited horizontally,
        -- keep the distance between the current line and the top/bottom border of neovim unchanged.
        -- It's a bit like a floating window, but the window is indeed a normal window, without any floating attributes.
        magic_window = true,
        auto_resize_height = true,
        preview = {
            auto_preview = true,
            border = 'single', -- :h nvim_open_win() | call search('border:')
            -- border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
            show_title = true,
            show_scroll_bar = false,
            win_height = 15,
            win_vheight = 15,
            winblend = 10,
            wrap = false,
        },
    },
}
