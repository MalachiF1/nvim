return {
    'folke/tokyonight.nvim',

    lazy = true, -- set to false if this is the main theme
    -- priority = 1000,
    
    event = 'VeryLazy',

    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = 'night', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = 'day', -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = false },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = 'dark', -- style for sidebars, see below
            floats = 'transparent', -- style for floating windows
        },
        sidebars = { 'qf' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights hl
        ---@param colors c
        on_highlights = function(hl, c)
            local prompt = '#2d3149'
            hl.TelescopeNormal = {
                bg = c.bg,
                fg = c.fg,
            }
            hl.TelescopeBorder = {
                bg = c.bg,
                fg = c.bg,
            }
            hl.TelescopePromptNormal = {
                bg = prompt,
            }
            hl.TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
            }
            hl.TelescopePromptTitle = {
                bg = c.green1,
                fg = prompt,
            }
            hl.TelescopePreviewTitle = {
                bg = c.bg,
                fg = c.bg,
            }
            hl.TelescopeResultsTitle = {
                bg = c.bg,
                fg = c.bg,
            }
            hl.DapBreakpoint = {
                fg = c.red,
            }
            hl.BufferCurrentSign = {
                fg = c.blue,
            }
            hl.BufferCurrentSignRight = {
                fg = c.blue,
            }
            hl.DashboardHeader = {
                fg = c.magenta,
            }
            hl.FlashLabel = {
                fg = c.magenta2,
            }
            hl.FlashMatch = {
                fg = c.blue6,
            }
        end,
    },
}
