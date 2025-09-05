return {
    "zk-org/zk-nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        require("zk").setup({
            -- See Setup section below
            picker = "telescope",
            picker_options = {
                telescope = require("telescope.themes").get_ivy(),
            },

            lsp = {
                config = {
                    name = "zk",
                    cmd = { "zk", "lsp" },
                    filetypes = { "markdown" },
                },

                -- automatically attach buffers in a zk notebook that match the given filetypes
                auto_attach = {
                    enabled = true,
                }
            }
        })
    end,
    init = function()
        local zk_opts = { noremap = true, silent = false }

        -- Create a new note after asking for its title.
        vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", zk_opts)

        -- Open notes.
        vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", zk_opts)

        -- Open notes associated with the selected tags.
        vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", zk_opts)

        -- Search for the notes matching a given query.
        vim.api.nvim_set_keymap("n", "<leader>zf",
            "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", zk_opts)
    end,
}
