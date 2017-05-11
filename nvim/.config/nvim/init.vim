" Dylan's init.vim
scriptencoding utf-8

" Leader
let g:mapleader = "\<space>"

" Plugins {{{

" Auto install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config//nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    augroup PLUG
        au!
        autocmd VimEnter * PlugInstall
    augroup END
endif

call plug#begin('~/.config/nvim/plugged')

" My Plugins
Plug '~/projects/wal'
" Plug 'dylanaraps/taskrunner.nvim'
" Plug 'dylanaraps/root.vim'
" Plug '~/projects/root.vim'
" 	let g:root#auto = 0
" 	let g:root#echo = 1

Plug 'dylanaraps/pascal_lint.nvim'
    let g:pascal_lint#args = '-S2 -vw'

Plug 'mzlogin/vim-markdown-toc'

" Writing plugins
Plug 'junegunn/goyo.vim'
    augroup Writing
        au!
        autocmd FileType markdown,text setlocal spell
    augroup END

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    nmap <C-x> :FZF ~<CR>

" Async Linting
Plug 'w0rp/ale'
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_enter = 0
    let g:ale_linters_sh_shellcheck_exclusions = 'SC1090,SC2155'
    nmap <silent> <C-n> <Plug>(ale_next_wrap)
    nmap <silent> <C-N> <Plug>(ale_previous_wrap)

" Async Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'tweekmonster/deoplete-clang2'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#auto_complete_delay = 0
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger='<c-e>'
    let g:UltiSnipsJumpForwardTrigger='<c-b>'
    let g:UltiSnipsJumpBackwardTrigger='<c-z>'

" Clicking v expands region
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

" Shows search results as you're typing
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
	let g:oblique#incsearch_highlight_all = 1
	let g:oblique#clear_highlight = 1
	let g:oblique#prefix = "\\v" " Very Magic

" Insert brackets on enter.
Plug 'rstacruz/vim-closer'

" Tpope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
	" Maps ss to surround word
	nmap ss ysiw

	" Maps sl to surround line
	nmap sl yss

	" Surround Visual selection
	vmap s S

" Filetype Plugins
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'boeckmann/vim-freepascal'

" Show yanked region
Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 200

call plug#end()

" }}}

" Filetypes {{{

filetype plugin indent on

augroup Filetypes
	au!

    " Prevent saving files starting with ':' or ';'.
    autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')

    " Syntax folding for bash
    autocmd Filetype sh let g:sh_fold_enabled=3
    autocmd Filetype sh let g:is_bash=1
    autocmd Filetype sh setlocal foldmethod=syntax

    " Compile Pascal on file save
    autocmd BufWritePost *.pas :FPC

	" All Filetypes
	" Disable comment on newline
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" Remove Whitespace on save
	autocmd BufWritePre * :%s/\s\+$//e

	" Html
	" Map </ to auto close tags
	autocmd FileType html inoremap <buffer> </ </<C-X><C-O>

	" Markdown
	" set .md files to filetype markdown
	autocmd BufNewFile,BufRead *.md set filetype=markdown

	" Equalize splits on resize, mainly used with Goyo to fix it's padding on resize.
	autocmd VimResized * execute "normal \<C-W>="

    " Always use goyo
    autocmd BufReadPost * Goyo 80%x90%

    " Plugins
    autocmd FileType xdefaults setlocal commentstring=!\ %s
    autocmd FileType scss,css setlocal commentstring=/*%s*/ shiftwidth=2 softtabstop=2 expandtab
augroup END

syntax enable

" }}}

" Spaces and Tabs {{{

" Set indent to 4 spaces wide
set tabstop=4
set shiftwidth=4

" A combination of spaces and tabs are used to simulate tab stops at a width
set softtabstop=4
set expandtab

" Show “invisible” characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

" }}}

" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak

" Set textwidth to 80 characters
set textwidth=0
set nolist
set wrapmargin=0

" Copy indent from previous line on linebreak
set autoindent

" Linebreaks keep indent level
set breakindent

" }}}

" Look and Feel {{{

" Enable true color for neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR = 0

" Enables cursor similar to gui programs
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" Change window title to filename
set title

" Turn off linenumbers
set nonumber

" Hide ruler
set noruler

" Don't redraw screen as often
set lazyredraw

set nocursorcolumn
set nocursorline

" syntax sync minlines=256
" set synmaxcol=300
" set re=1

" Don’t show the intro message when starting Vim
set shortmess=atIc

" Hide mode indicator
set noshowmode

" Always show statusline
set laststatus=0

colorscheme wal

" }}}

