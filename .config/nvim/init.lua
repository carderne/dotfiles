-- -----------------------------------------------------------------------------------------------
-- Plugin installation
-- -----------------------------------------------------------------------------------------------
-- Automatically install Packer if it isn't installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Gruvbox theme with Treesitter support
  use({ "ellisonleao/gruvbox.nvim" })

  -- Used by LuaLine and nvim-tree
  use({ "kyazdani42/nvim-web-devicons" })

  -- Pretty indentation lines
  use({ "lukas-reineke/indent-blankline.nvim" })

  -- Commenting tool
  use({ "numToStr/Comment.nvim" })

  -- Status line at the bottom
  use({ "nvim-lualine/lualine.nvim" })

  -- File browser
  use({ "nvim-tree/nvim-tree.lua" })

  -- Coq
  use({ "ms-jpq/coq_nvim", branch = "coq" })
  use({ "ms-jpq/coq.artifacts", branch = "artifacts" })

  -- LSP (The rest is configured in lua/lsp.lua)
  use({ "nvim-lua/plenary.nvim" }) -- used by stuff below
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "neovim/nvim-lspconfig" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({ "jay-babu/mason-null-ls.nvim" })

  -- TreeSitter
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "nvim-treesitter/nvim-treesitter-context" })

  -- FZF
  use({ "junegunn/fzf", run = ":call fzf#install()" })
  use({ "junegunn/fzf.vim" })

  -- Neogit
  use({ "sindrets/diffview.nvim" })
  use({ "TimUntersberger/neogit" })

  -- gitsigns
  use({ "lewis6991/gitsigns.nvim" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- -----------------------------------------------------------------------------------------------
-- Plugin config
-- -----------------------------------------------------------------------------------------------
-- Configure some of the simpler plugins
require("nvim-tree").setup()

require("Comment").setup({
  toggler = {
    line = "<C-/>",
  },
})

require("lualine").setup({
  sections = {
    lualine_a = {},
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

require("neogit").setup({
  -- disable_signs = true,
  integrations = {
    diffview = true,
  },
})
require("gitsigns").setup({ current_line_blame = true })

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
vim.opt.clipboard = "unnamed"

-- Display settings
vim.opt.termguicolors = true
vim.opt.background = "light"
-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.wrap = false
vim.cmd("colorscheme gruvbox")

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
-- vim.fn.matchadd("error", [[\s\+$]])

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

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
vim.keymap.set("n", ";", "getcharsearch().forward ? ',' : ';'", { expr = true })
vim.keymap.set("n", "'", "getcharsearch().forward ? ';' : ','", { expr = true })

-- Search and Replace
vim.keymap.set("n", "<leader>h", ":%s/")
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-L>")

-- nvim-tree
vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>")
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

-- Basic Diagnostics/LSP jumping around
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Server specific LSP keymaps
-- Called by the `on_attach` in the lspconfig setup
local server_maps = function(bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>fo", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

-- fzf
vim.keymap.set("n", "<leader>g", ":GFiles<CR>")

-- ChatGPT
vim.keymap.set("n", "<leader>cg", ":ChatGPT<CR>")
vim.keymap.set("n", "<leader>cf", ":ChatGPTEditWithInstructions<CR>")

-- -----------------------------------------------------------------------------------------------
-- LSP stuff
-- -----------------------------------------------------------------------------------------------
-- List of LSP servers to install with Mason and activate in LspConfig
local lsp_servers = {
  pyright = {},
  ruff_lsp = {},
  eslint = {},
  jsonls = {},
  tailwindcss = {},
  tsserver = {},
  terraformls = {},
  tflint = {},
  lua_ls = { Lua = { diagnostics = { globals = { "vim" } } } },
  yamlls = {},
}
-- Setup Mason and auto-install some LSPs
-- Mason handles the actual installations,
-- while mason-lspconfig does the automatation
-- and linking with neovim-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
  automatic_installation = true,
})

-- Null-ls is used to set up linters, formatters etc
-- This is the method recommended by mason-null-ls
-- Similar to above, null-ls handles the link with
-- lspconfig, while mason-null-ls handles auto-install
-- and gets Mason to install the things
require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
    "jq",
    "isort",
    "black",
    -- "mypy",
    "prettierd",
  },
  automatic_installation = true,
  automatic_setup = true,
})
require("null-ls").setup()
require("mason-null-ls").setup_handlers()

-- COQ autocomplete needed to be set up here
vim.g.coq_settings = {
  auto_start = "shut-up",
  keymap = {
    jump_to_mark = "", -- Prevent clash with split jumping
    eval_snips = "<leader>j",
  },
}
local coq = require("coq")

-- The null-ls stuff is activated automatically up above
-- by `setup_handlers()`, but the LSP servers need to be
-- manually set up here. Each one is setup() and COQ is
-- activated for them at the same time.
for lsp, settings in pairs(lsp_servers) do
  require("lspconfig")[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = function(_, buffer)
      server_maps({ buffer = buffer })
    end,
    settings = settings,
  }))
end

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
