if not pcall(require, 'nvim-treesitter') then
    return
end

local M = {}
setmetatable(M, M)
M.__index = M
M.node_stack = {}
M.prevous_node = nil

-- 11, 19 or 12, 18
local function info(node, withtext)
    local ts = vim.treesitter
    if node == nil then
        print('nil')
        return
    end
    local a, b, c, d = node:range()
    if withtext then
        local s = '[%s] (%d,%d)->(%d,%d)\n\t[%s]'
        print(string.format(s,
            node:type(), a, b, c, d,
            ts.get_node_text(node, 0)))
        return
    end
    local s = '[%s] (%d,%d)->(%d,%d)'
    print(string.format(s,
        node:type(), a, b, c, d))
end

local function has_child(node, named)
    if node == nil then
        return false
    end
    named = named or false
    if named then
        return node:child_count() > 0
    end
    return node:named_child_count() > 0
end

local function feedkey(key)
    key = key or '<esc>'
    key = vim.api.nvim_replace_termcodes(key, true, false, true)
    vim.api.nvim_feedkeys(key, 'x', false)
    -- vim.api.nvim_input(key)
end

local function same_start(node1, node2)
    local r1, c1, _ = node1:start()
    local r2, c2, _ = node2:start()
    return r1 == r2 and c1 == c2
end

local function in_visual()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' or mode == 'V' or mode == '\22' then
        return true
    end
    return false
end

function M.backward(node, select)
    local tu = require('nvim-treesitter.ts_utils')
    node = tu.get_node_at_cursor()
    local base = node
    local sib = tu.get_previous_node(node)
    while sib == nil do
        base = base:parent()
        if base:type() == 'chunk' then
            return
        end
        sib = tu.get_previous_node(base)
    end
    local fallback = nil
    while has_child(sib, true) do
        local nchild = sib:named_child_count()
        fallback = sib
        sib = sib:named_child(nchild - 1)
    end
    sib = sib or fallback
    if select then
        if not in_visual() then
            tu.update_selection(0, node)
            feedkey('o')
        end
    end
    tu.goto_node(sib)
end

function M.forward(node, select)
    local tu = require('nvim-treesitter.ts_utils')
    node = tu.get_node_at_cursor()
    select = select or false
    local base = node
    local sib = tu.get_next_node(node)
    while sib == nil do
        base = base:parent()
        if base:type() == 'chunk' then
            return
        end
        sib = tu.get_next_node(base)
    end
    local fallback = nil
    while has_child(sib, true) do
        fallback = sib
        sib = sib:named_child(0)
    end
    sib = sib or fallback
    if select then
        if not in_visual() then
            tu.update_selection(0, node)
        end
        tu.goto_node(sib, true)
    else
        tu.goto_node(sib)
    end
end

function M.outward(node, select)
    local ts = vim.treesitter
    local tu = require('nvim-treesitter.ts_utils')
    select = select or false
    node = node or ts.get_node()
    local parent = node:parent()
    while same_start(node, parent) and parent:type() ~= 'chunk' do
        node = parent
        parent = node:parent()
    end
    if parent:type() == 'chunk' then
        parent = node
    end
    -- select part of the code
    if select then
        tu.update_selection(0, parent)
        feedkey('o')
    else
        tu.goto_node(parent)
    end
    return parent
end

function M.inward(node, select)
    local ts = vim.treesitter
    local tu = require('nvim-treesitter.ts_utils')
    node = node or ts.get_node()
end

return M