" Searching {{{

" Highlight search matches
set hlsearch

" Show search results as you type
set incsearch

" Ignore case in searches if query doesn't include capitals
set ignorecase
set smartcase

" }}}

" Mapping {{{

" Really simple Multi cursors
nnoremap <C-j> *Ncgn
vnoremap <C-j> <Esc>*Ncgn

" Unmap space in normal and visual modes
nnoremap <SPACE> <nop>
vnoremap <SPACE> <nop>

" Map ctrl c to escape to fix multiple cursors issue
noremap <C-c> <Esc>

" Map the capital equivalent for easier save/exit
cabbrev Wq wq
cabbrev W w
cabbrev Q q

" Map q to qa to quickly exit when using goyo
cnoreabbrev q qa

" unmap capital K
nnoremap K <nop>

" Copies what was just pasted
" Allows you to paste the same thing over and over and over and over and over and over
xnoremap p pgvy

" Cylces through splits using a double press of enter in normal mode
nnoremap <CR><CR> <C-w><C-w>

" Unmaps the arrow keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" Map ; to :
noremap ; :

" Save files with root privliges
cmap w!! w !sudo tee % >/dev/null

" Maps Tab to indent blocks of text in visual mode
vmap <TAB> >gv
vmap <BS> <gv

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

" Shows the highlight group of whatever's under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <F1> :set number!<CR>

" }}}

" Temp Files {{{

" Fuck swapfiles
set noswapfile

" Set backup/undo dirs
set backupdir=~/.config/nvim/tmp/backups//
set undodir=~/.config/nvim/tmp/undo//

" Make the folders automatically if they don't already exist.
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), 'p')
endif

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500

" }}}

" Misc {{{

" Disable python 2
let g:loaded_python_provider = 1
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

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

" Saner backspacing
set backspace=indent,eol,start

" set esckeys
set noendofline
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
set nofoldenable

" Only saves folds/cursor pos in mkview
set viewoptions=folds,cursor

set fillchars=fold:-

" }}}

" Functions {{{

" Better Buffer Navigation {{{
" Maps <Tab> to cycle though buffers but only if they're modifiable.

function! BetterBufferNav(bcmd)
	if &modifiable == 1 || &filetype ==? 'help'
		execute a:bcmd
	endif
endfunction

" Maps Tab and Shift Tab to cycle through buffers
nmap <silent> <Tab> :call BetterBufferNav("bn") <Cr>
nmap <silent> <S-Tab> :call BetterBufferNav("bp") <Cr>

" }}}

" Fullscreen Help {{{
" Opens Help files as if any other file was opened with "e file"
" also works with completion like regular :help

" This works by opening a blank buffer and setting it's buffer type to 'help'. Now when you run 'help ...' the blank buffer will show the helpfile in fullscreen. The function then adds the buffer to the bufferlist so you can use :bn, :bp, etc.
function FullScreenHelp(helpfile)
	enew
	set buftype=help
	execute 'help ' . a:helpfile
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
	if line("'\"") > 0 && line("'\"") <= line('$')
		execute 'normal! g`"zvzzzm'
	endif
endfunction

" }}}

" Smart :bd {{{
" If more than 1 buffer exists close current buffer while retaining splits.
" bangs(!) are supported as well as arguments after :bd (:bd index.html, etc)
function SmartBD(bang, argu)
		if a:bang == 1
			let l:bang = '!'
		else
			let l:bang = ' '
		endif

		if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
			execute 'bd' . l:bang . ' ' . a:argu
		else
			bp
			execute 'bd' . l:bang . ' #'
		endif

endfunction

command! -bang -nargs=* BD call SmartBD(<bang>0, <q-args>)
cnoreabbrev bd BD

" }}}

" Custom message on save {{{

function SaveRO(bang, argu)
	if a:bang == 1
		let l:bang = '!'
	else
		let l:bang = ' '
	endif

	if &readonly
		w !sudo tee % >/dev/null
		redraw
	else
		execute 'w' . l:bang . ' ' . a:argu
		redraw
	endif
endfunction


command! -bang -nargs=* W call SaveRO(<bang>0, <q-args>)
cnoreabbrev w W

" }}}

" Open current file with another program {{{

function! Openwith(program)
	silent! execute '!' . a:program . ' ' . '"' . expand('%:p') . '"' . ' &'
endfunction

command! -bang -nargs=* Openwith call Openwith(<q-args>)

" }}}

" Chmod +x current file {{{

function! Chmox()
	execute '!chmod +x ' . expand('%:p')
endfunction

command! Chmox call Chmox()

" }}}

" }}}
