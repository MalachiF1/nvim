return {
	"nvim-treesitter/nvim-treesitter",

	event = "BufReadPre",

	dependencies = {
		"nvim-treesitter/playground",
	},

	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

			ensure_installed = {
				"javascript",
				"lua",
				"c",
				"cpp",
				"rust",
				"typescript",
				"tsx",
				"json",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"vim",
				"gitignore",
				"latex",
				"scss",
				"regex",
				"sql",
				"bash",
				"toml",
				"yaml",
				"python",
				"regex",
				"comment",
				"vim",
			},

			sync_install = false,
			auto_install = true,
		})

		-- fix some highlighting issues

		-- cpp
		-- vim.api.nvim_set_hl(0, "@type.qualifier.cpp", { link = "Keyword" })
		-- vim.api.nvim_set_hl(0, "@function.builtin.cpp", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@type.builtin.cpp", { link = "Type" })
		-- vim.api.nvim_set_hl(0, "@lsp.typemod.class.constructorOrDestructor.cpp", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.cpp", { link = "Variable" })
		-- vim.api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.cpp", { link = "Variable" })

		-- lua
		-- vim.api.nvim_set_hl(0, "@function.builtin.lua", { link = "Function" })
		-- vim.api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.lua", { link = "Function" })
	end,
}
