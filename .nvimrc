" Dylan's vimrc
" vim: set foldmethod=marker foldlevel=0:

" Neovim Exclusive Settings {{{

if has('nvim')
	" Improve Neovim startup time
	let g:python_host_skip_check= 1
	let g:loaded_python_provider = 1
	let g:loaded_python3_provider= 1

	" Easier mode exit for :terminal
	tnoremap <C-c> <c-\><c-n>
endif

" Enable true color for neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" }}}

" Make vim use zshrc and aliases
set shell=zsh

" This line must go before autocmds for filetypes
filetype plugin indent on

" Leader
let mapleader = "\<space>"

" Plugins {{{

" Auto install plug if not found
if empty(glob('~/.nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" LOOKS

Plug 'junegunn/goyo.vim'

" Goyo Enter {{{

function! s:goyo_enter()
	set showmode
	set showcmd
	set nonumber

	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

	function! GoyoNeovim()
		let s:guibg = synIDattr(synIDtrans(hlID("Normal")), "bg", "gui")
		execute("hi NonText guifg=" . s:guibg)
		execute("hi StatusLine guifg=" . s:guibg)
		execute("hi StatusLineNC guifg=" . s:guibg)
	endfunction

	call feedkeys("\<esc>zM")
	call GoyoNeovim()
endfunction

" }}}

" Goyo Leave {{{

function! s:goyo_leave()
	set number
	set noshowmode
	AirlineRefresh
	colorscheme crayon

	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif

	call feedkeys("\<esc>zM")
endfunction

" }}}

augroup GoyoCMDS
	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()
	autocmd! BufReadPre .*,*.md,*.scss,*.css,*.html,*.sh,*.erb Goyo 80
augroup END

Plug 'dylanaraps/crayon-theme'
Plug 'chriskempson/base16-vim'

Plug 'bling/vim-airline'
	" Always show statusline
	set laststatus=2
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'crayon'
	let g:airline#extensions#tabline#enabled = 1

	" Display only filename in tabs
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#tabline#show_tabs = 0
	let g:airline#extensions#tabline#excludes = ['terminal', 'gulp']

" FUNCTIONALITY
Plug 'tpope/vim-fugitive'
Plug 'wesQ3/vim-windowswap'
	let g:windowswap_map_keys = 0
	nnoremap <silent> ww :call WindowSwap#EasyWindowSwap()<CR>

Plug 'kana/vim-textobj-user'
\| Plug 'kana/vim-textobj-line'
\| Plug 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

Plug 'terryma/vim-multiple-cursors'
	let g:multi_cursor_use_default_mapping = 0
	let g:multi_cursor_next_key='<C-j>'
	let g:multi_cursor_prev_key='<C-k>'
	let g:multi_cursor_skip_key='<C-l>'
	let g:multi_cursor_quit_key='<Esc>'

" Shows search results as you're typing and a #/Total as you cycle through the results
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
	let g:oblique#incsearch_highlight_all = 1

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
	autocmd FileType xdefaults setlocal commentstring=!\ %s
	autocmd FileType scss setlocal commentstring=/*%s*/

Plug 'rstacruz/vim-closer'
	nmap s yss
	vmap s S

Plug 'mattn/emmet-vim'
	let g:user_emmet_install_global = 0
	autocmd FileType html,css,scss EmmetInstall

" Tiny Autocomplete
Plug 'ajh17/VimCompletesMe'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
	nnoremap <silent> <C-S> :call fzf#run({
	\   'window': '10new',
	\   'sink': 'e'
	\ })<CR>

" FILETYPES
" Changes background behind hex color to it's actual color
Plug 'ap/vim-css-color'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script'

call plug#end()

" }}}

" Filetypes {{{

filetype on

" Markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown


" }}}

" Spaces and Tabs {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" }}}

" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak
set nolist
set textwidth=80
set wrapmargin=0
set autoindent
set breakindent

" }}}

" Look and Feel {{{

