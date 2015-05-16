" Dylan's Vimrc
" Choc(?) full of stuff

" Start Plug
call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-expand-region'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'

" Syntax Plugins
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'

" Visual Plugins
Plug 'mikewest/vimroom'


" Tpope Plugins (They deserve their own category)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

call plug#end()
" End Plug

set t_Co=256
set background=dark
colorscheme base16-default
let g:airline_powerline_fonts = 1

" Word wrap
set wrap
set linebreak
set nolist

set textwidth=0
set wrapmargin=0

" Use the OS clipboard by default
set clipboard+=unnamedplus

" Enhance command-line completion
set wildmenu

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Allow cursor keys in insert mode
set esckeys

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Don’t add empty newlines at the end of files
set binary
set noeol

" Switch syntax highlighting on
syntax on

" Shows ruler
set ruler

" Show cmd
set showcmd

set wildmenu
set autoread

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Highlight searches
set hlsearch
set incsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Disable error bells
set noerrorbells

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Auto Indents
set autoindent

set complete-=i
set smarttab
set nrformats-=octal

set ttimeout

" Maps Tab and Shift Tab to cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Unmaps the arrow keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>


" Does Something
autocmd FileType python set breakindentopt=shift:4

" Changes Leader to Space
let mapleader      = ' '
let maplocalleader = ' '

" Maps v to expand region and Ctrl + v to shrink region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Makes airline display at all times
set laststatus=2

let g:airline_theme='base16'

" Makes vim use airline tabs
let g:airline#extensions#tabline#enabled = 1
set hidden

" Persistent Undo, Vim remembers everything even after the file is closed.
if exists("&undodir")
	set undofile
	let &undodir=&directory
	set undolevels=500
	set undoreload=500
endif

" Map : to ; (then remap ;) -- massive pinky-saver
noremap ; :
noremap <M-;> ;

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e

" Maps :W to save instead of saying no command
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Maps :Q to save instead of saying no command
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" Vim room settings to add a gap on the left side
highlight! link FoldColumn Normal
set foldcolumn=1

" Stops auto adding of comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o