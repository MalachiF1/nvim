return {
    'nvim-lualine/lualine.nvim',

    event = 'VeryLazy',

    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },

    config = function()
        -- get the colorscheme
        local colorscheme
        if vim.g.colors_name == 'tokyonight' then
            colorscheme = 'tokyonight'
        elseif vim.g.colors_name == 'catppuccin' then
            colorscheme = 'catppuccin'
        else
            colorscheme = 'auto'
        end

        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = colorscheme,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'alpha', 'dashboard' },
                    winbar = { 'alpha', 'dashboard' },
                },
                ignore_focus = {
                    -- "dapui_watches", "dapui_breakpoints",
                    -- "dapui_scopes", "dapui_console",
                    -- "dapui_stacks", "dap-repl" --dap-repl and not dap_repl -.-
                },
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {
                    { 'filetype' },
                    {
                        require('noice').api.status.search.get,
                        cond = require('noice').api.status.search.has,
                        color = { fg = '#ff9e64' },
                    },
                },

                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = { 'branch' },
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                'fzf',
                'toggleterm',
                'lazy',
                'nvim-dap-ui',
                'quickfix',
                'trouble',
            },
        })
    end,
}
