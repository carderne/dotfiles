" http://nerditya.com/code/guide-to-neovim/
" http://learnvimscriptthehardway.stevelosh.com/
" http://andrewradev.com/2011/08/06/making-vim-pretty-with-custom-colors/
" =====================================
call plug#begin('~/.config/nvim/plugged')
" -------------------------------------

Plug 'danilo-augusto/vim-afterglow'

" NERD Tree - tree explorer
" https://github.com/scrooloose/nerdtree
" http://usevim.com/2012/07/18/nerdtree/
" (loaded on first invocation of the command)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" https://github.com/Xuyuanp/nerdtree-git-plugin
" https://github.com/tpope/vim-fugitive

" vim-airline
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" Save/restore session support
" https://github.com/tpope/vim-obsession
Plug 'tpope/vim-obsession'

" Markdown support
" https://github.com/plasticboy/vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" https://github.com/shime/vim-livedown
Plug 'shime/vim-livedown'

" Nice interaction with tmux
" https://github.com/benmills/vimux
Plug 'benmills/vimux'

" Fuzzy file, buffer, mru, tag, etc finder
" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" OMG - insanely awesome fuzzy search and blazing fast grep
" https://github.com/junegunn/fzf (parent project)
" https://github.com/junegunn/fzf.vim (more extensive wrapper)
"https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.rkhrm332m
" To update: :PlugUpdate fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" indentline
" https://github.com/Yggdroot/indentLine
Plug 'Yggdroot/indentLine'

" syntax check
Plug 'w0rp/ale'
" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'

" Surround things with quotes/parentheses etc
Plug 'tpope/vim-surround'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Formater
Plug 'Chiel92/vim-autoformat'
Plug 'ambv/black'
Plug 'scrooloose/nerdcommenter'

" -------------------------------------
" Add plugins to &runtimepath
call plug#end()
" =====================================

" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =====================================
" Initial settings
" =====================================

" Disable beep / flash
set vb t_vb=

" Set tabs and indents (for go)
set tabstop=4
set shiftwidth=4
set ai sw=4
" replace tab with spaces
set expandtab

" Language-specific tab size
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype yaml,yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" highlight matches when searching
" Use C-l to clear (see key map section)
set hlsearch

" Line numbering
:set number relativenumber

" Disable line wrapping
" Toggle set to ';w' in key map section
" set nowrap

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
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
set gdefault

" scroll a bit horizontally when at the end of the line
set sidescroll=6

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Make it easier to work with buffers
" http://vim.wikia.com/wiki/Easier_buffer_switching
set hidden
set confirm
set autowriteall
set wildmenu wildmode=full

" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect
  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new line.
  " inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
augroup END

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" markdown
let g:vim_markdown_folding_disabled = 1
nmap gm :LivedownToggle<CR>
let g:livedown_browser = "google-chrome-stable"

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

" change the leader key from "\" to ";" ("," is also popular)
let mapleader=","

" Search and Replace
nmap <leader>h :%s//<Left>

" vim-autoformat
noremap <leader>af :Autoformat<CR>
noremap <leader>bl :Black<CR>

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" Toggle NERDTree
nnoremap <silent> <Space> :NERDTreeToggle<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set nonumber! relativenumber!<CR>

" toggle line wrap
nnoremap <silent> <leader>w :set wrap! wrap?<CR>

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>

" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-l> :bn<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>
" https://github.com/neovim/neovim/issues/2048
nnoremap <C-h> :bp<CR>

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
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" vimux
" https://raw.githubusercontent.com/benmills/vimux/master/doc/vimux.txt
nnoremap <leader>vc :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <leader>vq :VimuxCloseRunner<CR>
nnoremap <leader>vx: VimuxInterruptRunner<CR>

" improved keyboard support for navigation (especially terminal)
" https://neovim.io/doc/user/nvim_terminal_emulator.html
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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

let g:airline_theme='monochrome'

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        TagbarClose
        NERDTreeClose
        set foldcolumn=10

    else
        set foldcolumn=0
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        NERDTree
        " NERDTree takes focus, so move focus back to the right
        " (note: "l" is lowercase L (mapped to moving right)
        wincmd l
        TagbarOpen

    endif
endfunction

" =====================================
" Init
" =====================================
autocmd VimEnter * wincmd p

