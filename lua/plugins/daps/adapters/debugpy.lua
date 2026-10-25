-- use mason's debugpy venv, `python` on PATH may be a conda env without debugpy
require('dap-python').setup(vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python')
