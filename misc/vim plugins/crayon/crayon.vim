" crayon.vim -- Vim color scheme.
" Author:      Dylan Araps (dyl@tfwno.gf)
" Webpage:     https://github.com/dylanaraps
" Description: A 16 color theme for vim

hi clear

if exists("syntax_on")
  syntax reset
endif

" Neovim Terminal Mode Colors
let g:terminal_color_0 = "#080808"
let g:terminal_color_1 = "#401f1f"
let g:terminal_color_2 = "#3b4a35"
let g:terminal_color_3 = "#4d3c2e"
let g:terminal_color_4 = "#2d4963"
let g:terminal_color_5 = "#564059"
let g:terminal_color_6 = "#2e3c40"
let g:terminal_color_7 = "#a3a69a"
let g:terminal_color_8 = "#1f1f1f"
let g:terminal_color_9 = "#b27b78"
let g:terminal_color_10 = "#9dae71"
let g:terminal_color_11 = "#d8c27a"
let g:terminal_color_12 = "#6f8e9a"
let g:terminal_color_13 = "#b59cd8"
let g:terminal_color_14 = "#80b2ad"
let g:terminal_color_15 = "#dfe7d7"

let colors_name = "crayon"

" highlight groups {{{

if &t_Co >= 256 || has("gui_running")
    hi Normal ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    set background=dark
    hi NonText ctermbg=0 ctermfg=0 cterm=NONE guibg=#080808 guifg=#080808 gui=NONE
    hi Comment ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi Constant ctermbg=0 ctermfg=11 cterm=NONE guibg=#080808 guifg=#d8c27a gui=NONE
    hi Error ctermbg=1 ctermfg=15 cterm=NONE guibg=#401f1f guifg=#dfe7d7 gui=NONE
    hi Identifier ctermbg=0 ctermfg=9 cterm=NONE guibg=#080808 guifg=#b27b78 gui=NONE
    hi Ignore ctermbg=7 ctermfg=0 cterm=NONE guibg=#a3a69a guifg=#080808 gui=NONE
    hi PreProc ctermbg=0 ctermfg=11 cterm=NONE guibg=#080808 guifg=#d8c27a gui=NONE
    hi Special ctermbg=0 ctermfg=14 cterm=NONE guibg=#080808 guifg=#80b2ad gui=NONE
    hi Statement ctermbg=0 ctermfg=9 cterm=NONE guibg=#080808 guifg=#b27b78 gui=NONE
    hi String ctermbg=0 ctermfg=10 cterm=NONE guibg=#080808 guifg=#9dae71 gui=NONE
    hi Number ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi Todo ctermbg=8 ctermfg=11 cterm=NONE guibg=#1f1f1f guifg=#d8c27a gui=NONE
    hi Type ctermbg=0 ctermfg=11 cterm=NONE guibg=#080808 guifg=#d8c27a gui=NONE
    hi Underlined ctermbg=0 ctermfg=1 cterm=underline guibg=#080808 guifg=#401f1f gui=underline
    hi StatusLine ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi StatusLineNC ctermbg=0 ctermfg=4 cterm=bold guibg=#080808 guifg=#2d4963 gui=bold
    hi TabLine ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi TabLineFill ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi TabLineSel ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi TermCursorNC ctermbg=11 ctermfg=0 cterm=NONE guibg=#d8c27a guifg=#080808 gui=NONE
    hi VertSplit ctermbg=0 ctermfg=0 cterm=NONE guibg=#080808 guifg=#080808 gui=NONE
    hi Title ctermbg=0 ctermfg=12 cterm=NONE guibg=#080808 guifg=#6f8e9a gui=NONE
    hi CursorLine ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi LineNr ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi CursorLineNr ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi helpLeadBlank ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi helpNormal ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi Visual ctermbg=8 ctermfg=7 cterm=NONE guibg=#1f1f1f guifg=#a3a69a gui=NONE
    hi VisualNOS ctermbg=0 ctermfg=1 cterm=NONE guibg=#080808 guifg=#401f1f gui=NONE
    hi Pmenu ctermbg=8 ctermfg=7 cterm=NONE guibg=#1f1f1f guifg=#a3a69a gui=NONE
    hi PmenuSbar ctermbg=6 ctermfg=15 cterm=NONE guibg=#2e3c40 guifg=#dfe7d7 gui=NONE
    hi PmenuSel ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi PmenuThumb ctermbg=7 ctermfg=7 cterm=NONE guibg=#a3a69a guifg=#a3a69a gui=NONE
    hi FoldColumn ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi Folded ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi WildMenu ctermbg=10 ctermfg=0 cterm=NONE guibg=#9dae71 guifg=#080808 gui=NONE
    hi SpecialKey ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi DiffAdd ctermbg=0 ctermfg=10 cterm=NONE guibg=#080808 guifg=#9dae71 gui=NONE
    hi DiffChange ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi DiffDelete ctermbg=0 ctermfg=9 cterm=bold guibg=#080808 guifg=#b27b78 gui=bold
    hi DiffText ctermbg=0 ctermfg=12 cterm=bold guibg=#080808 guifg=#6f8e9a gui=bold
    hi IncSearch ctermbg=11 ctermfg=0 cterm=NONE guibg=#d8c27a guifg=#080808 gui=NONE
    hi Search ctermbg=11 ctermfg=0 cterm=NONE guibg=#d8c27a guifg=#080808 gui=NONE
    hi Directory ctermbg=0 ctermfg=12 cterm=NONE guibg=#080808 guifg=#6f8e9a gui=NONE
    hi MatchParen ctermbg=8 ctermfg=0 cterm=NONE guibg=#1f1f1f guifg=#080808 gui=NONE
    hi SpellBad ctermbg=0 ctermfg=1 cterm=underline guibg=#080808 guifg=#401f1f gui=underline guisp=#401f1f
    hi SpellCap ctermbg=0 ctermfg=4 cterm=underline guibg=#080808 guifg=#2d4963 gui=underline guisp=#2d4963
    hi SpellLocal ctermbg=0 ctermfg=5 cterm=underline guibg=#080808 guifg=#564059 gui=underline guisp=#564059
    hi SpellRare ctermbg=0 ctermfg=6 cterm=underline guibg=#080808 guifg=#2e3c40 gui=underline guisp=#2e3c40
    hi ColorColumn ctermbg=8 ctermfg=8 cterm=NONE guibg=#1f1f1f guifg=#1f1f1f gui=NONE
    hi signColumn ctermbg=0 ctermfg=12 cterm=bold guibg=#080808 guifg=#6f8e9a gui=bold
    hi ErrorMsg ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi ModeMsg ctermbg=0 ctermfg=10 cterm=NONE guibg=#080808 guifg=#9dae71 gui=NONE
    hi MoreMsg ctermbg=0 ctermfg=10 cterm=NONE guibg=#080808 guifg=#9dae71 gui=NONE
    hi Question ctermbg=0 ctermfg=12 cterm=NONE guibg=#080808 guifg=#6f8e9a gui=NONE
    hi WarningMsg ctermbg=0 ctermfg=9 cterm=NONE guibg=#080808 guifg=#b27b78 gui=NONE
    hi Cursor ctermbg=0 ctermfg=8 cterm=NONE guibg=#080808 guifg=#1f1f1f gui=NONE
    hi Structure ctermbg=0 ctermfg=13 cterm=NONE guibg=#080808 guifg=#b59cd8 gui=NONE
    hi CursorColumn ctermbg=8 ctermfg=15 cterm=NONE guibg=#1f1f1f guifg=#dfe7d7 gui=NONE
    hi htmlLink ctermbg=0 ctermfg=7 cterm=underline guibg=#080808 guifg=#a3a69a gui=underline
    hi cssMultiColumnAttr ctermbg=0 ctermfg=10 cterm=NONE guibg=#080808 guifg=#9dae71 gui=NONE
    hi link cssFontAttr cssMultiColumnAttr
    hi link cssFlexibleBoxAttr cssMultiColumnAttr
    hi cssBraces ctermbg=0 ctermfg=7 cterm=NONE guibg=#080808 guifg=#a3a69a gui=NONE
    hi link cssAttrComma cssBraces
elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16
    hi Normal ctermbg=black ctermfg=gray cterm=NONE
    set background=dark
    hi NonText ctermbg=black ctermfg=black cterm=NONE
    hi Comment ctermbg=black ctermfg=darkgray cterm=NONE
    hi Constant ctermbg=black ctermfg=yellow cterm=NONE
    hi Error ctermbg=darkred ctermfg=white cterm=NONE
    hi Identifier ctermbg=black ctermfg=red cterm=NONE
    hi Ignore ctermbg=gray ctermfg=black cterm=NONE
    hi PreProc ctermbg=black ctermfg=yellow cterm=NONE
    hi Special ctermbg=black ctermfg=cyan cterm=NONE
    hi Statement ctermbg=black ctermfg=red cterm=NONE
    hi String ctermbg=black ctermfg=green cterm=NONE
    hi Number ctermbg=black ctermfg=gray cterm=NONE
    hi Todo ctermbg=darkgray ctermfg=yellow cterm=NONE
    hi Type ctermbg=black ctermfg=yellow cterm=NONE
    hi Underlined ctermbg=black ctermfg=darkred cterm=underline
    hi StatusLine ctermbg=black ctermfg=darkgray cterm=NONE
    hi StatusLineNC ctermbg=black ctermfg=darkblue cterm=bold
    hi TabLine ctermbg=black ctermfg=gray cterm=NONE
    hi TabLineFill ctermbg=black ctermfg=darkgray cterm=NONE
    hi TabLineSel ctermbg=black ctermfg=darkgray cterm=NONE
    hi TermCursorNC ctermbg=yellow ctermfg=black cterm=NONE
    hi VertSplit ctermbg=black ctermfg=black cterm=NONE
    hi Title ctermbg=black ctermfg=blue cterm=NONE
    hi CursorLine ctermbg=black ctermfg=darkgray cterm=NONE
    hi LineNr ctermbg=black ctermfg=darkgray cterm=NONE
    hi CursorLineNr ctermbg=black ctermfg=darkgray cterm=NONE
    hi helpLeadBlank ctermbg=black ctermfg=gray cterm=NONE
    hi helpNormal ctermbg=black ctermfg=gray cterm=NONE
    hi Visual ctermbg=darkgray ctermfg=gray cterm=NONE
    hi VisualNOS ctermbg=black ctermfg=darkred cterm=NONE
    hi Pmenu ctermbg=darkgray ctermfg=gray cterm=NONE
    hi PmenuSbar ctermbg=darkcyan ctermfg=white cterm=NONE
    hi PmenuSel ctermbg=black ctermfg=gray cterm=NONE
    hi PmenuThumb ctermbg=gray ctermfg=gray cterm=NONE
    hi FoldColumn ctermbg=black ctermfg=gray cterm=NONE
    hi Folded ctermbg=black ctermfg=darkgray cterm=NONE
    hi WildMenu ctermbg=green ctermfg=black cterm=NONE
    hi SpecialKey ctermbg=black ctermfg=darkgray cterm=NONE
    hi DiffAdd ctermbg=black ctermfg=green cterm=NONE
    hi DiffChange ctermbg=black ctermfg=darkgray cterm=NONE
    hi DiffDelete ctermbg=black ctermfg=red cterm=bold
    hi DiffText ctermbg=black ctermfg=blue cterm=bold
    hi IncSearch ctermbg=yellow ctermfg=black cterm=NONE
    hi Search ctermbg=yellow ctermfg=black cterm=NONE
    hi Directory ctermbg=black ctermfg=blue cterm=NONE
    hi MatchParen ctermbg=darkgray ctermfg=black cterm=NONE
    hi SpellBad ctermbg=black ctermfg=darkred cterm=underline
    hi SpellCap ctermbg=black ctermfg=darkblue cterm=underline
    hi SpellLocal ctermbg=black ctermfg=darkmagenta cterm=underline
    hi SpellRare ctermbg=black ctermfg=darkcyan cterm=underline
    hi ColorColumn ctermbg=darkgray ctermfg=darkgray cterm=NONE
    hi signColumn ctermbg=black ctermfg=blue cterm=bold
    hi ErrorMsg ctermbg=black ctermfg=darkgray cterm=NONE
    hi ModeMsg ctermbg=black ctermfg=green cterm=NONE
    hi MoreMsg ctermbg=black ctermfg=green cterm=NONE
    hi Question ctermbg=black ctermfg=blue cterm=NONE
    hi WarningMsg ctermbg=black ctermfg=red cterm=NONE
    hi Cursor ctermbg=black ctermfg=darkgray cterm=NONE
    hi Structure ctermbg=black ctermfg=magenta cterm=NONE
    hi CursorColumn ctermbg=darkgray ctermfg=white cterm=NONE
    hi htmlLink ctermbg=black ctermfg=gray cterm=underline
    hi cssMultiColumnAttr ctermbg=black ctermfg=green cterm=NONE
    hi link cssFontAttr cssMultiColumnAttr
    hi link cssFlexibleBoxAttr cssMultiColumnAttr
    hi cssBraces ctermbg=black ctermfg=gray cterm=NONE
    hi link cssAttrComma cssBraces
endif


" Generated with RNB (https://gist.github.com/romainl/5cd2f4ec222805f49eca)

" }}}
