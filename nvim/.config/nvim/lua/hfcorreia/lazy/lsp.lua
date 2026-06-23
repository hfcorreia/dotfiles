local mason_deps = {
    "lua_ls",
    "ts_ls",
    "terraformls",
}

return {
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = mason_deps,
            automatic_enable = true,
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig"
        },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            ls.setup()

            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip"
        },
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'mason-org/mason.nvim' },
            { 'mason-org/mason-lspconfig.nvim' },
        },
        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = 'yes'
        end,
        config = function()
            -- Set cmp capabilities globally for all servers
            vim.lsp.config('*', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                    vim.keymap.set('n', '<leader>=', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                [vim.fn.stdpath "config" .. "/lua"] = true,
                            },
                        },
                    },
                }
            })
        end
    }
}
