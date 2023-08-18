return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
    },

    config = function()
        local dap = require('dap')

        require("plugins.daps.adapters.lldb")

        require("plugins.daps.settings.cpp")
        require("plugins.daps.settings.rust")

        local dapui = require('dapui')
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
                    terminate = ""
                }
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
                            size = 0.5,
                        },
                        {
                            id = "watches",
                            size = 0.25,
                        },
                        {
                            id = "breakpoints",
                            size = 0.25,
                        },
                    },
                    size = 0.2,
                    position = "right"
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5
                        },
                        {
                            id = "console",
                            size = 0.5
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
                indent = 1
            },
            windows = { indent = 1 },
        })

        vim.fn.sign_define('DapBreakpoint', { text = '🔴' })

        -- keymaps --

        -- Start debugging session
        vim.keymap.set("n", "<leader>ds", function()
                dap.continue()
                dapui.toggle({})
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
            end,
            { desc = 'start' })

        -- Set breakpoints, get variable values, step into/out of functions, etc.
        vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover, { desc = 'get values' })
        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = 'continue' })
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = 'toggle breakpoint' })
        vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = 'step over' })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = 'step into' })
        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = 'step out' })
        vim.keymap.set("n", "<leader>dC", function()
            dap.clear_breakpoints()
        end, { desc = 'clear breakpoints' })

        -- Close debugger
        vim.keymap.set("n", "<leader>de", function()
            dapui.toggle({})
            dap.terminate()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
        end, { desc = 'close' })
    end
}
