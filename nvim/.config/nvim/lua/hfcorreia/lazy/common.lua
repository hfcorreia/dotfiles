return {
    { "editorconfig/editorconfig-vim" },
    {
        "shumphrey/fugitive-gitlab.vim",
        init = function()
            vim.g.fugitive_gitlab_domains = { "https://gitlab.dashlane.com" }
        end,
    },
    { "bronson/vim-trailing-whitespace" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-abolish" },
    { "tpope/vim-repeat" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        otps = {
            disable_filetype = { "TelescopePrompt" , "vim" },
        },
        config = true
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {}
    },
}
