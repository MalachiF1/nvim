return {
    'catppuccin/nvim',

    lazy = false,

    priority = 1000,

    config = function()
        require('catppuccin').setup({
            flavour = 'machiato', -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = 'latte',
                dark = 'mocha',
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = 'dark',
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { 'italic' }, -- Change the style of comments
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            -- color_overrides = {
            --     mocha = {
            --         rosewater = '#ff8f40',
            --         flamingo = '#bfbdb6',
            --         pink = '#ffb454',
            --         mauve = '#ff8f40',
            --         red = '#e6b673',
            --         maroon = '#d2a6ff',
            --         peach = '#ffee99',
            --         yellow = '#59c2ff',
            --         teal = '#d2a6ff',
            --         green = '#aad94c',
            --         sky = '#f29668',
            --         sapphire = '#ffb454',
            --         blue = '#ffb454',
            --         lavender = '#59c2ff',
            --         text = '#bfbdb6',
            --         subtext1 = '#e6b673',
            --         subtext0 = '#e6b67e',
            --         overlay2 = '#626875',
            --         overlay1 = '#d95757',
            --         overlay0 = '#3b4149',
            --         surface2 = '#11151c',
            --         surface1 = '#1e222a',
            --         surface0 = '#11151c',
            --         base = '#0b0e14',
            --         mantle = '#11151c',
            --     },
            -- },
            custom_highlights = function(colors)
                return {
                    -- Type = { fg = colors.mauve },
                    -- Variable = { fg = colors.text },

                    -- CursorLineNr = { fg = colors.blue },
                    -- IncSearch = { bg = colors.teal },

                    -- DiagnosticError = { fg = colors.overlay1 },
                    -- DiagnosticVirtualTextError = { fg = colors.overlay1, bg = colors.surface2 },
                    -- DiagnosticFloatingError = { fg = colors.overlay1 },
                    -- DiagnosticSignError = { fg = colors.overlay1 },
                    -- LspDiagnosticsError = { fg = colors.overlay1 },
                    -- LspDiagnosticsUnderlineError = { fg = colors.overlay1 },
                    -- LspDiagnosticsDefaultError = { fg = colors.overlay1 },
                    --
                    -- DiagnosticWarn = { fg = colors.sky },
                    -- DiagnosticVirtualTextWarn = { fg = colors.sky, bg = colors.surface2 },
                    -- DiagnosticFloatingWarn = { fg = colors.sky },
                    -- DiagnosticSignWarn = { fg = colors.sky },
                    -- LspDiagnosticsWarn = { fg = colors.sky },
                    -- LspDiagnosticsUnderlineWarn = { fg = colors.sky },
                    --
                    -- DiagnosticHint = { fg = colors.teal },
                    -- DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.surface2 },
                    -- DiagnosticFloatingHint = { fg = colors.teal },
                    -- DiagnosticSignHint = { fg = colors.teal },
                    -- LspDiagnosticsHint = { fg = colors.teal },
                    -- LspDiagnosticsUnderlineHint = { fg = colors.teal },
                    --
                    -- diffremoved = { fg = colors.overlay1, bg = colors.surface2 },
                    -- diffRemoved = { fg = colors.overlay1, bg = colors.surface2 },
                    -- diffadded = { fg = colors.green, bg = colors.surface2 },
                    -- diffAdded = { fg = colors.green, bg = colors.surface2 },
                    -- diffchanged = { fg = colors.lavender, bg = colors.surface2 },
                    -- diffChanged = { fg = colors.lavender, bg = colors.surface2 },
                    --
                    -- GitSignsDelete = { fg = colors.overlay1 },
                    -- GitSignsDeleteNr = { fg = colors.overlay1 },
                    -- GitSignsDeletePreview = { fg = colors.overlay1, bg = colors.surface2 },
                    -- GitSignsStagedChangeLn = { fg = colors.overlay1, bg = colors.surface2 },
                    -- GitSignsDeleteVirtLn = { fg = colors.overlay1, bg = colors.surface2 },
                    -- GitSignsChangeLn = { fg = colors.lavender, bg = colors.surface2 },

                    -- NeogitDiffAdd = { fg = colors.green, bg = colors.surface2 },
                    -- NeogitDiffAddHighlight = { fg = colors.green, bg = colors.surface2 },
                    -- NeogitDiffDelete = { fg = colors.overlay1, bg = colors.surface2 },
                    -- NeogitDiffDeleteHighlight = { fg = colors.overlay1, bg = colors.surface2 },
                    -- NeogitHunkHeader = { bg = colors.surface1 },
                    -- NeogitHunkHeaderHighlight = { fg = colors.surface2, bg = colors.red },
                    -- NeogitCommitViewHeader = { fg = colors.surface2, bg = colors.red },

                    -- Pmenu = { fg = colors.teal },
                    -- PmenuSel = { fg = colors.surface1, bg = colors.teal, style = { 'bold' } },
                    -- CmpItemAbbrMatch = { fg = colors.teal },
                    -- CmpItemAbbrMatchFuzzy = { fg = colors.teal },

                    DapBreakpoint = { fg = colors.red },

                    -- NoiceCmdlineIcon = { style = { 'bold' } },
                    -- NotifyERRORTitle = { fg = colors.overlay1 },
                    -- NotifyERRORBorder = { fg = colors.overlay1 },
                    -- NotifyERRORIcon = { fg = colors.overlay1 },
                    -- NotifyWARNTitle = { fg = colors.sky },
                    -- NotifyWARNBorder = { fg = colors.sky },
                    -- NotifyWARNIcon = { fg = colors.sky },
                    -- NotifyINFOTitle = { fg = colors.yellow },
                    -- NotifyINFOBorder = { fg = colors.yellow },
                    -- NotifyINFOIcon = { fg = colors.yellow },
                    -- NotifyTRACETitle = { fg = colors.teal },
                    -- NotifyTRACEBorder = { fg = colors.teal },
                    -- NotifyTRACEInfo = { fg = colors.teal },
                    -- NotifyDEBUGTitle = { fg = colors.teal },
                    -- NotifyDEBUGBorder = { fg = colors.teal },
                    -- NotifyDEBUGInfo = { fg = colors.teal },

                    -- TelescopePromptPrefix = { fg = colors.teal, bg = colors.teal },
                    TelescopePromptNormal = { bg = colors.surface1 },
                    TelescopePromptBorder = { bg = colors.surface1, fg = colors.surface1 },
                    TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
                    TelescopeResultsNormal = { bg = colors.mantle },
                    TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
                    TelescopeResultsTitle = { fg = colors.mantle },
                    TelescopePreviewNormal = { bg = colors.mantle },
                    TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
                    TelescopePreviewTitle = { bg = colors.mantle, fg = colors.mantle },
                    TelescopeSelectionCaret = { fg = colors.teal, bg = colors.surface1 },
                    TelescopeNormal = { bg = colors.surface1 },
                    TelescopeBorder = { bg = colors.surface1, fg = colors.surface1 },

                    BufferCurrent = { bg = colors.base },
                    BufferCurrentSign = { bg = colors.base },
                    BufferCurrentMod = { bg = colors.base },
                    BufferCurrentSignRight = { fg = colors.base, bg = colors.base },
                    BufferCurrentTarget = { bg = colors.base },

                    BufferInactive = { bg = colors.mantle },
                    BufferInactiveSign = { bg = colors.mantle },
                    BufferInactiveMod = { bg = colors.mantle },
                    BufferInactiveError = { fg = colors.pink, bg = colors.mantle },
                    BufferInactiveWarn = { fg = colors.flamingo, bg = colors.mantle },
                    BufferInactiveHint = { fg = colors.lavender, bg = colors.mantle },
                    BufferInactiveINFO = { fg = colors.lavender, bg = colors.mantle },
                    BufferInactiveTarget = { bg = colors.mantle },

                    DashboardHeader = { fg = colors.teal },

                    FlashLabel = { fg = colors.rosewater },
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                treesitter = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { 'italic' },
                        hints = { 'italic' },
                        warnings = { 'italic' },
                        information = { 'italic' },
                    },
                    underlines = {
                        errors = { 'underline' },
                        hints = { 'underline' },
                        warnings = { 'underline' },
                        information = { 'underline' },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                rainbow_delimiters = true,
                telescope = true,
                mason = true,
                neogit = true,
                illuminate = true,
                noice = true,
                notify = true,
                barbar = true,
                dashboard = true,
                diffview = true,
                flash = true,
                indent_blankline = {
                    enabled = true,
                    -- scope_color = 'lavender',
                    color_indent_levels = true,
                },
                dap = true,
                dap_ui = true,
                nvim_surround = true,
                ufo = true,
                lsp_trouble = true,
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        })
    end,
}
