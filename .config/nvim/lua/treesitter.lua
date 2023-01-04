require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    "python",
    "lua",
    "typescript",
    "terraform",
    "yaml",
    "sql",
    "html",
    "vim",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  }
})
