return {
    {
        "vim-test/vim-test",
        init = function()
            vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", {})
            vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", {})
            vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", {})
            vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", {})
            vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {})
        end,
    }
}
