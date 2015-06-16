" Dylan's Vimrc
" vim: set foldmethod=marker foldlevel=0:
set shell=zsh											" Make vim use zhrc and aliases

" Plugins {{{

" Auto install plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" LOOKS
Plug 'junegunn/seoul256.vim'
		let g:seoul256_background = 233

Plug 'bling/vim-airline'									" Status and Tabline
		set laststatus=2									" Always show statusline
		let g:airline#extensions#tabline#enabled = 1		" Enables airline tabs
		let g:airline#extensions#tabline#fnamemod = ':t'	" Display only filename in tabs
		let g:airline_left_sep = ''
		let g:airline_right_sep = ''
		let g:airline_theme = 'seoul256'

" FUNCTIONALITY
Plug 'kien/ctrlp.vim'
		let g:ctrlp_map = '<c-x>'
		let g:ctrlp_working_path_mode = 'r'
		let g:ctrlp_clear_cache_on_exit = 0
		let g:ctrlp_by_filename = 1

		let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
		\ --ignore .git
		\ --ignore .sass-cache
		\ --ignore "*.png"
		\ --ignore "*.jp*"
		\ --ignore "*.gif"
		\ --ignore "*.map"
		\ -g ""'

Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
		vmap v <Plug>(expand_region_expand)
		vmap <C-v> <Plug>(expand_region_shrink)

Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'							" Multiple cursors similar to ST2/3
		let g:multi_cursor_next_key='<C-v>'
		let g:multi_cursor_prev_key='v'
		let g:multi_cursor_skip_key='<TAB>'
		let g:multi_cursor_quit_key='<Esc>'

Plug 'haya14busa/incsearch.vim' 							" Shows search results as you're typing
Plug 'osyo-manga/vim-anzu'									" Show number of search results
		let g:incsearch#consistent_n_direction = 1
		let g:incsearch#magic = '\v' 						" very magic
		map /  <Plug>(incsearch-forward)
		map ?  <Plug>(incsearch-backward)
		map g/ <Plug>(incsearch-stay)
		map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
		map <C-n> <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)

Plug 'tpope/vim-surround'									" Surround text
Plug 'tpope/vim-commentary'									" Comment out text
Plug 'rstacruz/vim-closer'									" Enters and adds closing brackets to various languages
Plug 'mattn/emmet-vim'										" Makes html super easy
		let g:user_emmet_install_global = 0
		autocmd FileType html,css,scss EmmetInstall

Plug 'ajh17/VimCompletesMe' 								" Tiny Autocomplete

" FILETYPES
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'										" Changes background behind hex color to it's actual color
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
set background=dark
set number 								" Shows linenumbers
set ruler 								" Shows Ruler
set shortmess=atI						" Don’t show the intro message when starting Vim
set noshowmode

" Colorscheme overrides
autocmd ColorScheme * highlight LineNr ctermbg=233 ctermfg=236
autocmd ColorScheme * highlight CursorLine ctermbg=233 ctermfg=236
autocmd ColorScheme * highlight TabLine ctermbg=233
autocmd ColorScheme * highlight Comment ctermbg=233 ctermfg=238
autocmd ColorScheme * highlight StatuslineNC ctermbg=255 ctermfg=234
autocmd ColorScheme * highlight Statusline ctermfg=233 ctermbg=238
autocmd ColorScheme * highlight ErrorMsg ctermbg=233 ctermfg=238
autocmd ColorScheme * highlight Visual ctermbg=235
autocmd ColorScheme * highlight Folded ctermbg=233 ctermfg=236
autocmd ColorScheme * highlight VertSplit ctermbg=233 ctermfg=233 cterm=none

" Normal mode colors
autocmd ColorScheme * highlight SignColumn ctermfg=4

" Visual mode colors
autocmd ColorScheme * highlight TermCursorNC ctermbg=172

" Insert mode colors
autocmd ColorScheme * highlight wildmenu ctermbg=65 ctermfg=233

" Replace mode colors
autocmd ColorScheme * highlight Structure ctermfg=167

" This line MUST be below these autocmds
colorscheme seoul256

" }}}

" Searching {{{

set hlsearch
set incsearch
set ignorecase 							" Do case insensitive searches
set smartcase							" Do case sensitive searches is search term includes a capital

" }}}

" Mapping {{{

" Leader
let mapleader=" "
nnoremap <SPACE> <nop>
vnoremap <SPACE> <nop>

noremap  <F1> <nop>
inoremap <F1> <nop>

command! WQ wq
command! Wq wq
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
imap ,, <C-y>,
vmap ,, <C-y>,

" Maps Tab to indent blocks of text in visual mode
vmap <TAB> >
vmap <S-TAB> <

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

" Easily move to start/end of line
nnoremap H 0
nnoremap L $

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
imap </ </<C-X><C-O>

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e

" }}}

" Temp Files {{{

set noswapfile                    " it's 2013, Vim.

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

set clipboard+=unnamedplus 				" Use the OS clipboard by default

set wildmenu 							" Enhance command-line completion
set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
set wildignore+=*.gif,*.png,*.jp*
set wildignore+=*/.sass-cache/*,*.map

set backspace=indent,eol,start 			" Make backspace behave in a sane manner.
set esckeys 							" Allow cursor keys in insert mode

set binary
set noeol
set showcmd
set autoread

set hidden 								" Stops vim from complaining when moving between buffers with unsaved files
set noerrorbells 						" Disable error bells
set nostartofline 						" Don’t reset cursor to start of line when moving around.

" Better auto complete
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

set smarttab
set nrformats-=octal

" More natural split opening
set splitbelow
set splitright

" Timeout keycodes not mappings
set notimeout
set ttimeout
set ttimeoutlen=10

au FocusLost * :silent! wall 			" Save on focus loss

" Stops auto adding of comments on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Make vim return to same line in file
augroup line_return
		au!
		au BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\     execute 'normal! g`"zvzz' |
		\ endif
augroup END

" chmod +x on current file
command! EX if !empty(expand('%')) && filereadable(expand('%'))
		\|   silent! execute '!chmod +x %'
		\|   redraw!
		\| else
		\|   echohl WarningMsg
		\|   echo 'Save the file first'
		\|   echohl None
		\| endif

" Tries to figure out project/gulpfile dir and runs gulpfile in new buffer inside of :terminal
function RunGulp()
		vertical botright new
		e term://gulp
		lcd
endfunction

command! Gulp if filereadable("gulpfile.coffee")
		\| 		call RunGulp()
		\|	else
		\|		lcd %:p:h
		\|		lcd ..
		\|
		\|		if filereadable("gulpfile.coffee")
		\| 		call RunGulp()
		\|		else
		\|			lcd ..
		\| 			call RunGulp()
		\|		endif
		\|	endif

" Opens a terminal in a new buffer in inser mode and renames the buffer to Terminal
command! Term e term://zsh | file Terminal | startinsert

" }}}

"Folding {{{

set foldmethod=marker
set foldlevel=99
set foldnestmax=10						" max 10 depth

" Save folds in *vimrc
autocmd BufWinLeave .*vimrc mkview
autocmd BufWinEnter .*vimrc silent loadview

" }}}
