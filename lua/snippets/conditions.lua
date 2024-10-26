-- This module contains functions to check if the cursor is in a particular environment
local M = {}

-- Get the current line number and column
local function get_cursor_pos()
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- vim API returns 0-based column, so we need to add 1 to column
    return cursor[1], cursor[2] + 1
end

-- Get the range of visible rows
local function get_visible_rows(current_row)
    -- Get the height of the current window
    local win_height = vim.api.nvim_win_get_height(0)

    -- Calculate the first and last visible rows
    local first_visible_row = math.max(1, current_row - math.floor(win_height / 2))
    local last_visible_row = math.min(vim.api.nvim_buf_line_count(0), current_row + math.ceil(win_height / 2))

    return first_visible_row, last_visible_row
end

-- Search for start and end patterns around the cursor
local function search_pair(env_name, current_row)
    -- Get the first and last visible rows
    local first_visible_row, last_visible_row = get_visible_rows(current_row)

    -- Define the start and end patterns
    local start_patterns = {
        '\\begin{' .. env_name .. '}',
        '\\start' .. env_name,
    }
    local end_patterns = {
        '\\end{' .. env_name .. '}',
        '\\stop' .. env_name,
    }

    local start_pos, end_pos = nil, nil

    -- Function to search a list of patterns in a specified range and direction
    local function search_patterns(patterns, from, to, step)
        for line_num = from, to, step do
            local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
            for _, pattern in ipairs(patterns) do
                if line:find(pattern) then return line_num end
            end
        end
        return nil
    end

    -- Search upwards for the start pattern in the visible range
    start_pos = search_patterns(start_patterns, current_row, first_visible_row, -1)
    -- If the start pattern not found in the visible range, then search further up
    if not start_pos then start_pos = search_patterns(start_patterns, current_row, 1, -1) end

    -- Search downwards for the end pattern in the visible range
    end_pos = search_patterns(end_patterns, current_row, last_visible_row, 1)
    -- If the end pattern not found, then search further down
    if not end_pos then end_pos = search_patterns(end_patterns, current_row, vim.api.nvim_buf_line_count(0), 1) end

    return start_pos, end_pos
end

-- Check if the cursor is inside a given environment
local function in_env(env_name)
    local current_row, _ = get_cursor_pos()
    local start_pos, end_pos = search_pair(env_name, current_row)

    if start_pos and end_pos then return current_row >= start_pos and current_row <= end_pos end
    return false
end

-- Function to identify math zones in a line
local function find_math_zones(line)
    local math_patterns = {
        '%$%$.+%$%$', -- $$...$$
        '\\\\%[.+\\\\%]', -- \[...\]
        '\\\\%(.+\\\\%)', -- \( ... \)
        '%$[^$]+%$', -- inline math $...$
    }
    local math_zones = {}
    for _, pattern in ipairs(math_patterns) do
        local s, e = 1, 1
        while s do
            s, e = string.find(line, pattern, e)
            if s then
                table.insert(math_zones, { start = s, stop = e })
                e = e + 1
            end
        end
    end
    return math_zones -- = { { start = 1, stop = 16 }, { start = 18, stop = 33 }, ... }
end

-- Check if the cursor is inside a math zone
function M.is_mathzone()
    -- Get the cursor position
    local current_row, current_col = get_cursor_pos()

    -- Get the content of the current line
    local line = vim.api.nvim_buf_get_lines(0, current_row - 1, current_row, false)[1]

    -- Find the math zones in the line
    local math_zones = find_math_zones(line)

    for _, zone in ipairs(math_zones) do
        -- Check if the cursor is inside a math zone
        if current_col >= zone.start and current_col <= zone.stop then return true end
    end

    return false
end

-- Specific environment checks
M.in_text = function() return in_env('text') and not M.math_mode() end
M.in_math_range = function() return in_env('formula') end
M.in_tikz = function() return in_env('tikzpicture') end
M.in_bullets = function() return in_env('itemize') or in_env('enumerate') end
M.in_MPcode = function() return in_env('MPcode') end
M.math_mode = function() return M.is_mathzone() or M.in_math_range() end

return M
