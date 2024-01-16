-- On Bootstrap: install the latest stable release of lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim config
require("lazy").setup({
  "L3MON4D3/LuaSnip",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "lewis6991/gitsigns.nvim",
  "neovim/nvim-lspconfig",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "williamboman/mason-lspconfig.nvim",
  "williamboman/mason.nvim",
  'hrsh7th/cmp-path',
  { "catppuccin/nvim",                          name = "catppuccin",  priority = 1000 },
  { "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate" },
  { "numToStr/Comment.nvim",                    lazy = false },
  { "windwp/nvim-autopairs",                    event = "InsertEnter" },
  { "nvim-telescope/telescope.nvim",            tag = "0.1.5",        dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
})

-- Base Vim Configs
vim.cmd.colorscheme "catppuccin-mocha"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Mappings
vim.g.mapleader = ","

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true

-- Treesitter config
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "ruby", "lua", "vim", "json", "yaml", "elixir", "html", "python", "markdown" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },
}

-- Telescope config
require("telescope").setup({
  extensions = {
    defaults = {
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close
        }
      }
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
      }
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
})

require('telescope').load_extension('fzf')

-- mason vim config
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "elixirls", "tsserver", "solargraph", "marksman" }
})

-- setup lspconfig
local lspconfig = require("lspconfig")

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- load language servers
local servers = { "elixirls", "solargraph", "tsserver" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
  }
end

require("lspconfig").lua_ls.setup {
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
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>=', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- CMP Config
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-o>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

cmp.setup.cmdline('/', {
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

-- Comment config
require("Comment").setup()

-- Autopairs config
require("nvim-autopairs").setup()

-- Gitsigns config
require("gitsigns").setup()