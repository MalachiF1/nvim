local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local r = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('tex', {
    s(
        'eq',
        fmt(
            [[
        \begin{{equation}}
            \begin{{aligned}}
               {} 
            \end{{aligned}}
        \end{{equation}}
        ]],
            { i(0) }
        )
    ),

    s(
        'em',
        fmt(
            [[
            \emph{{ {} }}
        ]],
            { i(0) }
        )
    ),

    s(
        'homework',
        fmt(
            [[
        \documentclass[letterpaper, 12pt]{{article}}
        \usepackage{{$HOME/latex/stylesheets/homework}}

        \author{{Malachi Fraenkel}}
        \course{{{}}}
        \hwtype{{{}}}
        \hwnumber{{{}}}

        \begin{{document}}

        % \begin{{problem}}{{Title}}
        % {{problem-label}}
        % This is a problem statement
        % \end{{problem}}

        {}

        \printbibliography

        \end{{document}}
        ]],
            { i(1), i(2), i(3), i(0) }
        )
    ),

    s(
        'lab',
        fmt(
            [[
        \documentclass[letterpaper, 11pt]{{article}}
        \usepackage{{$HOME/latex/stylesheets/lab}}

        \author{{Malachi Fraenkel}}
        \title{{{}}}
        \date{{\today}}

        \begin{{document}}

        \maketitle

        \begin{{abstract}}
        \end{{abstract}}

        \begin{{multicols*}}{{2}}

            \section{{Introduction}}
            {}

            \printbibliography

        \end{{multicols*}}

        \end{{document}}
        ]],
            { i(1), i(0) }
        )
    ),
})
