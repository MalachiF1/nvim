local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs and indtation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wraping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'
opt.pumblend = 13 -- semi-transparency in popup windows like cmp l

-- show whitespace
opt.encoding = 'utf-8'
opt.list = true
opt.listchars = {
    tab = '│·', -- ——
    space = '·',
    trail = '·',
    extends = '❯', -- »
    precedes = '❮', -- «
}

-- get rid of `~` character on blank buffers
opt.fillchars = { eob = ' ' }

-- search highlighting
-- opt.hlsearch = false
opt.incsearch = true

-- backspace
opt.backspace = 'indent,eol,start'

-- clipboard
opt.clipboard = 'unnamedplus'

-- split windows
opt.splitright = true
opt.splitbelow = true

-- `-` counts as part of word
opt.iskeyword:append('-')

-- don't insert current comment leader automatically
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- allow mouse to be used in neovim
opt.mouse = 'a'

-- always keep 8 lines off edges unless at end or beginning of file
opt.scrolloff = 8
opt.signcolumn = 'yes'
opt.isfname:append('@-@')

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append('<>[]hl')

--don't show the mode (lualine will still show it)
opt.showmode = false

-- make vim commands work when in hebrew
opt.keymap = 'hebrew'
opt.iminsert = 0
opt.imsearch = -1

-- disable backups, but let undotree remember lots of changes in a backup file
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

-- updatetime affects stuff like cursorhold and some plugins
vim.opt.updatetime = 400

-- shorter startup times
vim.loader.enable()

-- Neovide
if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = 'FiraCode Nerd Font:h12, JetBrainsMono Nerd Font:h12, Hack Nerd Font:h12'
    vim.opt.linespace = 0.0
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_underline_automatic_scaling = true

    vim.g.neovide_theme = 'auto'
    vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_antialiasing = true

    vim.g.neovide_hide_mouse_when_typing = false
    vim.g.neovide_touch_deadzone = 6.0
    vim.g.neovide_touch_drag_timeout = 0.17
    vim.g.neovide_confirm_quit = true

    vim.g.neovide_scroll_animation_length = 0.15
    vim.g.neovide_cursor_animation_length = 0.15
    vim.g.neovide_cursor_trail_size = 0.01
    vim.g.neovide_cursor_unfocused_outline_width = 0.1
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
end
