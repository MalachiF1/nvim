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

-- alow mouse to be used in neovim
opt.mouse = 'a'

-- always keep 8 lines off edges unless at end or beggining of file
opt.scrolloff = 8
opt.signcolumn = 'yes'
opt.isfname:append('@-@')

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

-- shorter starup times
vim.loader.enable()

-- when running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up
-- opt.lazyredraw = true
