return {
    {
        'nvim-treesitter/nvim-treesitter',

        event = { 'BufReadPost', 'BufNewFile' },

        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context'
        },

        build = ":TSUpdate",

        config = function()
            require 'nvim-treesitter.configs'.setup({
                ensure_installed = {
                    'c', 'cpp', 'cmake',
                    'lua', 'python',
                    'vim', 'vimdoc', 'markdown', 'markdown_inline',
                    'query', 'make',
                },
                sync_install = false,
                auto_install = true,

                -- /////////////////////
                -- /// Highlight
                -- /////////////////////
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        if lang == 'txt' then return false end
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(
                            vim.loop.fs_stat,
                            vim.api.nvim_buf_get_name(buf)
                        )
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                -- /////////////////////
                -- /// Highlight
                -- /////////////////////
                indent = { enable = true },
                -- /////////////////////
                -- /// Textobjects
                -- /////////////////////
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                        selection_mode = {
                            ['@function.outer'] = 'v',
                            ['@function.inner'] = 'V',
                        },
                        include_surrounding_whitespace = true,
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [')'] = '@function.outer',
                            ['}'] = '@class.outer',
                        },
                        goto_next_end = {
                        },
                        goto_previous_start = {
                            ['('] = '@function.outer',
                            ['{'] = '@class.outer',
                        },
                        goto_previous_end = {
                        },
                    }
                },
            })
            vim.cmd [[
            set foldmethod=expr
            set foldexpr=nvim_treesitter#foldexpr()
            set nofoldenable
        ]]
        end,

    },
    -- //////////////////////////////////////////////////
    -- ///////////////// treesitter context
    -- //////////////////////////////////////////////////
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'treesitter-context'.setup {
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end,
    }

}
