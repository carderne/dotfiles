-- -----------------------------------------------------------------------------------------------
-- General configuration
-- -----------------------------------------------------------------------------------------------
-- Basic settings
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spelllang = "en_gb"

-- use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Display settings
vim.opt.termguicolors = true
local theme = io.open(vim.fn.expand("~/.config/kitty/theme"), "r"):read("*all")
vim.o.background = theme:find("dark") and "dark" or "light"

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false

-- Title
vim.opt.title = true                       -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to

-- Persist undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- Tab stuff
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- open new split panes to right and below (as you probably expect)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlight trailing characters
vim.opt.listchars = {
  -- eol = "↲",
  tab = "▸ ",
  trail = "·",
}
vim.opt.list = true

-- LSP
vim.lsp.inlay_hint.enable() -- doesn't seem to do anything...

-- -----------------------------------------------------------------------------------------------
-- Keymap settings
-- -----------------------------------------------------------------------------------------------
-- Basic keys
vim.g.mapleader = ","
vim.keymap.set("n", "<space>", ":")
vim.keymap.set("n", "<leader>ec", ":e $MYVIMRC<CR>")

-- Easier redo
vim.keymap.set("n", "q", "<C-r>")

-- Search navigation
-- n is always forward, N is always backward
-- ' is now forward and ; is backward
vim.keymap.set("n", "n", "v:searchforward ? 'n' : 'N'", { expr = true })
vim.keymap.set("n", "N", "v:searchforward ? 'N' : 'n'", { expr = true })
vim.keymap.set({ "n", "v" }, ";", "getcharsearch().forward ? ',' : ';'", { expr = true })
vim.keymap.set({ "n", "v" }, "'", "getcharsearch().forward ? ';' : ','", { expr = true })

-- Search and Replace
vim.keymap.set("n", "<leader>h", ":%s/")
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-L>")

