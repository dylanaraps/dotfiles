" Dylan's vimrc

" Leader
let mapleader = "\<space>"

" Neovim Exclusive Settings {{{

if has('nvim')
	" Improve Neovim startup time
	let g:python_host_skip_check= 1
	let g:loaded_python_provider = 1
	let g:loaded_python3_provider= 1

	" Enable true color for neovim
	let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

	" Sexy cursor
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

	tnoremap <silent> <Esc> <C-\><C-n>:call QuitTerminal()<CR>
endif

" }}}

" Plugins {{{

" Auto install plug if not found
if empty(glob('~/.nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.nvim/plugged')

" LOOKS

" My Plugins
Plug '~/dotfiles/colorschemes/ryuuko/vim/ryuuko/'
Plug '~/projects/root.vim/'
Plug '~/projects/taskrunner.nvim/'
	let g:taskrunner#split = "10new"
	let g:taskrunner#focus_on_open = 1
	let g:root#auto = 1
	let g:root#echo = 0

Plug 'junegunn/goyo.vim'
	augroup Goyo
		autocmd VimEnter * Goyo 80%x90%
	augroup END

Plug 'bling/vim-airline'
	" Always show statusline
	set laststatus=2
	let g:airline_powerline_fonts = 0
	let g:airline_theme = 'ryuuko'
	let g:airline#extensions#tabline#enabled = 1

	" Display only filename in tabs
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline#extensions#tabline#show_tabs = 0
	let g:airline_left_sep=''
	let g:airline_right_sep=''
	let g:airline_left_alt_sep=''

	" Disable tab seperators
	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = ''
	let g:airline_right_alt_sep=''
	let g:airline#extensions#tabline#show_tab_type = 0

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
	let g:oblique#prefix = "\\v" " Very Magic

Plug 'tpope/vim-commentary'
	augroup Commentary
		au!
		autocmd FileType xdefaults setlocal commentstring=!\ %s
		autocmd FileType scss setlocal commentstring=/*%s*/
	augroup END

Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-surround'
	" Maps ss to surround word
	nmap ss ysiw
	nmap sl yss
	vmap s S

Plug 'AndrewRadev/splitjoin.vim'
	nmap <silent> sj :SplitjoinSplit<cr>
    nmap <silent> sk :SplitjoinJoin<cr>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
	nnoremap <silent> <Leader>s :call fzf#run({
	\	'window': '5new',
	\   'sink': 'e'
	\ })<CR>

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

" Tiny Autocomplete
Plug 'ajh17/VimCompletesMe'
	augroup Complete
		au!
		autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'
	augroup END

" FILETYPES
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'kchmck/vim-coffee-script'

call plug#end()

" }}}

" Filetypes {{{

filetype plugin indent on

augroup Filetypes
au!

" All Filetypes
" Disable comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Remove Whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Clear cmdline on bufread/enter
autocmd BufEnter,BufReadPost,BufWinEnter * redraw!

" Html
" Map </ to auto close tags
autocmd FileType html inoremap <buffer> </ </<C-X><C-O>

" Markdown
" set .md files to filetype markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" rtorrent config file
" set filetype to zsh so that comments are correctly highlighted
autocmd BufEnter,BufNewFile .rtorrent.rc set filetype=zsh

augroup END

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
set noruler
set noequalalways

" Don’t show the intro message when starting Vim
set shortmess=atI
set noshowmode

colorscheme ryuuko

" }}}

" Searching {{{

set hlsearch
set incsearch
set ignorecase
set smartcase

" }}}

" Mapping {{{

" Leader
nnoremap <SPACE> <nop>
vnoremap <SPACE> <nop>

cabbrev Wq wq
cabbrev W w
cabbrev Q q

" Map q to qa to quickly exit when using goyo
cnoreabbrev q qa

" K
nnoremap K <nop>

" Copies what was just pasted
" Allows you to paste the same thing over and over and over and over
xnoremap p pgvy

" Cylces through splits using a double press of enter in normal mode
nmap <CR><CR> <C-w><C-w>

" Unmaps the arrow keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" Map : to ; (then remap ;)
noremap ; :

" Save files with root privliges
cmap w!! w !sudo tee % >/dev/null

" Terminal Splits
cmap Hterm sp <bar> terminal
cmap Vterm vsp <bar> terminal

" Emmet binding
imap ,, <C-y>,

" Maps Tab to indent blocks of text in visual mode
vmap <TAB> >gv
vmap <BS> <gv
vmap <S-TAB> <gv

" remap jk and kj to escape
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

