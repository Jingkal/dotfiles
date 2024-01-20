return {
    -- ////////////////////////////////////
    -- ///////// Mason-LSP
    -- ////////////////////////////////////
    {
        'williamboman/mason-lspconfig.nvim',

        event = { 'BufReadPost', 'BufNewFile' },

        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },

        opts = {
            ensure_installed = {
                "lua_ls", "clangd", 'bashls', "pyright", "cmake"
            },
        },

        config = function(opts)
            local lspconfig = require('lspconfig')
            require("mason-lspconfig").setup(opts)
            require("mason-lspconfig").setup_handlers({
                -- Handlers ------ BEGIN
                function(ls_name)
                    local conf = 'plugins.server-configs.' .. ls_name
                    if pcall(require, conf) then
                        lspconfig[ls_name].setup(require(conf))
                    else
                        -- default
                        lspconfig[ls_name].setup({
                            capabilities = require('cmp_nvim_lsp').default_capabilities()
                        })
                    end
                end,
                -- Handlers ------ END
            })
        end,
    },


    -- ////////////////////////////////////
    -- ///////// LspConfig
    -- ////////////////////////////////////
    {
        'neovim/nvim-lspconfig',

        config = function()
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<space>fm',
                        function() vim.lsp.buf.format { async = true } end, opts)
                end,
            })
        end
    },


    -- ////////////////////////////////////
    -- ///////// Mason
    -- ////////////////////////////////////
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
        config = function(opts) require("mason").setup(opts) end,
    }
}
