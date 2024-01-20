return {
    {
        "folke/tokyonight.nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                },
            })
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end,
    },
    { -- onedark
        'navarasu/onedark.nvim',
        enabled = false,
        lazy = false,
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
    {  -- nightfox
        "EdenEast/nightfox.nvim",
        enabled = false,
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
