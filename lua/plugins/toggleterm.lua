return {
	-- amongst your other plugins
	"akinsho/toggleterm.nvim",

	version = "*",

	cmd = "ToggleTerm",

	init = function()
		vim.keymap.set(
			"n",
			"<leader>th",
			":ToggleTerm size=15 direction=horizontal<CR>",
			{ desc = "horizontal", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>tf",
			":ToggleTerm size=15 direction=float<CR>",
			{ desc = "float", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>tv",
			":ToggleTerm size=50 direction=vertical<CR>",
			{ desc = "vertical", noremap = true, silent = true }
		)
	end,

	config = function()
		local toggleterm = require("toggleterm")
		toggleterm.setup({
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "curved",
				-- like `size`, width and height can be a number or function which is passed the current terminal
				winblend = 3,
			},
			highlights = {
				-- highlights which map to a highlight group name and a table of it's values
				-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
				-- Normal = {
				--     guibg = "<VALUE-HERE>",
				-- },
				-- NormalFloat = {
				--     link = 'Normal'
				-- },
				FloatBorder = {
					guifg = "#ffb454",
					-- guibg = "<VALUE-HERE>",
				},
			},
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
