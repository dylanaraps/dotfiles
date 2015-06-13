" Dylan's Vimrc

" Plugins {{{
" Auto install plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" LOOKS
Plug 'chriskempson/base16-vim'				" Base16 Theme
	let base16colorspace=256
	autocmd ColorScheme * highlight LineNr ctermfg=darkgrey ctermbg=black
	autocmd ColorScheme * highlight CursorLine ctermbg=black

Plug 'bling/vim-airline'				" Status and Tabline
	set laststatus=2					" Always show statusline
	let g:airline#extensions#tabline#enabled = 1		" Enables airline tabs
	let g:airline#extensions#tabline#fnamemod = ':t'	" Display only filename in tabs
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
	let g:airline_theme = 'base16'

" FUNCTIONALITY
Plug 'terryma/vim-expand-region'			" Expands region from char to word to line
Plug 'terryma/vim-multiple-cursors'			" Multiple cursors similar to ST2/3
	let g:multi_cursor_next_key='<C-j>'
	let g:multi_cursor_prev_key='<C-k>'
	let g:multi_cursor_skip_key='<C-l>'
	let g:multi_cursor_quit_key='<Esc>'

Plug 'haya14busa/incsearch.vim' 			" Shows search results as you're typing
Plug 'osyo-manga/vim-anzu'				" Show number of search results
	map /  <Plug>(incsearch-forward)
	map ?  <Plug>(incsearch-backward)
	map g/ <Plug>(incsearch-stay)
	map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
	map <C-n> <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)

Plug 'tpope/vim-surround'				" Surround text
Plug 'tpope/vim-commentary'				" Comment out text
Plug 'rstacruz/vim-closer'				" Enters and adds closing brackets to various languages
Plug 'mattn/emmet-vim'					" Makes html super easy
	let g:user_emmet_install_global = 0
	autocmd FileType html,css,scss EmmetInstall

Plug 'ajh17/VimCompletesMe' 			" Tiny Autocomplete

" FILETYPES
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'					" Changes background behind hex color to it's actual color
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script'

call plug#end()
" }}}

" Filetypes {{{
filetype on
filetype indent on
filetype plugin on
" }}}

" Spaces and Tabs {{{
set tabstop=4
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_	" Show “invisible” characters
" }}}

" Line Wrap {{{
set wrap 								" Soft wraps lines without editing file
set linebreak							" Stops words from being cut off during linebreak
set nolist
set textwidth=80
set wrapmargin=0
set autoindent
set breakindent
" }}}

" Look and Feel {{{
set title								" Change window title to filename
syntax on 								" Switch syntac highlighting on
set t_Co=256							" Make vim use 256 colors
set background=dark
colorscheme base16-twilight
set number 								" Shows linenumbers
set ruler 								" Shows Ruler
set shortmess=atI						" Don’t show the intro message when starting Vim
set noshowmode
" }}}

" Searching {{{
set hlsearch
set incsearch
set ignorecase 							" Do case insensitive searches
set smartcase							" Do case sensitive searches is search term includes a capital
" }}}

" Mapping {{{
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

" Maps Tab and Shift Tab to cycle through buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" Unmaps the arrow keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" Map : to ; (then remap ;)
noremap ; :
noremap <M-;> ;

" Save files with root privliges
cmap w!! w !sudo tee %

" Tab in insert mode to autocomplete
imap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ESC to clear last search
nnoremap <esc> :noh<return><esc>

" Emmet binding
imap <C-e> <plug>(emmet-expand-abbr)

" Maps v to expand region and Ctrl + v to shrink region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" remap jk and kj to escape:  You'll never type it anyway, so it's great!
inoremap jk <Esc>
inoremap kj <Esc>

" use hjkl-movement between rows when soft wrapping:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" include the default behaviour by doing reverse mappings so you can move linewise with gj and gk:
nnoremap gj j
nnoremap gk k

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" Temp Files {{{
" Stores all swap/backup files in a seperate directory
set dir=~/.nvim/swap//
set backupdir=~/.nvim/backups//
set undodir=~/.nvim/undo//

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500
" }}}

" Misc {{{
" Use the OS clipboard by default
set clipboard+=unnamedplus

" Enhance command-line completion
set wildmenu

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Allow cursor keys in insert mode
set esckeys

" Don’t add empty newlines at the end of files
set binary
set noeol
set showcmd
set autoread

" Stops vim from complaining when moving between buffers with unsaved files
set hidden

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

set complete-=i
set smarttab
set nrformats-=octal
set ttimeout

" Stops auto adding of comments on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}

"Folding {{{
set foldmethod=marker
set foldlevel=99
set foldnestmax=10			" max 10 depth

" Save folds in vimrc
autocmd BufWinLeave .*vimrc mkview
autocmd BufWinEnter .*vimrc silent loadview
" }}}
