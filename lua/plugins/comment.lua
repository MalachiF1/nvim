return {
    'numToStr/Comment.nvim',

    keys = {
        { 'gcc', mode = 'n', desc = 'Comment  line' },
        { 'gc', mode = { 'n', 'o', 'x' }, desc = 'Comment linewise' },
        { 'gbc', mode = 'n', desc = 'Comment current block' },
        { 'gb', mode = { 'n', 'o', 'x' }, desc = 'Comment blockwise' },
    },

    opts = function()
        return {
            padding = true,
            sticky = true,
            toggler = {
                line = 'gcc',
                block = 'gbc',
            },
            opleader = {
                line = 'gc',
                block = 'gb',
            },
            extra = {
                --Add comment on the line above
                above = 'gcO',
                --Add comment on the line below
                below = 'gco',
                --Add comment at the end of line
                eol = 'gcA',
            },
            mappings = {
                basic = true,
                extra = true,
            },
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    end,
}
