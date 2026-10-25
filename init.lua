-- shorter startup times (must come before any other require)
vim.loader.enable()

require('config.options')
require('config.autocmds')
require('config.keymaps')
require('config.lazy')
require('config.colorscheme')
