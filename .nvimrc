" Dylan's vimrc

" Neovim Exclusive Settings {{{

if has('nvim')
	" Improve Neovim startup time
	let g:python_host_skip_check= 1
	let g:loaded_python_provider = 1
	let g:loaded_python3_provider= 1

	" Enable true color for neovim
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1

	tnoremap <silent> <Esc> <C-\><C-n>:call QuitTerminal()<CR>
endif

" }}}

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
	nnoremap <F3> :Goyo 80 <CR>

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
endfunction

" }}}

augroup GoyoCMDS
	autocmd! User GoyoEnter nested call <SID>goyo_enter()
	autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

" Colorscheme
Plug '~/projects/crayon/master'

Plug 'bling/vim-airline'
	" Always show statusline
	set laststatus=2
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'crayon2'
	let g:airline#extensions#tabline#enabled = 1

	" Display only filename in tabs
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#tabline#show_tabs = 0
	let g:airline#extensions#tabline#excludes = ['terminal', 'gulp']

	function AirlineTheme()
		if g:airline_theme == "crayon2"
			let g:airline_left_sep=''
			let g:airline_right_sep=''
			let g:airline_left_alt_sep=''
			let g:airline_right_alt_sep=''
			let g:airline#extensions#tabline#show_tab_type = 0
		endif
	endfunction

	augroup Airline
		au!
		autocmd VimEnter * call AirlineTheme()
	augroup END

" FUNCTIONALITY
Plug 'tpope/vim-fugitive'
Plug 'wesQ3/vim-windowswap'
	let g:windowswap_map_keys = 0
	nnoremap <silent> <Leader>w :call WindowSwap#EasyWindowSwap()<CR>

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
	let g:oblique#clear_highlight = 1
	let g:oblique#prefix = "\\v"

Plug 'tpope/vim-commentary'
	autocmd FileType xdefaults setlocal commentstring=!\ %s
	autocmd FileType scss setlocal commentstring=/*%s*/

Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-surround'
	" Maps ss to surround word
	nmap ss ysiw
	nmap sl yss
	vmap s S

Plug 'AndrewRadev/splitjoin.vim'
	nmap <silent> sj :SplitjoinSplit<cr>
    nmap <silent> sk :SplitjoinJoin<cr>

Plug 'mattn/emmet-vim'
	let g:user_emmet_install_global = 0
	autocmd FileType html,css,scss EmmetInstall

" Sexiest AutoComplete ever
" Autocompletes using vim's built in completion based on the text before the cursor
Plug 'eparreno/vim-l9'
Plug 'othree/vim-autocomplpop'
	imap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

	" FZF Functions {{{

	nnoremap <silent> <Leader>s :call fzf#run({
	\	'window': '5new',
	\   'sink': 'e'
	\ })<CR>

	function! s:line_handler(l)
		let keys = split(a:l, ':\t')
		exec 'buf' keys[0]
		exec keys[1]
		normal! za
		normal! ^zz
	endfunction

	function! s:buffer_lines()
		let res = []
		for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
			call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
		endfor
		return res
	endfunction

	nnoremap <silent> <Leader>a :call fzf#run({
	\   'source':  <sid>buffer_lines(),
	\   'sink':    function('<sid>line_handler'),
	\   'options': '--extended --nth=3..',
	\   'window': '5new'
	\ })<CR>

	" }}}

" Nerd Tree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
	let g:nerdtree_tabs_open_on_gui_startup = 0
	let NERDTreeShowHidden = 1
	let NERDTreeMinimalUI = 1
	let NERDTreeWinSize = 25
	let NERDTreeMapActivateNode= 'l'
	let NERDTreeMapCloseDir = 'h'
	let NERDTreeRespectWildIgnore = 1
	nnoremap <silent> <Leader>d :NERDTreeTabsToggle <CR>

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
set noequalalways

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

command! Wq wq
command! W w
command! Q q

command! Bd bp<bar>sp<bar>bn<bar>bd<CR>

" Copies what was just pasted
" Allows you to paste the same thing over and over
xnoremap p pgvy

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

