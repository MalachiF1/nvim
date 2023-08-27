return {
    'lukas-reineke/indent-blankline.nvim',

    event = 'BufReadPre',

    config = function()
        require('indent_blankline').setup({
            -- for example, context is off by default, use this to turn it on
            show_current_context = true,
            show_current_context_start = true,
            filetype_exclude = {
                'lspinfo',
                'lazy',
                'chechhealth',
                'help',
                'man',
                '',
                'dashboard',
                'alpha',
            },
        })
    end,
}
