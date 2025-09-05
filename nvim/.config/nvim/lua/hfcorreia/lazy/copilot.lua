return {
    { "github/copilot.vim" },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            display = {
                chat = {
                    window = {
                        position = "right",
                        width = 0.45
                    }
                },
                action_palette = {
                    width = 95,
                    height = 10,
                    prompt = "Prompt ",                     -- Prompt used for interactive LLM calls
                    provider = "telescope",                 -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                    opts = {
                        show_default_actions = true,        -- Show the default actions in the action palette?
                        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                        title = "CodeCompanion actions",    -- The title of the action palette
                    },
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                }
            },
            opts = {
                -- Set debug logging
                log_level = "DEBUG",
            },
        },
        init = function()
            local opts = { noremap = true, silent = true }

            vim.keymap.set({ "n", "v" }, "<leader>,", "<cmd>CodeCompanionChat Toggle<cr>", opts)
        end
    },
    {
        "OXY2DEV/markview.nvim",
        event = 'VeryLazy',
        opts = {
            preview = {
                filetypes = { "markdown", "codecompanion" },
                ignore_buftypes = {},
            },
        },
    },
    {
        "echasnovski/mini.diff",
        config = function()
            local diff = require("mini.diff")
            diff.setup({
                -- Disabled by default
                source = diff.gen_source.none(),
            })
        end,
    },
}
