return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		{
			"rcarriga/nvim-notify",
			opts = {
				fps = 30,
				render = "compact", -- default, compact, minimal, simple
				stages = "fade", -- fade, fade_in_slide_out, slide, static
				timeout = 2000,
				top_down = true,
				level = 2,
				background_color = "#000000",
			},
		},
	},

	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},

				hover = {
					enabled = true,
					silent = true, -- set to true to not show a message if hover is not available
					view = "popup", -- when nil, use defaults from documentation
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI
				view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
			},
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			notify = {
				enabled = true,
				view = "notify",
			},
		})

		vim.keymap.set({ "n", "i", "s" }, "<C-f>", function()
			if not require("noice.lsp").scroll(4) then
				return "<C-f>"
			end
		end, { silent = true, expr = true })

		vim.keymap.set({ "n", "i", "s" }, "<C-b>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<C-b>"
			end
		end, { silent = true, expr = true })
	end,
}
