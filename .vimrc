""""""""""""""""""""""""
" Dylan's Vimrc
" Choc(?) full of stuff
""""""""""""""""""""""""

"""""""""""""
" Start Plug
"""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-expand-region'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'terryma/vim-multiple-cursors'

" Syntax Plugins
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'

" Tpope Plugins (They deserve their own category)
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

call plug#end()
"""""""""""
" End Plug
"""""""""""

"""""""""""""""""
" User Interface
"""""""""""""""""

" Overides Theme's Line number bg color
autocmd ColorScheme * highlight LineNr ctermfg=darkgrey ctermbg=black

" Set Vim to use 256 colors
set t_Co=256
let base16colorspace=256

" Disables Automatic Echoing
let g:bufferline_echo = 0

" Set theme and background color
set background=dark
colorscheme base16-twilight

" Word wrap
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

" Switch syntax highlighting on
syntax on

" Line numbers
set number

" Shows ruler
set ruler

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Hides Vim's current mode inplace of Airline's
set noshowmode

""""""""""
" Airline
""""""""""

" Makes airline display at all times
set laststatus=2

" Makes vim use airline tabs
let g:airline#extensions#tabline#enabled = 1

" Change the seperator to blank
let g:airline_left_sep=''
let g:airline_right_sep=''

" Airline Theme
let g:airline_theme='base16'

"""""""""""""""
" Key Bindings
"""""""""""""""

" Maps W/Q/E to their lowecase commands
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> E ((getcmdtype() is# ':' && getcmdline() is# 'E')?('e'):('E'))

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

" Maps v to expand region and Ctrl + v to shrink region
" hitting v once selects the letter
" hitting v twice selects the word
" hitting v three times selects the paragraph
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Map : to ; (then remap ;)
noremap ; :
noremap <M-;> ;

""""""""""""""
" File Saving
""""""""""""""

" Stores all swap/backup files in a seperate directory
set dir=~/.nvim/swap//
set backupdir=~/.nvim/backups//
set undodir=~/.nvim/undo//

" Automatically removes all trailing whitespaces on :w
autocmd BufWritePre * :%s/\s\+$//e

""""""""
" Misc
""""""""

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

set showcmd
set wildmenu
set autoread

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

" Auto Indents
set autoindent
set breakindent

set complete-=i
set smarttab
set nrformats-=octal

set ttimeout

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500

" Stops auto adding of comments on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o