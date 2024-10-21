return {

    'lervag/vimtex',
    -- lazy = false, -- we don't want to lazy load VimTeX

    ft = { 'tex' },

    init = function()
        -- VimTeX configuration goes here
        vim.g.vimtex_view_general_viewer = 'SumatraPDF'
        vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        vim.g.vimtex_syntax_enabled = 0
        -- vim.g.vimtex_view_general_options_latexmk = '-reuse-instance'

        -- When working in a multi-file project, initiating inverse search (see
        -- |vimtex-synctex-inverse-search|) may require opening a file that is not
        -- currently open in a window. This option controls the command that is used to
        -- open files as a result of an inverse search.
        vim.g.vimtex_view_reverse_search_edit_cmd = 'edit'

        -- Focus the terminal after inverse search
        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'VimtexEventViewReverse',
        --     group = au_group,
        --     command = 'call b:vimtex.viewer.xdo_focus_vim()',
        -- })

        -- Place the following setting in sumatraPDF's advanced settings for inverse search to work:
        -- InverseSearchCmdLine = cmd /q /c start /min "" powershell -WindowStyle Hidden -Command "& {$file = (('%f' -replace '\\','/') -replace '//wsl.localhost.Ubuntu-20.04',''); wsl --exec nvim --server /tmp/nvim.pipe --remote-send """":e $file | %l<CR>""""} %*"
    end,
}
