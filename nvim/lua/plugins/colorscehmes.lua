return {
  { -- onedark
    'navarasu/onedark.nvim',
    lazy = true,
    opts = {
      style = 'deep',
      code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'bold',
        strings = 'italic',
        variables = 'bold_italic'
      },
    },
    config = function(opts)
      require('onedark').load(opts)
    end,
  }, -- onedark
  -- =================================================================
  { -- nightfox
    "EdenEast/nightfox.nvim",
    lazy = false,
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        }
      }
    },
    config = function(opts)
      require('nightfox').setup({ opts })
      vim.cmd.colorscheme('nightfox')
    end
  }, -- nightfox
  -- =================================================================
}