-- nvim-tree
vim.keymap.set("n", "<C-t>", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-c>", ":NvimTreeClose<CR>")

-- toggle line numbers and wrap
vim.keymap.set("n", "<leader>n", ":set nonumber! relativenumber!<CR>")
vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>")

-- Moving between splits and resizing
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-w>k", ":resize +15<CR>")
vim.keymap.set("n", "<C-w>j", ":resize -15<CR>")
vim.keymap.set("n", "<C-w>h", ":vertical:resize -15<CR>")
vim.keymap.set("n", "<C-w>l", ":vertical:resize +15<CR>")

-- Theme
function ToggleBackgroundAndTheme()
  local current_background = vim.o.background
  if current_background == "light" then
    vim.o.background = "dark"
    vim.cmd("silent! !kitten themes --reload-in=all --config-file-name=themes.conf Solarized Dark")
    vim.cmd("silent! !echo dark > ~/.config/kitty/theme")
  else
    vim.o.background = "light"
    vim.cmd("silent! !kitten themes --reload-in=all --config-file-name=themes.conf Solarized Light")
    vim.cmd("silent! !echo light > ~/.config/kitty/theme")
  end
end

vim.keymap.set("n", "<D-d>", ":lua ToggleBackgroundAndTheme()<CR>", { noremap = true, silent = true })

-- Rest
vim.keymap.set("n", "<leader>rr", ":hor Rest run<CR>")
vim.keymap.set("n", "<leader>rc", ":Rest cookies<CR>")
vim.keymap.set("n", "<leader>re", ":Rest env select<CR>")

-- -----------------------------------------------------------------------------------------------
-- Plugin list
-- -----------------------------------------------------------------------------------------------

local plugins = {
  { "nvim-lua/plenary.nvim" },

  -- Gruvbox theme with Treesitter support
  { "ellisonleao/gruvbox.nvim" },

  -- Used by LuaLine and nvim-tree
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Code companion
  {
    "olimorris/codecompanion.nvim",
    opts = {},
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  -- Pretty indentation lines
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

  -- Status line at the bottom
  { "nvim-lualine/lualine.nvim" },

  -- File browser
  { "nvim-tree/nvim-tree.lua" },

  -- LSP
  {
    { 'mason-org/mason.nvim', opts = {} },
    {
      'mason-org/mason-lspconfig.nvim',
      dependencies = { 'neovim/nvim-lspconfig' },
      opts = {}
    },
  },

  -- Format
  {
    'stevearc/conform.nvim',
    opts = {},
  },

  -- Blink
  {
    'saghen/blink.cmp',
    -- dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-s>'] = { 'show_signature', 'hide_signature' },
      },
      appearance = { nerd_font_variant = 'mono' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- TreeSitter
  {
    "nvim-treesitter/nvim-treesitter",
    priority = 1000,
    build = ":TSUpdate",
  },
  -- { "nvim-treesitter/nvim-treesitter-context" },

  -- Telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  { "nvim-telescope/telescope.nvim" },

  -- gitsigns
  { "lewis6991/gitsigns.nvim" },

  -- NeoGit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    config = true,
  },

  { "ggandor/leap.nvim" },

  { "rest-nvim/rest.nvim" },
  rocks = {
    hererocks = true,
    luarocks = false,
  },
}

-- -----------------------------------------------------------------------------------------------
-- Plugin installation
-- -----------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins)

-- -----------------------------------------------------------------------------------------------
-- Plugin config
-- -----------------------------------------------------------------------------------------------
vim.cmd.colorscheme("gruvbox")

require("nvim-tree").setup({
  filters = {
    dotfiles = true,
  },
})

require("ibl").setup({
  debounce = 100,
  indent = { char = "▏" },
  whitespace = { highlight = { "Whitespace", "NonText" } },
})

require("lualine").setup({
  sections = {
    lualine_a = {},
    lualine_b = { "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("telescope").setup({
  pickers = {
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
  },
})

local tele_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tele_builtin.git_files, {})
vim.keymap.set("n", "<leader>fa", tele_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", tele_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", tele_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", tele_builtin.help_tags, {})

require("gitsigns").setup({ current_line_blame = true })

require("leap").add_default_mappings()

-- -----------------------------------------------------------------------------------------------
-- Treesitter
-- -----------------------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  -- https://github.com/nvim-treesitter/nvim-treesitter/tree/master#supported-languages
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "http",
    "python",
    "javascript",
    "typescript",
    "go",
    "sql",
    "bash",
    "css",
    "diff",
    "dockerfile",
    "git_rebase",
    "html",
    "jq",
    "json",
    "latex",
    "markdown",
    "rust",
    "terraform",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- -----------------------------------------------------------------------------------------------
-- LSP stuff
-- -----------------------------------------------------------------------------------------------
require("mason").setup({})
require("mason-lspconfig").setup({
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {
    "ts_ls",
    "basedpyright",
    -- "pyright",
    "ruff",
    "eslint",
    "bashls",
    -- "beancount",
    -- "cssls",
    "tailwindcss",
    "dockerls",
    "docker_compose_language_service",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "rust_analyzer",
    "sqlls",
    "terraformls",
    "yamlls",
  },
})
require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

require("conform").setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
  },
})

-- Formatting
-- vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>")
vim.keymap.set("n", "<leader>fo", ":lua require('conform').format()<CR>")

-- -----------------------------------------------------------------------------------------------
-- Code companion
-- -----------------------------------------------------------------------------------------------
require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "anthropic",
    },
  },
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = "cmd:op read op://Private/Anthropic/credential --no-newline",
        },
      })
    end,
  },
})

-- -----------------------------------------------------------------------------------------------
-- Filetype-specific settings
-- -----------------------------------------------------------------------------------------------
-- Spell check certain file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "latex", "tex", "md", "markdown" },
  callback = function()
    vim.opt.spell = true
    vim.opt.wrap = true
    vim.opt.linebreak = true
  end,
})

-- Beancount
vim.filetype.add({
  extension = {
    bean = "beancount",
  },
})

vim.diagnostic.config({
  virtual_text = {
    source = true,
    format = function(diagnostic)
      if diagnostic.user_data and diagnostic.user_data.code then
        return string.format("%s %s", diagnostic.user_data.code, diagnostic.message)
      else
        return diagnostic.message
      end
    end,
  },
  signs = true,
  float = {
    header = "Diagnostics",
    source = true,
    border = "rounded",
  },
})
