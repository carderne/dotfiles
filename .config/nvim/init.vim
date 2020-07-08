call plug#begin('~/.config/nvim/plugged')

" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

" Color scheme
Plug 'morhetz/gruvbox'

" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autocomplete
 Plug 'ncm2/ncm2'
 Plug 'roxma/nvim-yarp'
 Plug 'ncm2/ncm2-bufword'
 Plug 'ncm2/ncm2-path'
 Plug 'ncm2/ncm2-jedi'
 Plug 'davidhalter/jedi-vim'

 " Linting
 Plug 'dense-analysis/ale'

" Formatter
Plug 'Chiel92/vim-autoformat'
Plug 'psf/black', { 'commit': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' }
Plug 'preservim/nerdcommenter'

" Git
Plug 'tpope/vim-fugitive'

" Language packs
Plug 'sheerun/vim-polyglot'

call plug#end()

" =====================================
" Initial settings
" =====================================

" Color settings
set termguicolors
colorscheme gruvbox
set background=light

" Disable swap file warnings
set shortmess+=A

" Reduced update time for async stuff
set updatetime=100

" Set python interpreter
let g:python3_host_prog = '/home/chris/.envs/nvim/bin/python3'
let g:python_host_prog = '/home/chris/.envs/nvim/bin/python'
let g:black_virtualenv = '/home/chris/.envs/nvim/'

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
set number relativenumber

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

" Don't hide tildes and stuff
set conceallevel=0
let g:indentLine_setConceal = 0

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

" Spell check
autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb
"hi clear SpellBad
"hi clear SpellCap
"hi clear SpellLocal
"hi clear SpellRare
"hi SpellBad cterm=underline ctermfg=161
"hi SpellCap cterm=underline ctermfg=161
"hi SpellLocal cterm=underline ctermfg=161
"hi SpellRare cterm=underline ctermfg=161

" =================================
" Autocomplete, linting, formatting
" =================================

" ncm2
 autocmd BufEnter * call ncm2#enable_for_buffer()
 set completeopt=noinsert,menuone,noselect
 set shortmess+=c
 inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
 inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
 " make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'

" Shortcuts from jedi-vim
" ,g: goto assignment
" ,d: goto definition (deeper)
"  K: show docs
" ,r: rename
" ,n: show usages

" ALE settings
nmap <silent> ]g <Plug>(ale_previous_wrap)
nmap <silent> [g <Plug>(ale_next_wrap)
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint']}

" =====================================
" key map
" =====================================
" change the leader key
let mapleader=","

" Search and Replace
nmap <leader>h :%s//<Left>

" Toggle gruvbox light/dark
nnoremap <leader>cq :execute "set background=" . (&background == "dark" ? "light" : "dark")<CR>

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
nnoremap <leader>l :nohlsearch<CR><C-L>

" Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Resizing
noremap <C-w>k :resize +15<CR>
noremap <C-w>j :resize -15<CR>
noremap <C-w>h :vertical:resize -15<CR>
noremap <C-w>l :vertical:resize +15<CR>
