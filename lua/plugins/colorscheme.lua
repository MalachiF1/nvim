return {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            no_underline = false, -- Force no underline
            styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
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
            color_overrides = {
                mocha = {
                    rosewater = "#ff8f40",
                    flamingo = "#bfbdb6",
                    pink = "#ffb454",
                    mauve = "#ff8f40",
                    red = "#e6b673",
                    maroon = "#d2a6ff",
                    peach = "#ffee99",
                    yellow = "#59c2ff",
                    teal = "#d2a6ff",
                    green = "#aad94c",
                    sky = "#f29668",
                    sapphire = "#ffb454",
                    blue = "#ffb454",
                    lavender = "#59c2ff",
                    text = "#bfbdb6",
                    subtext1 = "#e6b673",
                    subtext0 = "#e6b67e",
                    overlay2 = "#bfbdb6",
                    overlay1 = "#d95757",
                    overlay0 = "#3b4149",
                    surface2 = "#11151c",
                    surface1 = "#1e222a",
                    surface0 = "#11151c",
                    base = "#0b0e14",
                    mantle = "#11151c",
                },
            },
            custom_highlights = function(colors)
                return {
                    CursorLineNr = { fg = colors.blue },
                    IncSearch = { bg = colors.teal },

                    DiagnosticError = { fg = colors.overlay1 },
                    DiagnosticVirtualTextError = { fg = colors.overlay1, bg = colors.surface2 },
                    DiagnosticFloatingError = { fg = colors.overlay1 },
                    DiagnosticSignError = { fg = colors.overlay1 },
                    LspDiagnosticsError = { fg = colors.overlay1 },
                    LspDiagnosticsUnderlineError = { fg = colors.overlay1 },
                    LspDiagnosticsDefaultError = { fg = colors.overlay1 },

                    DiagnosticWarn = { fg = colors.sky },
                    DiagnosticVirtualTextWarn = { fg = colors.sky, bg = colors.surface2 },
                    DiagnosticFloatingWarn = { fg = colors.sky },
                    DiagnosticSignWarn = { fg = colors.sky },
                    LspDiagnosticsWarn = { fg = colors.sky },
                    LspDiagnosticsUnderlineWarn = { fg = colors.sky },

                    DiagnosticHint = { fg = colors.teal },
                    DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.surface2 },
                    DiagnosticFloatingHint = { fg = colors.teal },
                    DiagnosticSignHint = { fg = colors.teal },
                    LspDiagnosticsHint = { fg = colors.teal },
                    LspDiagnosticsUnderlineHint = { fg = colors.teal },

                    GitSignsDelete = { fg = colors.overlay1 },
                    GitSignsDeleteNr = { fg = colors.overlay1 },
                    GitSignsDeletePreview = { fg = colors.overlay1, bg = colors.surface2 },
                    GitSignsStagedChangeLn = { fg = colors.overlay1, bg = colors.surface2 },
                    GitSignsDeleteVirtLn = { fg = colors.overlay1, bg = colors.surface2 },
                    GitSignsChangeLn = { fg = colors.yellow, bg = colors.surface2 },

                    NeogitDiffAdd = { fg = colors.green, bg = colors.surface2 },
                    NeogitDiffAddHighlight = { fg = colors.green, bg = colors.surface2 },
                    NeogitDiffDelete = { fg = colors.overlay1, bg = colors.surface2 },
                    NeogitDiffDeleteHighlight = { fg = colors.overlay1, bg = colors.surface2 },
                    NeogitHunkHeader = { bg = colors.surface1 },
                    NeogitHunkHeaderHighlight = { fg = colors.surface2, bg = colors.red },
                    NeogitCommitViewHeader = { fg = colors.surface2, bg = colors.red },

                    Pmenu = { fg = colors.teal },
                    PmenuSel = { fg = colors.blue },

                    diffremoved = { fg = colors.overlay1, bg = colors.surface2 },
                    diffRemoved = { fg = colors.overlay1, bg = colors.surface2 },
                    diffadded = { fg = colors.green, bg = colors.surface2 },
                    diffAdded = { fg = colors.green, bg = colors.surface2 },
                    diffchanged = { fg = colors.yellow, bg = colors.surface2 },
                    diffChanged = { fg = colors.yellow, bg = colors.surface2 },
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                dap = {
                    enabled = true,
                    enable_ui = true,
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                rainbow_delimiters = true,
                telescope = true,
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },

        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end
}
