return {
    "HiPhish/rainbow-delimiters.nvim",

    config = function()
        local rainbow_delimiters = require 'rainbow-delimiters'

        -- define the colors here
        vim.api.nvim_set_hl(0, 'RainbowColor1', { fg = "#e6b673" })
        vim.api.nvim_set_hl(0, 'RainbowColor2', { fg = "#d2a6ff" })
        vim.api.nvim_set_hl(0, 'RainbowColor3', { fg = "#f07178" })
        vim.api.nvim_set_hl(0, 'RainbowColor4', { fg = "#ff8f40" })
        vim.api.nvim_set_hl(0, 'RainbowColor5', { fg = "#bfbdb6" })
        vim.api.nvim_set_hl(0, 'RainbowColor6', { fg = "#73b8ff" })
        vim.api.nvim_set_hl(0, 'RainbowColor7', { fg = "#f29688" })

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                commonlisp = rainbow_delimiters.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowColor1',
                'RainbowColor2',
                'RainbowColor3',
                'RainbowColor4',
                'RainbowColor5',
                'RainbowColor6',
                'RainbowColor7',
            },
            blacklist = { 'commonlisp' },
        }
    end,
}
