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
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    end,
}
