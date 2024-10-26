return {
    'kevinhwang91/nvim-ufo',

    dependencies = {
        'kevinhwang91/promise-async',
        'nvim-treesitter/nvim-treesitter',
    },

    event = 'BufReadPost', -- later will not save folds

    keys = {
        {
            '<leader>fo',
            'zo',
            mode = 'n',
            desc = 'open',
            noremap = true,
            silent = true,
        },
        {
            '<leader>fc',
            'zc',
            mode = 'n',
            desc = 'close',
            noremap = true,
            silent = true,
        },
        {
            '<leader>fO',
            ':lua require("ufo").openAllFolds()<CR>',
            mode = 'n',
            desc = 'open all',
            noremap = true,
            silent = true,
        },
        {
            '<leader>fC',
            ':lua require("ufo").closeAllFolds()<CR>',
            mode = 'n',
            desc = 'close all',
            noremap = true,
            silent = true,
        },
        {
            '<leader>fp',
            function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then vim.lsp.buf.hover() end
            end,
            mode = 'n',
            desc = 'peek',
            noremap = true,
            silent = true,
        },
        -- map("n", "zr", ufo.openFoldsExceptKinds)
        -- map("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    },

    init = function()
        -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
        -- auto-closing them after leaving insert mode, however ufo does not seem to
        -- have equivalents for zr and zm because there is no saved fold level.
        -- Consequently, the vim-internal fold levels need to be disabled by setting
        -- them to 99
        vim.opt.foldcolumn = '0'
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true
    end,

    config = function()
        -- Adding number suffix of folded lines instead of the default ellipsis:
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth) end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end

        require('ufo').setup({
            provider_selector = function(_, ft, _)
                local lsp_without_folding = { 'markdown', 'quarto', 'bash', 'sh', 'bash', 'zsh', 'css' }
                if vim.tbl_contains(lsp_without_folding, ft) then
                    return { 'treesitter', 'indent' }
                elseif ft == 'html' then
                    return { 'indent' } -- lsp & treesitter do not provide folds
                else
                    return { 'lsp', 'indent' }
                end
            end,
            open_fold_hl_timeout = 150,
            fold_virt_text_handler = handler,
            preview = {
                win_config = {
                    border = { '', '─', '', '', '', '─', '', '' },
                    winhighlight = 'Normal:Folded',
                    winblend = 0,
                },
                mappings = {
                    scrollU = '<C-k>',
                    scrollD = '<C-j>',
                    jumpTop = '<C-u>',
                    jumpBot = '<C-d>',
                },
            },
        })
    end,
}
