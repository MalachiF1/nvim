return {

    'lervag/vimtex',
    -- lazy = false, -- we don't want to lazy load VimTeX

    ft = { 'tex' },

    init = function()
        -- VimTeX configuration goes here
        vim.g.vimtex_view_general_viewer = 'SumatraPDF'
        vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_quickfix_open_on_warning = 0

        vim.g.vimtex_syntax_conceal_disable = 1

        -- vim.g.vimtex_syntax_conceal = {
        --     accents = 1,
        --     ligatures = 1,
        --     cites = 1, --check vimtex_syntax_conceal_cites
        --     fancy = 1,
        --     spacing = 1,
        --     greek = 1,
        --     math_bounds = 1,
        --     math_delimiters = 1,
        --     math_fractions = 1,
        --     math_super_sub = 1,
        --     math_symbols = 1,
        --     sections = 1,
        --     styles = 1,
        -- }
        --
        -- vim.g.vimtex_syntax_conceal_cites = {
        --     type = 'brackets',
        --     verbose = false,
        --     icon = '',
        -- }
        --
        -- vim.g.vimtex_syntax_custom_cmds = {
        --     {
        --         name = 'N',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = 'ℕ',
        --     },
        --     {
        --         name = 'Z',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = 'ℤ',
        --     },
        --     {
        --         name = 'Q',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = 'ℚ',
        --     },
        --     {
        --         name = 'R',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = 'ℝ',
        --     },
        --     {
        --         name = 'C',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = 'ℂ',
        --     },
        --     {
        --         name = 'F',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = '𝔽',
        --     },
        --     {
        --         name = 'ham',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = 'ℋ',
        --         -- arg = true,
        --     },
        --     {
        --         name = 'bigo',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = '𝒪',
        --     },
        --     {
        --         name = 'p',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = '∂',
        --     },
        --     {
        --         name = 'del',
        --         mathmode = true,
        --         conceal = true,
        --         concealchar = '∇',
        --     },
        -- }
        --
        -- vim.g.vimtex_syntax_custom_cmds_with_concealed_delims = {
        --     {
        --         name = 'vec',
        --         nargs = 1,
        --         argstyle = 'bold', -- bold, ital, under, boldital, boldunder, italunder ,boldbitalunder
        --         mathmode = 1,
        --         cchar_open = '',
        --         cchar_close = '',
        --     },
        --     {
        --         name = 'nvec',
        --         nargs = 1,
        --         argstyle = 'bold', -- bold, ital, under, boldital, boldunder, italunder ,bolditalunder
        --         mathmode = 1,
        --         cchar_open = '',
        --         cchar_close = '',
        --     },
        --     {
        --         name = 'uvec',
        --         nargs = 1,
        --         argstyle = 'boldunder', -- bold, ital, under, boldital, boldunder, italunder ,bolditalunder
        --         mathmode = 1,
        --         cchar_open = '',
        --         cchar_close = '',
        --     },
        --     {
        --         name = 'ket',
        --         nargs = 1,
        --         mathmode = true,
        --         cchar_open = '|',
        --         cchar_close = '>',
        --     },
        --     {
        --         name = 'bra',
        --         nargs = 1,
        --         mathmode = true,
        --         cchar_open = '<',
        --         cchar_close = '|',
        --     },
        --     {
        --         name = 'braket',
        --         nargs = 2,
        --         mathmode = true,
        --         cchar_open = '<',
        --         cchar_mid = '|',
        --         cchar_close = '>',
        --     },
        --     {
        --         name = 'binom',
        --         nargs = 2,
        --         mathmode = true,
        --         cchar_open = '(',
        --         cchar_mid = '|',
        --         cchar_close = ')',
        --     },
        --     {
        --         name = 'frac',
        --         nargs = 2,
        --         mathmode = true,
        --         cchar_open = '(',
        --         cchar_mid = '/',
        --         cchar_close = ')',
        --     },
        --     {
        --         name = 'f',
        --         nargs = 2,
        --         mathmode = true,
        --         cchar_open = '(',
        --         cchar_mid = '/',
        --         cchar_close = ')',
        --     },
        -- }

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
