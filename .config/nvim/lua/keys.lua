vim.g.mapleader = ","

-- change the leader key
vim.cmd([[
  nnoremap <Space> :
]])

-- Search and Replace
vim.cmd([[
  nmap <leader>h :%s/
]])

-- nvim-tree
vim.cmd([[
  nnoremap <leader>te :NvimTreeFocus<CR>
  nnoremap <leader>tt :NvimTreeToggle<CR>
  nnoremap <leader>tf :NvimTreeFind<CR>
  nnoremap <leader>tc :NvimTreeClose<CR>
]])

-- toggle line numbers and wrap
vim.cmd([[
  nnoremap <silent> <leader>n :set nonumber! relativenumber!<CR>
  nnoremap <silent> <leader>w :set wrap! wrap?<CR>
]])

-- Moving between splits and resizing
vim.cmd([[
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>
  noremap <C-w>k :resize +15<CR>
  noremap <C-w>j :resize -15<CR>
  noremap <C-w>h :vertical:resize -15<CR>
  noremap <C-w>l :vertical:resize +15<CR>
]])

-- fzf
vim.cmd([[
  nnoremap <leader>g :GFiles<CR>
]])
