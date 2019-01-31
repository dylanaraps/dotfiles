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
Plug '~/projects/fff.vim'
Plug 'junegunn/goyo.vim'
    augroup Goyo
        autocmd!
        " Always enable Goyo.
        autocmd BufReadPost * Goyo 82x80%
        autocmd BufReadPost *.md Goyo 76x80%
        autocmd BufReadPost neofetch Goyo 102x80%

        " Equalize splits on resize.
        autocmd VimResized * execute "normal \<C-W>="
    augroup END

Plug 'terryma/vim-multiple-cursors'
    let g:multi_cursor_use_default_mapping=0
    let g:multi_cursor_next_key='<C-j>'
    let g:multi_cursor_prev_key='<C-k>'
    let g:multi_cursor_skip_key='<C-s>'
    let g:multi_cursor_quit_key='<Esc>'

Plug 'w0rp/ale'
    let g:ale_lint_delay = 0
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_enter = 1
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_sh_shellcheck_exclusions = 'SC2180;SC1090'
    let g:ale_linters = {'python': ['pyls', 'flake8', 'pylint'],
                        \'sh': ['shellcheck']}
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
    let g:highlightedyank_highlight_duration = 200

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

Plug 'vim-python/python-syntax'
Plug 'mzlogin/vim-markdown-toc'

call plug#end()
filetype plugin on

" }}}

" Look and feel {{{

set signcolumn=yes
set noshowmode
set laststatus=0
set shortmess=atI
set cmdheight=1

colorscheme wal

" }}}

" Keybinds {{{

noremap ; :

" Always exit all files.
cnoreabbrev q qa

" Open fff
nnoremap f :F<CR>

" Run fzf on e.
nnoremap <C-e> :FZF<CR>

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
    autocmd FileType * setlocal formatoptions-=cro
    autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')
	autocmd BufWritePre * :%s/\s\+$//e
    autocmd FileType xdefaults setlocal commentstring=!\ %s
    autocmd FileType scss,css setlocal commentstring=/*%s*/ shiftwidth=2 softtabstop=2
augroup END

" }}}

" Text {{{

set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set breakindent
set tabstop=4
set shiftwidth=4
set expandtab
set re=1

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

set noswapfile
set backupdir=~/.config/nvim/tmp/backups/
set undodir=~/.config/nvim/tmp/undo/

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

set undofile
set undolevels=1000
set undoreload=1000

" }}}

" Misc {{{

let g:loaded_ruby_provider = 1

set autochdir
set clipboard+=unnamedplus
set nostartofline
set notimeout
set nottimeout
set nrformats-=octal
set modeline

" }}}
