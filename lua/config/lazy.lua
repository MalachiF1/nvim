-- install lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup('plugins', {
    defaults = {
        lazy = true,
    },
    install = {
        install = true,
        -- colorscheme = { 'tokyonight' },
        colorscheme = { 'catppuccin' },
    },
    change_detection = {
        notify = false,
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                'tohtml',
                'tutor',
                'netrwPlugin',
                'netrwSettings',
                'netrwFileHandlers',
                'gzip',
                'zip',
                'zipPlugin',
                'tar',
                'tarPlugin',
                'getscript',
                'getscriptPlugin',
                'vimball',
                'vimballPlugin',
                '2html_plugin',
                'logipat',
                'rrhelper',
                'spellfile_plugin',
                'matchit',
            },
        },
        readme = {
            enabled = true,
            root = vim.fn.stdpath('state') .. '/lazy/readme',
            files = { 'README.md', 'lua/**/README.md' },
            -- only generate markdown helptags for plugins that dont have docs
            skip_if_doc_exists = true,
        },
        profiling = {
            -- Enables extra stats on the debug tab related to the loader cache.
            -- Additionally gathers stats about all package.loaders
            loader = false,
            -- Track each new require in the Lazy profiling tab
            require = false,
        },
    },
})
