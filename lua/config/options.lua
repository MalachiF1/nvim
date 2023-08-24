-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tabs and indtation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- line wraping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- cursor line
vim.opt.cursorline = true

-- appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- search highlighting
-- vim.opt.hlsearch = false
vim.opt.incsearch = true

-- backspace
vim.opt.backspace = "indent,eol,start"

-- clipboard
vim.api.nvim_set_option("clipboard", "unnamed")

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- `-` counts as part of word
vim.opt.iskeyword:append("-")

-- don't insert current comment leader automatically
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- alow mouse to be used in neovim
vim.opt.mouse = "a"

-- always keep 8 lines off edges unless at end or beggining of file
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- highlight text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
	end,
})

--don't show the mode (lualine will still show it)
vim.opt.showmode = false

-- get rid of `~` character on blank buffers
vim.opt.fillchars = { eob = " " }

-- make vim commands work when in hebrew
vim.opt.keymap = "hebrew"
vim.opt.iminsert = 0
vim.opt.imsearch = -1

-- disable backups, but let undotree remember lots of changes in a backup file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- shorter starup times
vim.loader.enable()

-- enable cursorline only on focused window
vim.cmd([[
    augroup CursorLine
        au!
        au VimEnter * setlocal cursorline
        au WinEnter * setlocal cursorline
        au BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
        au FileType TelescopePrompt* setlocal nocursorline " disable cursorline in Telescope Prompt
    augroup END
]])
