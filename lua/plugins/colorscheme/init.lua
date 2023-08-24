return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.colorscheme.tokyonight")
		end,
	},

	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.colorscheme.catppuccin")
		end,
	},
}
