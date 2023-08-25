return {
	"glepnir/dashboard-nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	event = "VimEnter",

	config = function()
		local dashboard = require("dashboard")
		local ascii = require("plugins.dashboard.banner").random_ascii
		local handle = io.popen("fortune")
		local fortune = handle:read("*a")
		handle:close()

		dashboard.setup({
			theme = "doom",
			config = {
				header = ascii,
				center = {
					{
						icon = "   ",
						icon_hl = "Title",
						desc = "New file",
						desc_hl = "String",
						key = "e",
						-- keymap = "e",
						key_hl = "Number",
						action = "ene | startinsert",
					},
					{
						icon = "󰱼   ",
						icon_hl = "Title",
						desc = "Find file",
						desc_hl = "String",
						key = "f",
						-- keymap = "",
						key_hl = "Number",
						action = "Telescope find_files",
					},
					{
						icon = "󰈢   ",
						icon_hl = "Title",
						desc = "Recent files",
						desc_hl = "String",
						-- keymap = "r",
						key = "r",
						key_hl = "Number",
						action = "Telescope oldfiles",
					},
					{
						icon = "󰈬   ",
						icon_hl = "Title",
						desc = "Grep string",
						desc_hl = "String",
						key = "g",
						-- keymap = "g",
						key_hl = "Number",
						action = "Telescope grep_string",
					},
					{
						icon = "   ",
						icon_hl = "Title",
						desc = "Last session",
						desc_hl = "String",
						key = "s",
						-- keymap = "s",
						key_hl = "Number",
						action = "SessionRestore",
					},
					{
						icon = "   ",
						icon_hl = "Title",
						desc = "NVIM configuration",
						desc_hl = "String",
						key = "c",
						-- keymap = "c",
						key_hl = "Number",
						action = "edit ~/.config/nvim/init.lua",
					},
					{
						icon = "   ",
						icon_hl = "Title",
						desc = "Update plugins",
						desc_hl = "String",
						key = "u",
						-- keymap = "u",
						key_hl = "Number",
						action = "Lazy update",
					},
					{
						icon = "󰗼   ",
						icon_hl = "Title",
						desc = "Quit NVIM",
						desc_hl = "String",
						key = "q",
						-- keymap = "q",
						key_hl = "Number",
						action = "qa",
					},
				},
				footer = fortune,
			},
		})
	end,
}