" Jumps to the bottom of Fold
nmap <Leader>b zo]z

" Moves a single space after end of line and puts me in insert mode
nnoremap L A

" Easily move to start/end of line
nnoremap H 0
vnoremap H 0
vnoremap L $

" unmap a in normal mode
nmap a <nop>

" za/az toggle folds
" ezpz to spam open/close folds now
nmap az za

" Easier split navigation
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>

" Shows the highlight group of whatever's under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <silent> <F1> :Webdev <CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" }}}

" Temp Files {{{

" Fuck swapfiles
set noswapfile

set backupdir=~/.nvim/tmp/backups//
set undodir=~/.nvim/tmp/undo//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif

if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500

" }}}

" Misc {{{

" Auto change dir to file directory
set autochdir

" Use the OS clipboard by default
set clipboard+=unnamedplus

" Dictionary
set dictionary=/usr/share/dict/words

" Enhance command-line completion
set wildmenu
set wildmode=longest,full
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
set hidden
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Better auto complete
set complete=.,w,b,u,t,i
set completeopt=longest,menu,preview

set nrformats-=octal
set notimeout
set nottimeout

" More natural split opening
set splitbelow
set splitright

" }}}

" Folding {{{

set foldmethod=marker
set foldlevel=99
set foldlevelstart=0
set foldnestmax=10

" Only saves folds/cursor pos in mkview
set viewoptions=folds,cursor

set fillchars=fold:-

" }}}

" Functions {{{

" Webdev {{{
" Turns neovim into a psuedo web ide with gulp running in a terminal split and nerdtree running on the side.

function! OpenFiles()
	setlocal noautochdir
	silent! find src/*.html
	silent! find src/scss/**/*.scss
	silent! find src/coffeescript/**/*.coffee
	silent! find src/js/**/*.js
	1buffer
endfunction

function! NerdTree()
	silent! if g:loaded_nerd_tree
		NERDTreeTabsOpen
		setlocal nomodifiable
		setlocal nobuflisted
		wincmd w
	endif
endfunction

function! OpenInBrowser(browser, htmlfile)
	" Neovim segfaults if you sleep in a terminal that's running a command
	" So I'm using this instead of a terminal buffer.
	silent! execute "!" . a:browser . " " . a:htmlfile . " &"
endfunction

function! TaskSplit()
	Task
	wincmd w
	wincmd w
endfunction

command! Webdev call OpenFiles() | call NerdTree() | call OpenInBrowser("firefox-nightly", "index.html") | call TaskSplit() | Goyo!

" }}}

" Better Buffer Navigation {{{
" Maps <Tab> to cycle though buffers but only if they're modifiable.
" If they're unmodifiable it maps <Tab> to cycle through splits.

function! BetterBufferNav(bcmd)
	if &modifiable == 1 || &ft == 'help'
		execute a:bcmd
	else
		wincmd w
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
	silent! bd! term://*//*/home/dyl/.fzf/bin/fzf*
endfunction

function! QuickTerminal()
	6new
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
" also works with completion like regular :help

" This works by opening a blank buffer and setting it's buffer type to 'help'. Now when you run 'help ...' the blank buffer will show the helpfile in fullscreen. The function then adds the buffer to the bufferlist so you can use :bn, :bp, etc.
function FullScreenHelp(helpfile)
	enew
	set bt=help
	execute "help " . a:helpfile
	set buflisted
endfunction

" Open help files the same as you usually do with "help example" and they'll open in a new buffer similar to "e file"
command -nargs=1 -complete=help Help call FullScreenHelp(<f-args>)
cabbrev help Help
cabbrev h Help

" }}}

" Line Return {{{
" Returns you to your position on file reopen and closes all folds.
" On fold open your cursor is on the line you were at on the fold.
augroup line_return
	au!
	autocmd BufReadPost * :call LineReturn()
augroup END

function! LineReturn()
	if line("'\"") > 0 && line("'\"") <= line("$")
		execute 'normal! g`"zvzzzm'
	endif
endfunction

" }}}

" Smart :bd {{{
" If more than 1 buffer exists close buffers while retaining splits.
" bangs(!) are supported as well as arguments after :bd (:bd index.html, etc)
function SmartBD(bang, argu)
		if a:bang == 1
			let bang = "!"
		else
			let bang = " "
		endif

		if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
			execute "bd" . bang . " " . a:argu
		else
			bp
			execute "bd" . bang . " #"
		endif

endfunction

command! -bang -nargs=* BD call SmartBD(<bang>0, <q-args>)

cnoreabbrev bd BD
" }}}

" }}}
