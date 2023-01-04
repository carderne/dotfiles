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

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use({ "ellisonleao/gruvbox.nvim" })

  use("lukas-reineke/indent-blankline.nvim")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup()
    end,
  })

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup()
    end,
  })

  -- lsp
  use({ "nvim-lua/plenary.nvim" })
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
  })
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      -- Python
      "pyright",
      "ruff_lsp",

      -- TypeScript
      "eslint",
      "tsserver",

      -- Terraform
      "terraformls",
      "tflint",

      -- Lua
      "sumneko_lua",

      -- YAML
      "yamlls",
    },
    automatic_installation = true,
  })
  require("mason-null-ls").setup({
    ensure_installed = {
      "stylua",
      "jq",
      "black",
      -- "mypy",
      "prettierd",
    },
    automatic_installation = true,
    automatic_setup = true,
  })
  require("null-ls").setup()
  require("mason-null-ls").setup_handlers()

  -- TreeSitter
  use({ "nvim-treesitter/nvim-treesitter" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
