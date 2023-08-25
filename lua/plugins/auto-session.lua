return {
	"rmagatti/auto-session",

	event = "VimEnter",

	config = function()
		require("auto-session").setup({
			log_level = "error",
			auto_session_enable_last_session = false,
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			auto_session_enabled = true,
			auto_save_enabled = true,
			auto_restore_enabled = false,
			cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
				restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
				pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
				post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
			},

			session_lens = {
				-- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
				buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
				load_on_setup = false,
				theme_conf = { border = true },
				previewer = false,
			},
		})
	end,
}
