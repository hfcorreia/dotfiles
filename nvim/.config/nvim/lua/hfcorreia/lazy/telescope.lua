return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        }
                    },
                    path_display = {
                        "truncate"
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            })

            local builtin = require('telescope.builtin')

            require('telescope').load_extension('fzf')

            local default_opts = { noremap = true }
            vim.keymap.set("n", "<leader>ff", builtin.git_files, default_opts)
            vim.keymap.set("n", "<leader>fa", builtin.find_files, default_opts)

            -- search test files
            vim.keymap.set("n", "<leader>ft", function()
                builtin.find_files({
                    prompt_title = "Find Test Files",
                    find_command = {
                        "rg", "--files", "--hidden",
                        "--glob", "*_test.*",
                        '--glob', 'test/**',
                        '--glob', 'tests/**',
                        "--glob", "!**/.git/*"
                    }
                })
            end, default_opts)

            -- don't search in test files / dirs
            vim.keymap.set("n", "<leader>fs", function()
                builtin.find_files({
                    prompt_title = "Find Source Files",
                    find_command = {
                        "rg", "--files", "--hidden",
                        "--glob", "!*_test.*",
                        '--glob', '!test/**',
                        '--glob', '!tests/**',
                        "--glob", "!**/.git/*"
                    }
                })
            end, default_opts)

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, default_opts)
            vim.keymap.set("n", "<leader>fb", builtin.buffers, default_opts)
            vim.keymap.set("n", "<leader>fd", builtin.git_status, default_opts)
            vim.keymap.set("n", "gr", builtin.lsp_references, default_opts)
            vim.keymap.set("n", "gd", builtin.lsp_definitions, default_opts)
            vim.keymap.set("n", "gtd", builtin.lsp_type_definitions, default_opts)

            vim.keymap.set('n', '<leader>fc', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({
                    search = word,
                    additional_args = function()
                        return { "--hidden", "--glob", "!**/.git/*" }
                    end,
                })
            end)
            vim.keymap.set('n', '<leader>fC', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({
                    search = word,
                    additional_args = function()
                        return { "--hidden", "--glob", "!.git/*" }
                    end,
                })
            end)
            vim.keymap.set('n', '<leader>fs', function()
                builtin.grep_string({ search = vim.fn.input("Search > ") })
            end)
        end
    },
}
