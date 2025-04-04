local in_mathzone = function()
    -- The `in_mathzone` function requires the VimTeX plugin
    return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

return {
    s(
        'eq',
        fmta(
            [[
        \begin{equation}
            \begin{aligned}
                <>
            \end{aligned}
        \end{equation}
        ]],
            { i(0) }
        )
    ),

    s(
        'homework',
        fmta(
            [[
        \documentclass[letterpaper, 12pt]{article}
        \usepackage{$HOME/latex/stylesheets/homework}

        \author{Malachi Fraenkel}
        \course{<>}
        \hwtype{<>}
        \hwnumber{<>}

        \begin{document}

        % \begin{problem}{Title}
        % {problem-label}
        % This is a problem statement
        % \end{problem}

        <>

        \printbibliography

        \end{document}
        ]],
            { i(1), i(2), i(3), i(0) }
        )
    ),

    s(
        { trig = 'lab', name = 'Lab Report Format', desc = 'minimal boilerplate for latex lab report format' },
        fmta(
            [[
        \documentclass[letterpaper, 11pt]{article}
        \usepackage{$HOME/latex/stylesheets/lab}

        \author{Malachi Fraenkel}
        \title{<>}
        \date{\today}

        \begin{document}

        \maketitle

        \begin{abstract}
        \end{abstract}

        \begin{multicols*}{2}

            \section{Introduction}
            <>

            \printbibliography

        \end{multicols*}

        \end{document}
        ]],
            { i(1), i(0) }
        )
    ),

    s(
        { trig = 'href', name = 'href', snippetType = 'autosnippet' },
        fmta(
            [[
            \href{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        )
    ),

    s(
        { trig = 'tbf', dscr = 'place selected text in bold' },
        fmta(
            [[
            \textbf{<>}<>
        ]],
            { d(1, get_visual), i(0) }
        )
    ),

    s(
        { trig = 'emph', dscr = 'place selected text in emph' },
        fmta(
            [[
            \emph{<>}<>
        ]],
            { d(1, get_visual), i(0) }
        )
    ),

    s(
        { trig = '//', name = 'fraction', snippetType = 'autosnippet', priority = 10000000000 },
        fmta(
            [[
            \f{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        {
            -- Only triggers for parentheses (up to 3 levels deep)
            trig = '(?:\\\\left)?\\(([^()]+[^\\\\right]|(?:[^()]*\\(?(?:[^()]*\\([^()]*\\)[^()]*)+\\)?[^()]*)+[^\\\\right])(?:\\\\right)?\\)\\/',
            regTrig = true,
            trigEngine = 'ecma',
            name = 'fraction',
            snippetType = 'autosnippet',
            priority = 999999999999,
        },
        fmta(
            [[
            \f{<>}{<>}<>
        ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
                i(0),
            }
        ),
        { condition = in_mathzone }
    ),

    s(
        {
            -- lower priority than the previous one, for no parentheses (exclusion is by priority, not explicit).
            trig = '([^\\s]+)\\/',
            regTrig = true,
            trigEngine = 'ecma',
            name = 'fraction',
            snippetType = 'autosnippet',
            priority = 899999999999,
        },
        fmta(
            [[
            \f{<>}{<>}<>
        ]],
            {
                f(function(_, snip) return snip.captures[1] end),
                i(1),
                i(0),
            }
        ),
        { condition = in_mathzone }
    ),

    s(
        {
            trig = '()/',
            name = 'fraction',
            snippetType = 'autosnippet',
            priority = 999999999999,
        },
        fmta(
            [[
            \f{<>}{<>}<>
        ]],
            {
                i(1),
                i(2),
                i(0),
            }
        ),
        { condition = in_mathzone }
    ),

    s(
        {
            trig = '\\left(\\right)/',
            name = 'fraction',
            snippetType = 'autosnippet',
            priority = 999999999999,
        },
        fmta(
            [[
            \f{<>}{<>}<>
        ]],
            {
                i(1),
                i(2),
                i(0),
            }
        ),
        { condition = in_mathzone }
    ),

    s(
        {
            trig = 'and',
            name = 'and symbol',
            snippetType = 'autosnippet',
        },
        fmta(
            [[
            \,\wedge\, <>
        ]],
            {
                i(0),
            }
        ),
        { condition = in_mathzone }
    ),

    s(
        {
            trig = 'or',
            name = 'or symbol',
            snippetType = 'autosnippet',
        },
        fmta(
            [[
            \,\vee\, <>
        ]],
            {
                i(0),
            }
        ),
        { condition = in_mathzone }
    ),

    -- s(
    --     { trig = '(^.*\\))/', regTrig = true, trigEngine = 'ecma', name = 'fraction', snippetType = 'autosnippet', priority = 10000000000 },
    --     fmta(
    --         [[
    --         \f{<>}{<>}<>
    --     ]],
    --         { f(function(_, snip) return snip.captures[1] end), i(1), i(0) },
    --     ),
    --     { condition = in_mathzone }
    -- ),

    s(
        { trig = '([%w%)%}%]])_(%w+) ', regTrig = true, name = 'subscript', snippetType = 'autosnippet' },
        f(function(_, snip) return snip.captures[1] .. '_{' .. snip.captures[2] .. '} ' end, {}),
        { condition = in_mathzone }
    ),

    s(
        { trig = '([%w%)%}%]])^(%w+) ', regTrig = true, name = 'subscript', snippetType = 'autosnippet' },
        f(function(_, snip) return snip.captures[1] .. '^{' .. snip.captures[2] .. '} ' end, {}),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'pd', name = 'partial derivative', snippetType = 'autosnippet', priority = 10000000000 },
        fmta(
            [[
            \pd{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'dr', name = 'partial derivative', snippetType = 'autosnippet', priority = 10000000000 },
        fmta(
            [[
            \dr{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'vec', name = 'vector', snippetType = 'autosnippet' },
        fmta(
            [[
            \nvec{<>}<>
        ]],
            { d(1, get_visual), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'uvec', name = 'unit vector', snippetType = 'autosnippet' },
        fmta(
            [[
            \uvec{<>}<>
        ]],
            { d(1, get_visual), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'matr', name = 'matrix', priority = 10000 },
        fmta(
            [[
            \matr{<>}<>
        ]],
            { i(1, 'a & b \\\\ c & d'), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'detr', name = 'determinant' },
        fmta(
            [[
            \detr{<>}<>
        ]],
            { i(1, 'a & b \\\\ c & d'), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = '(', name = 'parentheses', snippetType = 'autosnippet' },
        fmta(
            [[
            \left(<>\right)<>
        ]],
            { i(1), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'lim', name = 'limit', snippetType = 'autosnippet', priority = 10000 },
        fmta(
            [[
            \lim_{<> \to <>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = in_mathzone }
    ),

    s(
        { trig = 'inf', name = 'infinity', snippetType = 'autosnippet', priority = 10000 },
        fmta(
            [[
            \infty <>
        ]],
            { i(0) }
        ),
        { condition = in_mathzone }
    ),
}
