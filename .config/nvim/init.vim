call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'danilo-augusto/vim-afterglow'

" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" https://github.com/plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown'

" https://github.com/shime/vim-livedown
Plug 'shime/vim-livedown'

" https://github.com/christoomey/vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'

" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

" syntax check
Plug 'dense-analysis/ale'

" Git diff and stuff
Plug 'airblade/vim-gitgutter'

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Formater
Plug 'Chiel92/vim-autoformat'
Plug 'ambv/black'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" =====================================
" Initial settings
" =====================================

" Disable swap file warnings
set shortmess+=A

" Reduced update time for async stuff
set updatetime=100

" Set python interpreter
let g:python3_host_prog = '/usr/bin/python3'

" Disable beep / flash
set vb t_vb=

" Set tabs and indents
set tabstop=4
set shiftwidth=4
set ai sw=4
" replace tab with spaces
set expandtab

" Language-specific tab size
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype yaml,yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" highlight matches when searching
set hlsearch

" Line numbering
:set number relativenumber

" enable line and column display
set ruler

"disable showmode since using vim-airline; otherwise use 'set showmode'
set noshowmode

" file type recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on
syntax enable

set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw

" Search configuration
set ignorecase
set smartcase
set gdefault

" scroll a bit extra horizontally and vertically when at the end/bottom
set sidescroll=6
set scrolloff=3

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list
" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" ncm2
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ale
nmap <silent> <C-n> <Plug>(ale_previous_wrap)
nmap <silent> <C-m> <Plug>(ale_next_wrap)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_linters = {'python': ['flake8']}

" markdown
let g:vim_markdown_folding_disabled = 1
nmap gm :LivedownToggle<CR>
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

" =====================================
" Theme color scheme settings
" =====================================
colorscheme afterglow
let g:afterglow_blackout=0
let g:afterglow_italic_comments=1
set guioptions-=r  " hide right scrollbar
set guifont=Menlo\ Regular:h16

" Spell check
autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb
hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad cterm=underline ctermfg=161
hi SpellCap cterm=underline ctermfg=161
hi SpellLocal cterm=underline ctermfg=161
hi SpellRare cterm=underline ctermfg=161

autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorline
autocmd BufEnter * setlocal cursorcolumn
autocmd WinEnter * setlocal cursorcolumn
autocmd BufLeave * setlocal nocursorcolumn
autocmd WinLeave * setlocal nocursorcolumn

" =====================================
" key map
" =====================================
" change the leader key
let mapleader=","
let maplocalleader="-"

" Search and Replace
nmap <leader>h :%s//<Left>

" vim-autoformat
noremap <leader>af :Autoformat<CR>
noremap <leader>bl :Black<CR>

" Shortcut to edit and reload config
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set nonumber! relativenumber!<CR>
" toggle line wrap
nnoremap <silent> <leader>w :set wrap! wrap?<CR>

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>
" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>
" close buffer
nnoremap <silent> <leader>bd :bd<CR>
" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>
" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>
" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>
" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>
" redraw screan and clear search highlighted items
"nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <leader>l :nohlsearch<CR><C-L>

" vimux
nnoremap <leader>vc :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <leader>vq :VimuxCloseRunner<CR>
nnoremap <leader>vx :VimuxInterruptRunner<CR>
nnoremap <leader>vz :VimuxZoomRunner<CR>

" Resizing (same between vim/tmux)
noremap <C-w>k :resize +15<CR>
noremap <C-w>j :resize -15<CR>
noremap <C-w>h :vertical:resize -15<CR>
noremap <C-w>l :vertical:resize +15<CR>

" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> <leader>tt :terminal<CR>
nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
nnoremap <silent> <leader>th :new<CR>:terminal<CR>
tnoremap <C-x> <C-\><C-n><C-w>q

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''

" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
let g:airline_theme='afterglow'
