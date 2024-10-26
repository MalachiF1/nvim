return {
    'quarto-dev/quarto-nvim',
    dependencies = {
        'jmbuhr/otter.nvim',
        'nvim-treesitter/nvim-treesitter',
    },

    ft = { 'quarto' },

    opts = {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
            enabled = true,
            chunks = 'curly',
            languages = { 'lua', 'python', 'matlab', 'bash', 'html', 'css', 'javascript', 'typescript', 'c', 'cpp' },
            diagnostics = {
                enabled = true,
                triggers = { 'BufWritePost' },
            },
            completion = {
                enabled = true,
            },
        },
        codeRunner = {
            enabled = false,
            default_method = nil, -- 'molten' or 'slime'
            ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
            -- Takes precedence over `default_method`
            never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
        },
    },
}
