local set = vim.keymap.set

-- Easier redo
set("n", "q", "<C-r>")

-- Change leader key and use space for :
vim.g.mapleader = ","
-- set("n", "<space>", ":")

-- Search and Replace
set("n", "<leader>h", ":%s/")
set("n", "<leader>l", ":nohlsearch<CR><C-L>")

-- nvim-tree
set("n", "<C-t>", ":NvimTreeToggle<CR>")
set("n", "<C-f>", ":NvimTreeFindFile<CR>")
set("n", "<C-c>", ":NvimTreeClose<CR>")

-- toggle line numbers and wrap
set("n", "<leader>n", ":set nonumber! relativenumber!<CR>")
set("n", "<leader>w", ":set wrap! wrap?<CR>")

-- Moving between splits and resizing
set("n", "<C-j>", "<C-W><C-J>")
set("n", "<C-k>", "<C-W><C-K>")
set("n", "<C-l>", "<C-W><C-L>")
set("n", "<C-H>", "<C-W><C-H>")
set("n", "<C-w>k", ":resize +15<CR>")
set("n", "<C-w>j", ":resize -15<CR>")
set("n", "<C-w>h", ":vertical:resize -15<CR>")
set("n", "<C-w>l", ":vertical:resize +15<CR>")

-- fzf
set("n", "<leader>g", ":GFiles<CR>")
