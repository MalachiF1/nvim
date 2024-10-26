return {
    'windwp/nvim-autopairs',

    event = 'InsertEnter',

    -- opts = {}, -- this is equalent to setup({}) function

    config = function()
        local autopairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')

        autopairs.setup({})

        -- Don't add a pair if in latex math zone, a snippet will be used instead.
        local in_mathzone = function()
            -- The `in_mathzone` function requires the VimTeX plugin
            return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
        end

        autopairs.add_rules({
            Rule('(', ')', { 'tex', 'latex' }):replace_endpair(function(opts)
                if in_mathzone() then
                    return ''
                else
                    return ')'
                end
            end),
        })
    end,
}
