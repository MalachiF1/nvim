return {
    'folke/lazydev.nvim', -- lua_ls setup for editing the neovim config (replaces neodev.nvim)

    ft = 'lua',

    opts = {
        library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
    },
}
