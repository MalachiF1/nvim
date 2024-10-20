return {
    'f-person/git-blame.nvim',

    cmd = 'GitBlameToggle',

    keys = {
        {
            '<leader>gb',
            ':GitBlameToggle<CR>',
            mode = 'n',
            desc = 'blame',
            noremap = true,
            silent = true,
        },
    },

    opts = {
        --Note how the `gitblame_` prefix is omitted in `setup`
        enabled = false,
        message_template = '<summary> • <date> • <author>',
        date_format = '%d/%m/%y %H:%M:%S',
        message_when_not_committed = 'Not committed',
        highlight_group = 'Comment', -- Question
        display_virtual_text = 1,
        delay = 1000, -- 1 second
        -- virtual_text_column = 80,
    },
}
