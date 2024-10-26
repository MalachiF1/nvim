local conditions = require('snippets.conditions')

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
        <>
        \end{equation}
        ]],
            { i(0) }
        )
    ),

    s(
        { trig = '//', name = 'frac', snippetType = 'autosnippet', priority = 10000000000 },
        fmta(
            [[
            \f{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = conditions.math_mode }
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
        fmtaa(
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
        fmtaa(
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
        fmtaa(
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
        fmtaa(
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
        { trig = '([%w%)%}%]])_(%w+) ', regTrig = true, name = 'subscript', snippetType = 'autosnippet' },
        f(function(_, snip) return snip.captures[1] .. '_{' .. snip.captures[2] .. '} ' end, {}),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = '([%w%)%}%]])^(%w+) ', regTrig = true, name = 'subscript', snippetType = 'autosnippet' },
        f(function(_, snip) return snip.captures[1] .. '^{' .. snip.captures[2] .. '} ' end, {}),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = 'pd', name = 'partial derivative', snippetType = 'autosnippet', priority = 10000000000 },
        fmta(
            [[
            \pd{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = 'dr', name = 'partial derivative', snippetType = 'autosnippet', priority = 10000000000 },
        fmta(
            [[
            \dr{<>}{<>}<>
        ]],
            { i(1), i(2), i(0) }
        ),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = 'vec', name = 'vector', snippetType = 'autosnippet' },
        fmta(
            [[
            \nvec{<>}<>
        ]],
            { d(1, get_visual), i(0) }
        ),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = 'uvec', name = 'unit vector', snippetType = 'autosnippet' },
        fmta(
            [[
            \uvec{<>}<>
        ]],
            { d(1, get_visual), i(0) }
        ),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = 'matr', name = 'matrix', priority = 10000 },
        fmta(
            [[
            \matr{<>}<>
        ]],
            { i(1, 'a & b \\\\ c & d'), i(0) }
        ),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = 'detr', name = 'determinant' },
        fmta(
            [[
            \detr{<>}<>
        ]],
            { i(1, 'a & b \\\\ c & d'), i(0) }
        ),
        { condition = conditions.math_mode }
    ),

    s(
        { trig = '(', name = 'parentheses', snippetType = 'autosnippet' },
        fmta(
            [[
            \left(<>\right)<>
        ]],
            { i(1), i(0) }
        ),
        { condition = conditions.math_mode }
    ),
}
