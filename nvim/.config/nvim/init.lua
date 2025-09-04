-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- Mappings
vim.g.mapleader = ","

-- lazy.nvim config
require("lazy").setup({
  "sindrets/diffview.nvim",
  "editorconfig/editorconfig-vim",
  "github/copilot.vim",
  "shumphrey/fugitive-gitlab.vim",
  "bronson/vim-trailing-whitespace",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "hrsh7th/nvim-cmp",
  -- "lewis6991/gitsigns.nvim",
  "neovim/nvim-lspconfig",
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "preservim/vimux",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "tpope/vim-rhubarb",
  "tpope/vim-abolish",
  "tpope/vim-repeat",
  {
    "zk-org/zk-nvim",
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
    end
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  "vim-test/vim-test",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  { "catppuccin/nvim",                          name = "catppuccin",  priority = 1000 },
  { "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate",  dependencies = { 'OXY2DEV/markview.nvim' } },
  { "numToStr/Comment.nvim",                    lazy = false },
  { "windwp/nvim-autopairs",                    event = "InsertEnter" },
  { "nvim-telescope/telescope.nvim",            tag = "0.1.5",        dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gs", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
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
            width = 0.40
          }
        }
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
})

-- Base Vim Configs
vim.o.termguicolors = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.spelllang = 'en_gb';
vim.opt.spell = true

vim.opt.scrolloff = 10

-- This unsets the 'last search pattern' register by hitting <esc><esc>
vim.keymap.set("n", "<esc><esc>", ":noh<cr>")
vim.keymap.set("i", "jk", "<esc>", { noremap = true })

-- Usefull mappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- super rename
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Foramtting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Treesitter config
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "ruby", "lua", "vim", "json", "yaml", "elixir", "html", "python", "markdown", "heex", "eex" },

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
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = require("telescope.actions").close
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
    }
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

local builtin = require("telescope.builtin")
local default_opts = { noremap = true }
vim.keymap.set("n", "<leader>ff", builtin.git_files, default_opts)
vim.keymap.set("n", "<leader>fa", builtin.find_files, default_opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, default_opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, default_opts)
vim.keymap.set("n", "<leader>fd", builtin.git_status, default_opts)
vim.keymap.set("n", "gr", builtin.lsp_references, default_opts)
vim.keymap.set("n", "gd", builtin.lsp_definitions, default_opts)
vim.keymap.set("n", "gtd", builtin.lsp_type_definitions, default_opts)

require('telescope').load_extension('fzf')

-- setup lspconfig
local lspconfig = require("lspconfig")

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- load language servers
local servers = { "elixirls", "solargraph", "ts_ls" }
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
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>=', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- CMP Config
local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-o>'] = cmp.mapping.complete(),
    ['<C-g>'] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
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
-- require("gitsigns").setup()

-- vim-test
vim.cmd [[
  let test#strategy = "vimux"
]]

vim.keymap.set("n", "<leader>tc", ":TestNearest<CR>", {})
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", {})
vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", {})
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", {})
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {})

-- nvim-tree config
require("nvim-tree").setup({
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
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<CR>')

-- catppuccin
require("catppuccin").setup({
  integrations = {
    cmp = true,
    -- gitsigns = true,
    nvimtree = true,
    treesitter = true,
  }
})
vim.cmd.colorscheme "catppuccin-mocha"

-- noice setup

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})

-- harpoon
local harpoon = require("harpoon")

harpoon:setup({})

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>l", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- gitlab
vim.cmd [[
  let g:fugitive_gitlab_domains = [ 'https://gitlab.dashlane.com' ]
]]

-- codecompanion
-- vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
-- vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

-- Toggle CodeCompanion chat window
vim.keymap.set({ "n", "v" }, "<leader>,", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

-- Notes
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
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", zk_opts)

-- Terminal integration
vim.api.nvim_create_user_command('TermFloat', function()
  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Floating window size and position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = 'editor',
    style = 'minimal',
    border = 'rounded',
    width = width,
    height = height,
    row = row,
    col = col,
  }

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Start terminal in the buffer
  vim.fn.termopen(os.getenv('SHELL'), {
    on_exit = function(_, exit_code, _)
      -- Automatically close the floating window when terminal exits
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- Enter insert mode for terminal input
  vim.cmd("startinsert")

  -- Optional: disable number and relativenumber in terminal window
  vim.wo.number = false
  vim.wo.relativenumber = false
end, {})

vim.api.nvim_create_user_command('TermFloatCmd', function(opts)
  local cmd = opts.args
  if cmd == "" then
    print("Usage: :TermFloatCmd <command>")
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts_win = {
    relative = 'editor',
    style = 'minimal',
    border = 'rounded',
    width = width,
    height = height,
    row = row,
    col = col,
  }

  vim.api.nvim_open_win(buf, true, opts_win)

  -- Run the command in terminal WITHOUT auto-close
  vim.fn.termopen(cmd)

  vim.cmd("startinsert")

  vim.wo.number = false
  vim.wo.relativenumber = false
end, {
  nargs = '+', -- accept one or more arguments
  complete = 'shellcmd',
})

vim.keymap.set('x', '<leader>S', function()
  -- Yank the visual selection into the unnamed register
  vim.cmd('normal! y')
  local reg_text = vim.fn.getreg('"')
  if reg_text == '' then
    print("No text selected or yanked")
    return
  end
  -- Escape double quotes
  reg_text = reg_text:gsub('"', '\\"')
  -- Run TermFloatCmd with the yanked text
  vim.cmd('TermFloatCmd ' .. reg_text)
end, { silent = true, noremap = true })
