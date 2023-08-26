return {
	-- amongst your other plugins
	"akinsho/toggleterm.nvim",

	version = "*",

	cmd = "ToggleTerm",

	init = function()
		vim.keymap.set(
			"n",
			"<leader>th",
			":ToggleTerm direction=horizontal<CR>",
			{ desc = "horizontal", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>tf",
			":ToggleTerm direction=float<CR>",
			{ desc = "float", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<leader>tv",
			":ToggleTerm direction=vertical<CR>",
			{ desc = "vertical", noremap = true, silent = true }
		)
	end,

	config = function()
		local toggleterm = require("toggleterm")
		toggleterm.setup({
			size = function(term)
				if term.direction == "horizontal" then
					local hight = math.ceil(vim.o.lines * 0.4)
					if hight >= 20 then
						return 20
					else
						return hight
					end

					return
				elseif term.direction == "vertical" then
					return math.ceil(vim.o.columns * 0.33)
				end
			end,
			persist_size = false,
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "single",
				-- like `size`, width and height can be a number or function which is passed the current terminal
				width = function()
					return math.ceil(vim.o.columns * 0.7)
				end,
				height = function()
					return math.ceil(vim.o.lines * 0.7)
				end,
				winblend = 3,
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
