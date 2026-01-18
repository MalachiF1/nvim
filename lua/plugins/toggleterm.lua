return {
    -- amongst your other plugins
    'akinsho/toggleterm.nvim',

    version = '*',

    cmd = { 'ToggleTerm', 'TermExec', 'ToggleTermSendCurrentLine', 'ToggleTermSendVisualLines' },

    keys = {
        {
            '<leader>th',
            ':ToggleTerm direction=horizontal<CR>',
            mode = 'n',
            desc = 'horizontal',
            noremap = true,
            silent = true,
        },
        {
            '<leader>tf',
            ':ToggleTerm direction=float<CR>',
            mode = 'n',
            desc = 'float',
            noremap = true,
            silent = true,
        },
        {
            '<leader>tv',
            ':ToggleTerm direction=vertical<CR>',
            mode = 'n',
            desc = 'vertical',
            noremap = true,
            silent = true,
        },
    },

    opts = {
        size = function(term)
            if term.direction == 'horizontal' then
                local height = math.ceil(vim.o.lines * 0.35)
                if height >= 20 then
                    return 20
                else
                    return height
                end

                return
            elseif term.direction == 'vertical' then
                return math.ceil(vim.o.columns * 0.33)
            end
        end,
        persist_size = false,
        float_opts = {
            -- The border key is *almost* the same as 'nvim_open_win'
            -- see :h nvim_open_win for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            border = 'single',
            -- like `size`, width and height can be a number or function which is passed the current terminal
            width = function() return math.ceil(vim.o.columns * 0.7) end,
            height = function() return math.ceil(vim.o.lines * 0.7) end,
            winblend = 3,
        },
    },

    config = function(_, opts)
        require('toggleterm').setup(opts)

        function _G.set_terminal_keymaps()
            local options = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], options)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], options)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], options)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], options)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], options)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], options)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], options)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
}
