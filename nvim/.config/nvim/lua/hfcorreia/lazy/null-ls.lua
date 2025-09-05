return {
    {
        "nvimtools/none-ls.nvim", -- null-ls successor
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "javascript", "typescript", "json", "yaml", "markdown" },
                    }),
                },
            })
        end,
    },
}
