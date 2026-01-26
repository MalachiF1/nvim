return {

    'lervag/vimtex',
    -- lazy = false, -- we don't want to lazy load VimTeX

    ft = { 'tex' },

    init = function()
        -- VimTeX configuration goes here

        local function is_wsl()
            local f = io.open('/proc/version', 'r')
            if f then
                local version = f:read('*a')
                f:close()
                return version:lower():find('wsl') ~= nil or version:lower():find('microsoft') ~= nil
            end
            return false
        end

        local viewer = 'general'
        local general_options = '-reuse-instance -forward-search @tex @line @pdf'

        if is_wsl() then
            if vim.fn.executable('SumatraPDF.exe') == 1 then
                viewer = 'SumatraPDF.exe'
                --- IMPORTANT ---:
                -- For inverse-search to work, place The following line in SumatraPDF settings
                -- (Settings > Options > Set inverse search command line):
                -- wsl.exe -d Ubuntu -e bash -c "~/.local/bin/for_wsl/wsl-inverse-search '%f' %l"
            elseif vim.fn.executable('zathura') == 1 then
                viewer = 'zathura'
            else
                viewer = 'wslview'
                general_options = '@pdf'
            end
        else
            if vim.fn.executable('zathura.exe') == 1 then
                viewer = 'zathura'
            elseif vim.fn.executable('SumatraPDF') == 1 then
                viewer = 'SumatraPDF'
            end
        end

        vim.g.vimtex_view_general_viewer = viewer
        vim.g.vimtex_view_general_options = general_options
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_matchparen_enabled = 1

        vim.g.vimtex_syntax_conceal_disable = 1

        -- When working in a multi-file project, initiating inverse search (see
        -- |vimtex-synctex-inverse-search|) may require opening a file that is not
        -- currently open in a window. This option controls the command that is used to
        -- open files as a result of an inverse search.
        vim.g.vimtex_view_reverse_search_edit_cmd = 'edit'

        -- Focus the terminal after inverse search
        local group = vim.api.nvim_create_augroup('vimtex', { clear = true })
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VimtexEventViewReverse',
            group = group,
            command = 'call b:vimtex.viewer.xdo_focus_vim()',
        })

        local latex_symlink_group = vim.api.nvim_create_augroup('LatexSymlink', { clear = true })
        vim.api.nvim_create_autocmd('BufNewFile', {
            pattern = '*.tex',
            group = latex_symlink_group,
            callback = function()
                -- Path to your template file
                local template_path = vim.fn.expand('$HOME') .. '/dotfiles/latex/stylesheets/stylesheet.sty'
                local bib_path = vim.fn.expand('$HOME') .. '/dotfiles/latex/bibliographies/global_bib.bib'
                local working_dir = vim.fn.expand('%:p:h')
                local template_target_file = working_dir .. '/stylesheet.sty'
                local bib_target_file = working_dir .. '/global_bib.bib'

                if vim.fn.filereadable(template_path) == 1 and vim.loop.fs_stat(template_target_file) == nil then
                    vim.fn.system({ 'ln', '-sf', template_path, template_target_file })
                    require('notify')('Created symlink to stylesheet.')
                end

                if vim.fn.filereadable(bib_path) == 1 and vim.loop.fs_stat(bib_target_file) == nil then
                    vim.fn.system({ 'ln', '-sf', bib_path, bib_target_file })
                    require('notify')('Created symlink to bibliography.')
                end
            end,
        })

        -- Asign highlight groups to user defined latex commands
        vim.g.vimtex_syntax_custom_cmds = {
            {
                name = 'r_delim',
                cmdre = '\\C<r>',
                mathmode = 1,
                opt = 0,
                arg = 0,
                hlgroup = 'texMathDelim',
                nextgroup = 'texMathDelim',
            },
            {
                name = 'l_delim',
                cmdre = '\\C<l>',
                mathmode = 1,
                opt = 0,
                arg = 0,
                hlgroup = 'texMathDelim',
                nextgroup = 'texMathDelim',
            },
            { name = 'N', mathmode = 1, opt = 0, arg = 0, arggreedy = 0, hlgroup = 'texMathStyleBold' },
            { name = 'Z', mathmode = 1, opt = 0, arg = 0, arggreedy = 0, hlgroup = 'texMathStyleBold' },
            { name = 'Q', mathmode = 1, opt = 0, arg = 0, arggreedy = 0, hlgroup = 'texMathStyleBold' },
            { name = 'R', cmdre = '\\C<R>', mathmode = 1, opt = 0, arg = 0, arggreedy = 0, hlgroup = 'texMathStyleBold' },
            { name = 'C', mathmode = 1, opt = 0, arg = 0, arggreedy = 0, hlgroup = 'texMathStyleBold' },
            { name = 'F', mathmode = 1, opt = 0, arg = 0, arggreedy = 0, hlgroup = 'texMathStyleBold' },
            { name = 'mathrm', mathmode = 1, arg = 1, hlgroup = 'texMathCmdText' },
            { name = 'T', mathmode = 1, arg = 1, hlgroup = 'texMathCmdText' },
        }

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
    end,
}
