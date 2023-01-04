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

  -- Gruvbox theme with Treesitter support
  use({ "ellisonleao/gruvbox.nvim" })

  -- Pretty indentation lines
  use({"lukas-reineke/indent-blankline.nvim", tag = "v2.20.2"})

  -- Commenting tool
  use({
    "numToStr/Comment.nvim",
    commit = "7bb563f",
    config = function()
      require("Comment").setup()
    end,
  })

  -- Status line at the bottom
  use({
    "nvim-lualine/lualine.nvim",
    commit = "32a7382",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  })

  -- File browser
  use({
    "nvim-tree/nvim-tree.lua",
    commit = "bac962c",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup()
    end,
  })

  -- Coq
  use({
    "ms-jpq/coq_nvim",
    branch = "coq",
    commit = "6ca8641",
    requires = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      {
        "ms-jpq/coq.thirdparty",
        branch = "3p",
        config = function()
          require("coq_3p")({ { src = "copilot", short_name = "COP", accept_key = "<c-f>" } })
        end,
      },
    },
  })

  -- LSP
  use({ "nvim-lua/plenary.nvim", commit = "bb44479" })  -- used by stuff below
  use({ "williamboman/mason.nvim", commit = "dac1093" })
  use({ "williamboman/mason-lspconfig.nvim", commit = "aa25b41" })
  use({ "neovim/nvim-lspconfig", commit = "e69978a" })
  use({ "jose-elias-alvarez/null-ls.nvim", commit = "d09d7d8" })
  use({ "jay-babu/mason-null-ls.nvim", commit = "1fcf055" })
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

  -- TreeSitter
  use({ "nvim-treesitter/nvim-treesitter", tag = "v0.8.1" })

  -- FZF
  use({ "junegunn/fzf", run = ":call fzf#install()", tag = "0.35.1" })
  use({ "junegunn/fzf.vim", commit = "0f03107" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