" exit file without losing split
nmap <silent> <leader>q :bp\|bd #<CR>

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
" inoremap </ </<C-X><C-O>
inoremap <lt>/ </<C-X><C-O>

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e

" Shows the highlight group of whatever's under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <silent> <F1> :Webdev <CR>

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

" Omni Func
set omnifunc=syntaxcomplete#Complete

" Use the OS clipboard by default
set clipboard+=unnamedplus

" Dictionary
set dictionary=/usr/share/dict/words

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

" Stops auto adding of comments on new line
augroup Format
	au!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" }}}

"Folding {{{

set foldmethod=marker
set foldlevel=99
set foldlevelstart=0
set foldnestmax=10

" Fillchars
set fillchars=fold:-

" Only saves folds/cursor pos in mkview
set viewoptions=folds,cursor

" }}}

" Functions {{{

" Webdev {{{
" Turns neovim into a psuedo web ide with gulp running in a terminal split and nerdtree running on the side.

function! RunTask()
	10new
	call termopen("gulp")
	setlocal nomodifiable
	setlocal nobuflisted
	wincmd w
endfunction

function! OpenFiles()
	setlocal noautochdir
	silent! find src/*.html
	silent! find src/scss/**/*.scss
	silent! find src/coffeescript/**/*.coffee
	silent! find src/js/**/*.js
	1buffer
endfunction

function! NerdTree()
	silent! if g:loaded_nerd_tree == 1
		NERDTreeTabsOpen
		setlocal nomodifiable
		setlocal nobuflisted
		wincmd w
	endif
endfunction

command! Webdev call OpenFiles() | call RunTask() | call NerdTree()

" }}}

" Better Buffer Navigation {{{
" Maps <Tab> to cycle though buffers but only if they're modifiable.
" If they're unmodifiable it maps <Tab> to cycle through splits.

function! BetterBufferNav(bcmd)
	if &modifiable == 0
		wincmd w
	else
		exe a:bcmd
	endif
endfunction

" Maps Tab and Shift Tab to cycle through buffers
nmap <silent> <Tab> :call BetterBufferNav("bn") <Cr>
nmap <silent> <S-Tab> :call BetterBufferNav("bp") <Cr>

" }}}

" Quick Terminal {{{
" Spawns a terminal in a small split for quick typing of commands
" Also maps <Esc> to quit out of FZF/QuickTerm

function QuitTerminal()
	setlocal buflisted
	silent! bd! quickterm
	silent! bd! term://*//*:FZF
	silent! bd! term://*//*:man*
endfunction

function! QuickTerminal()
	3new
	terminal
	file quickterm

	tnoremap <silent> <Esc> <C-\><C-n>:call QuitTerminal()<CR>
endfunction

if has('nvim')
	nnoremap <silent> <Leader>t :call QuickTerminal()<CR>
endif

" }}}

" Fullscreen Help {{{
" Opens Help files as if any other file was opened with "e file"
" Remove the "set modifiable" line if you're going to use this as I need that there for another function.

" This works by opening a blank buffer and setting it's buffer type to 'help'. Now when you run 'help ...' the blank buffer will show the helpfile in fullscreen. The function then adds the buffer to the bufferlist so you can use :bn, :bp, etc.
function FullScreenHelp(helpfile)
	enew
	set bt=help
	execute "help ".a:helpfile
	set buflisted
	set modifiable
endfunction

" Open help files the same as you usually do with "help example" and they'll open in a new buffer similar to "e file"
command -nargs=1 Help call FullScreenHelp(<f-args>)
cabbrev help Help
cabbrev h Help

" }}}

" Man Pages {{{
" Open man pages in vim
function! ManPages(manpage)
	enew
	call termopen("man ".a:manpage)
	startinsert
endfunction

command -nargs=1 Man call ManPages(<f-args>)
cabbrev man Man

" }}}

" Line Return {{{
" Returns you to your position on file reopen and closes all folds.
" On fold open your cursor is on the line you were at on the fold.
augroup line_return
	au!
	au BufReadPost * :call LineReturn()
augroup END

function! LineReturn()
	if line("'\"") > 0 && line("'\"") <= line("$")
		execute 'normal! g`"zvzzzm'
	endif
endfunction

" }}}

" }}}