" Change window title to filename
set title
syntax on
set background=dark
set number
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI
set noshowmode

colorscheme crayon

" }}}

" Searching {{{

set hlsearch
set incsearch
set ignorecase

" Do case sensitive searches is search term includes a capital
set smartcase

" }}}

" Mapping {{{

" Leader
nnoremap <SPACE> <nop>
vnoremap <SPACE> <nop>

imap <C-s> <C-l>

noremap  <F1> <nop>
inoremap <F1> <nop>

command! Wq wq
command! W w
command! Q q

" Copies what was just pasted
" Allows you to paste the same thing over and over
xnoremap p pgvy

" Maps Tab and Shift Tab to cycle through buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" Maps Enter to cycle buffers
" J does the same thing as enter in normal mode.
nmap <CR><CR> <C-w><C-w>

" Map Function key to equally resize splits
nmap <F1> <C-W>=

" Unmaps the arrow keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" Map : to ; (then remap ;)
noremap ; :
noremap <M-;> ;

" Save files with root privliges
cmap w!! w !sudo tee % > /dev/null

cmap Hterm sp <bar> terminal
cmap Vterm vsp <bar> terminal

" Tab in insert mode to autocomplete
imap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ESC to clear last search and resize splits
nnoremap <esc> <C-w>= :noh<return> <esc>

" Emmet binding
imap ,, <C-y>,

" Maps Tab to indent blocks of text in visual mode
vmap <TAB> >gv
vmap <BS> <gv
vmap <S-TAB> <gv

" remap jk and kj to escape:  You'll never type it anyway, so it's great!
inoremap jk <Esc>
inoremap kj <Esc>

" use hjkl-movement between rows when soft wrapping:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <S-J> }
nnoremap <S-K> {
vnoremap <S-J> }
vnoremap <S-K> {

" include the default behaviour by doing reverse mappings so you can move linewise with gj and gk:
nnoremap gj j
nnoremap gk k

" Jumps to the bottom of Fold
nmap <Leader>b zo]z

" Moves a single space after end of line and puts me in indsert mode
nnoremap L A

" Easily move to start/end of line
nnoremap H 0
vnoremap H 0
vnoremap L $

" Masha
nmap a <nop>
nmap az za

" Easier split navigation
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>

" Auto close HTML tags
inoremap </ </<C-X><C-O>

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e

" Shows the highlight group of whatever's under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}

" Temp Files {{{

set noswapfile

" Stores all swap/backup files in a seperate directory
set dir=~/.nvim/tmp/swap//
set backupdir=~/.nvim/tmp/backups//
set undodir=~/.nvim/tmp/undo//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500

" }}}

" Misc {{{

" Auto change dir to file directory
set autochdir
set ttyfast

" Use the OS clipboard by default
set clipboard+=unnamedplus

" Enhance command-line completion
set wildmenu
set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
set wildignore+=*.gif,*.png,*.jp*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/.sass-cache/*,*.map

set backspace=indent,eol,start
set esckeys

set binary
set noeol
set showcmd
set autoread

" Stops vim from complaining when moving between buffers with unsaved files
set hidden
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Better auto complete
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

set nrformats-=octal

" More natural split opening
set splitbelow
set splitright

" Timeout keycodes not mappings
set notimeout
set nottimeout

" Save on focus loss
autocmd FocusLost * :silent! wall

" Stops auto adding of comments on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" }}}

"Folding {{{

set foldmethod=marker
set foldlevel=99
set foldnestmax=10

" Only saves folds/cursor pos in mkview
set viewoptions=folds,cursor

" Saves cursor posiiton in file and closes all folds on file read
" This way I do away with all of the view files.
augroup line_return
	autocmd!
	autocmd BufReadPre *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\     execute 'normal! g`"zvzz' |
		\ endif

	autocmd BufRead * call feedkeys("\<esc>zM")
augroup END

" }}}

" Functions {{{

function Gulp()
	10new
	terminal gulp
endfunction

" }}}