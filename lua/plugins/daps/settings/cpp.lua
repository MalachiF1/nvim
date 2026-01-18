local codelldb = {
    name = 'Launch codelldb',
    type = 'codelldb', -- matches the adapter
    request = 'launch', -- could also attach to a currently running process
    program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
}

require('dap').configurations.cpp = {
    codelldb, -- different debuggers or more configurations can be used here
}
require('dap').configurations.c = {
    codelldb, -- different debuggers or more configurations can be used here
}
