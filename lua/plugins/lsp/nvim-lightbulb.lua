return {
    'kosayoda/nvim-lightbulb',

    event = { 'BufRead', 'BufNewFile' },

    opts = {
        priority = 1000, -- of the sign
        code_lenses = true, -- show `lens_text` when the line has an executable code lens

        sign = {
            text = '󰠠',
            lens_text = '',
        },

        autocmd = {
            enabled = true,
            updatetime = -1, -- keep the global updatetime from config/options.lua
        },
    },
}
