" Dylan\'s init.vim
set encoding=utf-8
scriptencoding utf-8

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

Plug '~/projects/wal.vim'
Plug '~/projects/root.vim'
    let g:root#auto = 1
    let g:root#echo = 0

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
    augroup Goyo
        autocmd!
        " Always enable Goyo.
        autocmd BufReadPost * Goyo 80x80%
        autocmd BufReadPost *.md Goyo 60x80%
        autocmd BufReadPost neofetch Goyo 100x80%

        " Equalize splits on resize.
        autocmd VimResized * execute "normal \<C-W>="
    augroup END

Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-pencil'
    function! Prose()
        call pencil#init()
        call textobj#quote#init()

        iabbrev <buffer> -- –
        iabbrev <buffer> --- —
        iabbrev <buffer> << «
        iabbrev <buffer> >> »
        iabbrev <buffer> ... …
    endfunction

    augroup Writing
      autocmd!
      autocmd FileType markdown,mkd,text call Prose()
    augroup END

Plug 'w0rp/ale'
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_enter = 1
    let g:ale_linters_sh_shellcheck_exclusions = 'SC1090,SC2155'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_linters = {'python': ['pyls', 'flake8', 'pylint']}
    nmap <silent> e <Plug>(ale_next_wrap)

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
	nmap ss ysiw
	nmap sl yss
	vmap s S

Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 100

Plug 'zchee/deoplete-jedi'
Plug 'wellle/tmux-complete.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
    let g:deoplete#enable_at_startup = 1

    " Map <Tab> to control completion menu.
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

Plug 'vim-python/python-syntax'

call plug#end()
filetype plugin on

" }}}

" Look and feel {{{

set noshowmode
set laststatus=0
set shortmess=atI
set cmdheight=2

colorscheme wal

" }}}

" Keybinds {{{

noremap ; :

" Always exit all files.
cnoreabbrev q qa

" Run fzf on e.
nnoremap e :FZF<CR>

" Copies what was just pasted.
xnoremap p pgvy

" Save files with root privileges.
cmap w!! w !sudo tee % >/dev/null

" Maps Tab to indent blocks of text in visual mode.
vmap <TAB> >gv
vmap <BS> <gv

" Use hjkl-movement between rows when soft wrapping.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easily move to start/end of line
nnoremap H 0
vnoremap H 0
vnoremap L $

" Moves a single space after end of line and puts you in insert mode.
nnoremap L A

" za/az toggle folds
" Makes it easier to open/close folds.
nmap az za

" Buffers with <TAB>.
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" Easy escape from terminal mode.
" tnoremap <Esc> <C-\><C-n>

" }}}

" Auto Commands {{{

augroup General
    au!
    autocmd FileType markdown,text setlocal spell

    " Disable comments on newline.
    autocmd FileType * setlocal formatoptions-=cro

    " Prevent saving files starting with ':' or ';'.
    autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')

	" Remove Whitespace on save.
	autocmd BufWritePre * :%s/\s\+$//e

    autocmd FileType xdefaults setlocal commentstring=!\ %s
    autocmd FileType scss,css setlocal commentstring=/*%s*/ shiftwidth=2 softtabstop=2
augroup END

" }}}

" Text {{{

" Show invisible characters.
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Softwrapped lines keep indent level.
set breakindent

" Show existing tab with 4 spaces width.
set tabstop=4

" When indenting with '>', use 4 spaces width.
set shiftwidth=4

" On pressing tab, insert 4 spaces.
set expandtab

" }}}

" Folding {{{

set foldmethod=marker
set foldlevel=99
set foldlevelstart=0

" }}}

" Searching {{{

set hlsearch
set incsearch
set ignorecase
set smartcase

" }}}

" Temp Files {{{

" Fuck swapfiles
set noswapfile
set backupdir=~/.config/nvim/tmp/backups/
set undodir=~/.config/nvim/tmp/undo/

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

" Persistent undo
set undofile
set undolevels=500
set undoreload=500

" }}}

" Misc {{{

" Disable language support.
" let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1

" Change pwd to file location.
set autochdir

set clipboard+=unnamedplus
set nostartofline
set notimeout
set nottimeout
set nrformats-=octal
set modeline

" }}}
