return {
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            sort_by = "case_sensitive",
            view = {
                width = 40,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
            update_focused_file = {
                enable = true,
            },
        },
        init = function ()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>')
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {}
    }
}
