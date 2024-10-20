return {

    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX

    init = function()
        -- VimTeX configuration goes here
        vim.g.vimtex_view_general_viewer = 'SumatraPDF'
        vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        vim.g.vimtex_syntax_enabled = 0
        -- vim.g.vimtex_view_general_options_latexmk = '-reuse-instance'
    end,
}
