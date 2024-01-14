local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {

    -- //////////////////////////////////////////
    -- /////// CMP
    -- //////////////////////////////////////////
    {
        'hrsh7th/nvim-cmp',

        event = { 'CmdlineEnter', 'InsertEnter' },
        dependencies = {
            "L3MON4D3/LuaSnip",
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'saadparwaiz1/cmp_luasnip',
        },

        config = function()
            local cmp = require 'cmp'
            local luasnip = require('luasnip')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({
                                    behavior = cmp.ConfirmBehavior.Replace, select = false
                                })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Replace, select = true
                        }),
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    {
                        name = 'luasnip',
                        option = { use_show_condition = false, show_autosnippets = true }
                    },
                    { name = 'path' },
                    { name = 'buffer' },
                }),
            })
            -- cmdline
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = 'path',keyword_length = 3 }, { name = 'cmdline',keyword_length=3} }),
            })
        end
    },


    -- //////////////////////////////////////////
    -- /////// Luasnip
    -- //////////////////////////////////////////
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = 'rafamadriz/friendly-snippets',
        config = function()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load('./snippets')
            require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })
            vim.keymap.set({ "i" }, "<C-q>", function() luasnip.expand() end, { silent = true })
        end
    },

}
