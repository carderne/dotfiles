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
Plug 'fgrsnau/ncm2-otherbuf'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'davidhalter/jedi-vim'

" NerdTREE
Plug 'preservim/nerdtree'

" Linting
Plug 'dense-analysis/ale'

" Mypy
"Plug 'integralist/vim-mypy'

" Formatter
Plug 'Chiel92/vim-autoformat'
"Plug 'psf/black', { 'commit': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' }
Plug 'psf/black'
Plug 'preservim/nerdcommenter'

" Git
Plug 'tpope/vim-fugitive'

" Language packs
Plug 'sheerun/vim-polyglot'

" Emmet HTML autocomplete
" Plug 'mattn/emmet-vim'

" Tailwind classes
" Plug 'mrdotb/vim-tailwindcss'

" Beancount
Plug 'nathangrigg/vim-beancount'
Plug 'sbdchd/neoformat'

call plug#end()

" =====================================
" Initial settings
" =====================================

" Color settings
set termguicolors
colorscheme gruvbox
set background=light
set cursorline
set cursorcolumn
"highlight Cursorline=blue
"hi CursorLine cterm=red ctermbg=black

" Disable swap file warnings
set shortmess+=A

" Reduced update time for async stuff
set updatetime=100

" Set python interpreter
let g:python3_host_prog = '/home/chris/.pyenv/shims/python'
let g:black_virtualenv = '/home/chris/.virtualenvs/_black'

" Disable beep / flash
set vb t_vb=

" Set tabs and indents
set tabstop=4
set shiftwidth=4
set ai sw=4
" replace tab with spaces
set expandtab

" Language-specific tab size
autocmd Filetype javascript,json,typescriptreact,typescript,ts setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype yaml,yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype beancount,bean setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

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
set omnifunc=syntaxcomplete#Complete

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
" Don't highlight when in insert mode
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+$\|\t/
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Don't hide tildes and stuff
au BufReadPost,BufNewFile *.md set conceallevel=0
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
"let g:indentLine_setConceal = 0
"let g:vim_json_syntax_conceal = 0
"let g:vim_markdown_conceal = 0
"let g:vim_markdown_conceal_code_blocks = 0
"let g:indentLine_char = '¦'

" open new split panes to right and below (as you probably expect)
set splitright
set splitbelow

" Spell check
autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb
syn match myExCapitalWords +\<\w*[A-Z]\K*\>+ contains=@NoSpell
"hi clear SpellBad
"hi clear SpellCap
"hi clear SpellLocal
"hi clear SpellRare
"hi SpellBad cterm=underline ctermfg=161
"hi SpellCap cterm=underline ctermfg=161
"hi SpellLocal cterm=underline ctermfg=161
"hi SpellRare cterm=underline ctermfg=161

"set clipboard=unnamedplus

" =================================
" Autocomplete, linting, formatting
" =================================

" ncm2
autocmd BufEnter *.py,*.js,*.html,*.css,*,scss call ncm2#enable_for_buffer()
"autocmd FileType tex call ncm2#disable_for_buffer()
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

au User Ncm2Plugin call ncm2#register_source({
    \ 'name' : 'css',
    \ 'priority': 9,
    \ 'subscope_enable': 1,
    \ 'scope': ['css','scss'],
    \ 'mark': 'css',
    \ 'word_pattern': '[\w\-]+',
    \ 'complete_pattern': ':\s*',
    \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    \ })

" TailwindCSS
" Set the completefunc you can do this per file basis or with a mapping
set completefunc=tailwind#complete
" The mapping I use
nnoremap <leader>tt :set completefunc=tailwind#complete<cr>
" Add this autocmd to your vimrc to close the preview window after the completion is done
autocmd CompleteDone * pclose

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
let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
\   'python': ['mypy', 'flake8'],
\   'javascript': ['eslint']
\ }

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'python': ['black', 'isort'],
\   'typescriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'yaml': ['prettier']
\ }
let b:ale_python_mypy_options='--no-pretty'
let g:ale_python_pylint_use_msg_id = 1

" =====================================
" key map
" =====================================
" change the leader key
let mapleader=","

nnoremap <Space> :

" save
nnoremap <silent><c-s> :<c-u>update<cr>

" Search and Replace
nmap <leader>h :%s//<Left>

" Paste toggle
set paste
set pastetoggle=<leader>p

" Toggle gruvbox light/dark
nnoremap <leader>cq :execute "set background=" . (&background == "dark" ? "light" : "dark")<CR>

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-c> :NERDTreeClose<CR>

" nercommenter
" C-_ is Ctrl-/ (some weird vim thing)
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" vim-autoformat
noremap <leader>af :Autoformat<CR>
noremap <leader>bl :Black<CR>
noremap <leader>ba :ALEFix<CR>

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

" fzf
nnoremap <leader>g :GFiles<CR>
let $BAT_THEME = 'GitHub'
