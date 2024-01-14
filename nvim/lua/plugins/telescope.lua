return {
  'nvim-telescope/telescope.nvim',
  dependencies = 'nvim-lua/plenary.nvim',

  keys = {
    { '<leader>lT',  '<cmd>Telescope<cr>' },
    { '<leader>lf',  [[<cmd>Telescope find_files<cr>]] },
    { '<leader>lg',  [[<cmd>Telescope live_grep<cr>]] },
    { '<leader>lw',  [[<cmd>Telescope current_buffer_fuzzy_find<cr>]] },
    { '<leader>lb',  [[<cmd>Telescope buffers<cr>]] },
    { '<leader>lh',  [[<cmd>Telescope help_tags<cr>]] },
    { '<leader>lsd', [[<cmd>Telescope lsp_document_symbols<cr>]] },
    { '<leader>lsw', [[<cmd>Telescope lsp_workspace_symbols<cr>]] },
    { '<leader>lsr', [[<cmd>Telescope lsp_references<cr>]] },
    { '<leader>lse', [[<cmd>Telescope diagnostics<cr>]] },
    { '<leader>lc', [[<cmd>Telescope find_files cwd=~/.config/nvim<cr>]] },
  },

  config = function()
    require("telescope").setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<C-u>"] = false
          },
        },
      },
    }
    -- local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<leader>lT', '<cmd>Telescope<cr>')
    -- vim.keymap.set('n', '<leader>lf', builtin.find_files)
    -- vim.keymap.set('n', '<leader>lg', builtin.live_grep)
    -- vim.keymap.set('n', '<leader>lw', builtin.current_buffer_fuzzy_find)
    -- vim.keymap.set('n', '<leader>lb', builtin.buffers)
    -- vim.keymap.set('n', '<leader>lh', builtin.help_tags)
    -- vim.keymap.set('n', '<leader>lsd', builtin.lsp_document_symbols)
    -- vim.keymap.set('n', '<leader>lsw', builtin.lsp_workspace_symbols)
    -- vim.keymap.set('n', '<leader>lsr', builtin.lsp_references)
    -- vim.keymap.set('n', '<leader>lse', builtin.diagnostics)
    -- vim.keymap.set('n', '<leader>lc', function()
    --   builtin.find_files({ cwd = "~/.config/nvim", search_file = "*.lua" })
    -- end)
    -- vim.keymap.set('n', '<leader>llf', function()
    --   builtin.find_files({ cwd = require("telescope.utils").buffer_dir(), })
    -- end)
  end

}
