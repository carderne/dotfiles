-- Color settings
vim.o.background = "light"
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.cmd("colorscheme gruvbox")

-- Basic settings
vim.o.hlsearch = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false

-- Tab stuff
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.cmd([[
  set ai sw=4
  autocmd Filetype lua,javascript,json,typescriptreact,typescript,ts setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd Filetype yaml,yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd Filetype beancount,bean setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
]])


-- file type recognition and syntax
vim.cmd([[
  filetype on
  filetype plugin on
  filetype indent on
  set omnifunc=syntaxcomplete#Complete
  syntax on
  syntax enable
]])


-- Search configuration
vim.cmd([[
  set ignorecase
  set smartcase
  set gdefault
]])

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.cmd([[
  set sidescroll=6
  set scrolloff=3
]])

-- Tell Vim which characters to show for expanded TABs,
-- trailing whitespace, and end-of-lines.
vim.cmd([[
  if &listchars ==# 'eol:$'
      set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif
  set list
]])

-- Also highlight all tabs and trailing whitespace characters.
-- Don't highlight when in insert mode
vim.cmd([[
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
]])

-- Don't hide tildes and stuff
vim.cmd([[
  au BufReadPost,BufNewFile *.md set conceallevel=0
  let g:vim_json_syntax_conceal = 0
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_conceal_code_blocks = 0
]])

-- open new split panes to right and below (as you probably expect)
vim.cmd([[
  set splitright
  set splitbelow
]])

-- Spell check
vim.cmd([[
  autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb
  syn match myExCapitalWords +\<\w*[A-Z]\K*\>+ contains=@NoSpell
]])
