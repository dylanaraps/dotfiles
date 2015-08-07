" Dylan's Vimrc
" vim: set foldmethod=marker foldlevel=0:

" Enable true color for neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Make vim use zhrc and aliases
set shell=zsh

" This line must go before autocmds for filetypes
filetype plugin indent on

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
	function! s:goyo_enter()
		highlight NonText guifg=#181818 guibg=#181818

		set showmode
		set showcmd
		set nonumber

		let b:quitting = 0
		let b:quitting_bang = 0
		autocmd QuitPre <buffer> let b:quitting = 1
		cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
	endfunction

	function! s:goyo_leave()
		set number
		AirlineRefresh

		" Quit Vim if this is the only remaining buffer
		if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
			if b:quitting_bang
				qa!
			else
				qa
			endif
		endif
	endfunction

	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()

	autocmd! BufReadPre .* Goyo 80

Plug 'chriskempson/base16-vim'
	let base16colorspace=256

Plug 'ajh17/Spacegray.vim'

Plug 'bling/vim-airline'
	" Always show statusline
	set laststatus=2
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'seoul256'
	let g:airline#extensions#tabline#enabled = 1

	" Display only filename in tabs
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#tabline#show_tabs = 0
	let g:airline#extensions#tabline#excludes = ['terminal', 'gulp']

" FUNCTIONALITY
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-lion'
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
Plug 'mattn/emmet-vim'
	let g:user_emmet_install_global = 0
	autocmd FileType html,css,scss EmmetInstall

" Tiny Autocomplete
Plug 'ajh17/VimCompletesMe'

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

" 256 Color Terminal Color Overides {{{

" augroup ColorOverride256
" 	au!
" 	au ColorScheme * hi normal ctermbg=0
" 	au ColorScheme * hi LineNr ctermbg=bg ctermfg=236
" 	au ColorScheme * hi CursorLine ctermbg=bg ctermfg=236
" 	au ColorScheme * hi CursorLineNR ctermbg=bg ctermfg=236
" 	au ColorScheme * hi TabLine ctermbg=bg
" 	au ColorScheme * hi Comment ctermbg=bg ctermfg=238
" 	au ColorScheme * hi StatuslineNC ctermbg=255 ctermfg=235
" 	au ColorScheme * hi Statusline ctermfg=bg ctermbg=238
" 	au ColorScheme * hi ErrorMsg ctermbg=bg ctermfg=238
" 	au ColorScheme * hi Visual ctermbg=236
" 	au ColorScheme * hi Folded ctermbg=bg ctermfg=236
" 	au ColorScheme * hi VertSplit ctermbg=bg ctermfg=bg cterm=none
" 	au ColorScheme * hi NonText ctermfg=bg

" 	" Normal mode colors
" 	au ColorScheme * hi SignColumn ctermfg=4

" 	" Visual mode colors
" 	au ColorScheme * hi TermCursorNC ctermbg=172

" 	" Insert mode colors
" 	au ColorScheme * hi wildmenu ctermbg=65

" 	" Replace mode colors
" 	au ColorScheme * hi Structure ctermfg=167
" augroup END

" }}}

" True Color Terminal Color Overides {{{

augroup ColorOverrideTrue
	au!
	au ColorScheme * hi Normal guibg=#181818
	au ColorScheme * hi LineNr guibg=#181818 guifg=#383838
	au ColorScheme * hi CursorLine guibg=#181818 guifg=#383838
	au ColorScheme * hi CursorLineNR guibg=#181818 guifg=#383838
	au ColorScheme * hi TabLine guibg=#181818
	au ColorScheme * hi Comment guibg=#181818 guifg=#383838
	au ColorScheme * hi StatuslineNC guibg=#F8F8F8 guifg=#282828
	au ColorScheme * hi Statusline guifg=#181818 guibg=#383838
	au ColorScheme * hi ErrorMsg guibg=#181818 guifg=#383838
	au ColorScheme * hi Visual guibg=#383838
	au ColorScheme * hi Folded guibg=#181818 guifg=#282828
	au ColorScheme * hi VertSplit guibg=#181818 guifg=#181818 cterm=none
	au ColorScheme * hi NonText guifg=#181818 guibg=#181818

	" Normal mode colors
	au ColorScheme * hi SignColumn guifg=#7CAFC2

	" Visual mode colors
	au ColorScheme * hi TermCursorNC guibg=#DC9656

	" Insert mode colors
	au ColorScheme * hi wildmenu guibg=#A1B56C

	" Replace mode colors
	autocmd ColorScheme * highlight Structure guifg=#BA8BAF
augroup END

" }}}

" This line MUST be below these autocmds
colorscheme base16-default

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
let mapleader=" "
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

" ESC to clear last search
nnoremap <esc> :noh<return><esc>

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

" Easily move to start/end of line
nnoremap H 0
nnoremap L A<space><Esc>
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

" Easier mode exit for :terminal
tnoremap <Esc> <c-\><c-n>

" Auto close HTML tags
inoremap </ </<C-X><C-O>

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e

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
set ttimeout
set ttimeoutlen=10

" Save on focus loss
autocmd FocusLost * :silent! wall

" Stops auto adding of comments on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" chmod +x on current file
command! EX if !empty(expand('%')) && filereadable(expand('%'))
	\|     silent! execute '!chmod +x %'
	\|     redraw!
	\| else
	\|     echohl WarningMsg
	\|     echo 'Save the file first'
	\|     echohl None
	\| endif

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
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\     execute 'normal! g`"zvzz' |
	\ endif

	autocmd BufRead * call feedkeys("\<esc>zM")
augroup END

" }}}

" Functions {{{

" WEBDEV SESSION START
function! Files()
	if filereadable("src/index.html")
	\|     e src/*.html
	\|	   cd ..
	\| else
	\|     echo "No html file(s) found"
	\| endif

	if filereadable("src/scss/main.scss")
	\|     e src/scss/*.scss
	\|	   cd ..
	\| else
	\|     echo "No scss file(s) found"
	\| endif

	if filereadable("src/javascript/main.js")
	\|     e src/javascript/*.js
	\|     cd ..
	\| else
	\|     echo "No javascript file(s) found"
	\| endif
endfunction

function! Gulp()
	10sp
    terminal gulp
    wincmd k
	call feedkeys("\<ESC>")
	call feedkeys("\<ESC>")
endfunction

command! Gulp if 1 == 1
	\| call Gulp()

command! Webdev if isdirectory(".git") && filereadable("gulpfile.coffee")
	\|     call Files()
	\|     call Gulp()
	\| else
	\|     echom "No project found"
	\| endif

" Music session
function! Ncmpcpp()
	vsp
	terminal ncmpcpp -s visualizer
	file visualizer

	sp
	terminal ncmpcpp
	file ncmpcpp
endfunction

command! Music if 1 == 1
	\| call Ncmpcpp()
\| else
	\| echo "wot"
\| endif

" }}}