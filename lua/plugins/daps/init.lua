return {

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("plugins.daps.adapters.debugpy")
			require("plugins.daps.settings.python")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		ft = { "c", "cpp", "rust", "python" },
		cmd = { "DapToggleBreakpoint", "DapContinue" },
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
		},

		config = function()
			local dap = require("dap")

			require("plugins.daps.adapters.lldb")

			require("plugins.daps.settings.cpp")
			require("plugins.daps.settings.rust")

			require("nvim-dap-virtual-text").setup({})

			local dapui = require("dapui")
			dapui.setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = "",
					},
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>", "<C-[>" },
					},
				},
				force_buffers = true,
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.4,
							},
							{
								id = "watches",
								size = 0.3,
							},
							{
								id = "breakpoints",
								size = 0.3,
							},
						},
						size = 0.2,
						position = "right",
					},
					{
						elements = {
							{
								id = "repl",
								size = 0.5,
							},
							{
								id = "console",
								size = 0.5,
							},
						},
						size = 0.3,
						position = "bottom",
					},
				},
				mappings = {
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				render = {
					max_type_length = nil,
					max_value_lines = 100,
					indent = 1,
				},
				windows = { indent = 1 },
			})

			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

			-- keymaps --
			local keymap = vim.keymap.set
			-- Start debugging session
			keymap("n", "<leader>ds", function()
				dapui.toggle({})
				dap.continue()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
			end, { desc = "start" })
			-- Set breakpoints, get variable values, step into/out of functions, etc.
			keymap("n", "<leader>dl", require("dap.ui.widgets").hover, { desc = "get values" })
			keymap("n", "<leader>dc", dap.continue, { desc = "continue" })
			keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
			keymap("n", "<leader>dn", dap.step_over, { desc = "step over" })
			keymap("n", "<leader>di", dap.step_into, { desc = "step into" })
			keymap("n", "<leader>do", dap.step_out, { desc = "step out" })
			keymap("n", "<leader>dC", function()
				dap.clear_breakpoints()
			end, { desc = "clear breakpoints" })
			--  close debugger
			keymap("n", "<leader>de", function()
				dapui.toggle({})
				dap.terminate()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
			end, { desc = "close" })
		end,
	},
}
