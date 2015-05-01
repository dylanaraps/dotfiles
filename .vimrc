" Dylan's Vimrc
" Choc(?) full of stuff

" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'

Plugin 'JulesWang/css.vim'
Plugin 'cakebaker/scss-syntax.vim'

Plugin 'mikewest/vimroom'
Plugin 'ap/vim-css-color'
Plugin 'othree/html5.vim'
Plugin 'hail2u/vim-css3-syntax'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'

"All of your Plugins must be added before the following line
call vundle#end()            " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set timeoutlen=50

set t_Co=256
set background=dark
colorscheme base16-ocean
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

" Maps Ctrl Right + Left arrows to cycle through tabs
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Unmaps the arrow keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>


" Does Something
autocmd FileType python set breakindentopt=shift:4

" Changes Leader to Space
let mapleader = "\<Space>"

" Maps Leader + Leader  to Visual Line  Mode
nmap <Leader><Leader> V

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
