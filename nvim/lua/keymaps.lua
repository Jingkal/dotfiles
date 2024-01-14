-- ========================================================
-- Simpified Map function =================================
-- ========================================================
local map = function(modes, from, to, opts)
    vim.keymap.set(modes, from, to, opts)
end

-- ========================================================
-- Cursor Movement ========================================
-- ========================================================
map('i', '<C-j>', '<C-o>O')
map('i', '<C-a>', '<C-o>^')
map('i', '<C-e>', '<C-o>$')
map('i', '<C-z>', '<C-o>zz')

-- ========================================================
-- Node Navigation ========================================
-- ========================================================
map({ 'n', 'x' }, 'H',
    '<cmd>lua require("user.nodeski").backward()<cr>', { noremap = true })
map({ 'n', 'x' }, '<leader>h',
    '<cmd>lua require("user.nodeski").backward(nil, true)<cr>', { noremap = true })
map({ 'n', 'x' }, 'L',
    '<cmd>lua require("user.nodeski").forward()<cr>', { noremap = true })
map({ 'n', 'x' }, '<leader>l',
    '<cmd>lua require("user.nodeski").forward(nil, true)<cr>', { noremap = true })
map({ 'n', 'x' }, 'M',
    '<cmd>lua require("user.nodeski").outward()<cr>', { noremap = true })
map({ 'n', 'x' }, '<leader>m',
    '<cmd>lua require("user.nodeski").outward(nil, true)<cr>', { noremap = true })


-- ========================================================
-- Command Mode ===========================================
-- ========================================================
map('c', '<C-A>', '<Home>', { noremap = true })
map('c', '<C-F>', '<Right>', { noremap = true })
map('c', '<C-B>', '<Left>', { noremap = true })

-- ========================================================
-- Vim Builtin Functions ==================================
-- ========================================================
map('n', '<C-p>', '<cmd>Oil<cr>', { noremap = true })
map('n', '<F1>', '<ESC>:vert h ')
