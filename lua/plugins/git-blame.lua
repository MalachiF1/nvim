return {
    "f-person/git-blame.nvim",

    config = function()
        require('gitblame').setup {
            --Note how the `gitblame_` prefix is omitted in `setup`
            enabled = 0,
            message_template = '<summary> • <date> • <author>',
            date_format = '%d/%m/%y %H:%M:%S',
            message_when_not_committed = 'Not committed',
            highlight_group = "Comment", -- Question
            display_virtual_text = 1,
            delay = 1000,                -- 1 second
            -- virtual_text_column = 60,
        }
        vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { desc = 'blame', noremap = true, silent = true })
        vim.cmd [[GitBlameDisable]]
    end
}
