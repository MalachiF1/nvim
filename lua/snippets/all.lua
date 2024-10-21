local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local r = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('all', {
    s(
        'qchem',
        fmt(
            [[
            $molecule
            {} {}

            $end

            $rem
                JOBTYPE {}
                METHOD  {}
                BASIS  {}
            $end
        ]],
            { i(1), i(2), i(3), i(4), i(0) }
        )
    ),
})
