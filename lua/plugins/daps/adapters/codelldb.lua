-- codelldb installed by mason (see plugins/lsp/mason.lua)
require('dap').adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
    },
}
