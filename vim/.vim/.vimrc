set encoding=utf-8
set nocompatible
scriptencoding utf-8
let g:is_bash = 1
set directory=~/conf/vim,~/,/tmp
set backupdir=~/conf/vim,~/,/tmp
set viminfo+=n~/conf/vim/viminfo
set runtimepath=~/conf/vim,~/conf/vim/after,$VIM,$VIMRUNTIME

if empty(glob('~/conf/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs
           \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    augroup PLUG
        au!
        autocmd VimEnter * PlugInstall
    augroup END
endif

call plug#begin('~/conf/vim/plugged')

Plug 'cormacrelf/vim-colors-github'
Plug '~/projects/wal.vim'
Plug 'junegunn/goyo.vim'
    augroup Goyo
        autocmd!
        autocmd VimResized * execute "normal \<C-W>="
        autocmd BufReadPost * Goyo        82x80%
        autocmd BufReadPost *.md Goyo     76x80%
        autocmd BufReadPost neofetch Goyo 102x80%
    augroup END

Plug 'w0rp/ale'
    let g:ale_completion_enabled = 1
    let g:ale_sign_column_always = 1
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_fix_on_save = 1
    let g:ale_completion_enabled = 1
    nn <silent> <C-d> :ALEGoToDefinition<cr>
    nn <silent> <C-e> :ALEHover<cr>

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

Plug 'mzlogin/vim-markdown-toc'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
    nmap ss ysiw
    nmap sl yss
    vmap s S

Plug 'maxboisvert/vim-simple-complete'
    let g:vsc_type_complete_length = 1
    set complete=.,w,b,u,t,i

call plug#end()
filetype plugin on

colorscheme wal

" set termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" colorscheme github

cmap w!! w !sudo tee % >/dev/null
cnoreabbrev q qa
nmap az za
nnoremap <S-Tab> :bp<CR>
nnoremap <Tab> :bn<CR>
nnoremap H 0
nnoremap L A
nnoremap silent <esc> <esc>:noh<cr>
nnoremap j gj
nnoremap k gk
noremap ; :
vmap <BS> <gv
vmap <TAB> >gv
vnoremap H 0
vnoremap L $
vnoremap j gj
vnoremap k gk
xnoremap p pgvy

set signcolumn=yes
set noshowmode
set laststatus=0
set synmaxcol=150
set shortmess=atI
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set breakindent
set tabstop=4
set shiftwidth=4
set expandtab
set re=1
set foldmethod=marker
set foldlevel=99
set foldlevelstart=0
set hlsearch
set incsearch
set ignorecase
set smartcase
set undofile
set undolevels=1000
set undoreload=1000
set autochdir
set clipboard=unnamedplus
set nostartofline
set notimeout
set nottimeout
set nrformats-=octal
set modeline
set backspace=indent,eol,start
set noswapfile
set backupdir=~/conf/vim/tmp/backups/
set undodir=~/conf/vim/tmp/undo/
set tabstop=4

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

augroup General
    au!
    autocmd FileType markdown,text setlocal spell
    autocmd FileType * setlocal formatoptions-=cro
    autocmd FileType scss,css  setlocal shiftwidth=2 softtabstop=2
    autocmd BufEnter *.txt  setlocal colorcolumn=80 virtualedit=all
    autocmd BufEnter *.txt  highlight ColorColumn ctermbg=1

    autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufReadPost * call setpos(".", getpos("'\""))
    autocmd BufEnter * execute "normal \<C-W>="
    autocmd BufReadPre *.c,*.h  colorscheme github
augroup END
