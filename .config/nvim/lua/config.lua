-- Basic settings
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spelllang = "en_gb"

-- Display settings
vim.opt.termguicolors = true
vim.opt.background = "light"
-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.wrap = false
vim.cmd("colorscheme gruvbox")

-- Title
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to

-- Persist undo
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
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

-- Spell check certain file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "latex", "tex", "md", "markdown" },
  command = "setlocal spell",
})
