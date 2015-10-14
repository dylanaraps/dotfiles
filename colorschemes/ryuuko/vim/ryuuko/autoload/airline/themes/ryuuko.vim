" ryuuko Airline
let g:airline#themes#ryuuko#palette = {}

" Normal mode
let s:N1 = [ '#707894' , 'NONE' ,  7 ,  0 ]
let s:N2 = [ '#feffff' , 'NONE' ,  7 ,  0 ]
let s:N3 = [ '#feffff' , 'NONE' ,  7 ,  0 ]

" Insert mode
let s:I1 = [ '#d1c8b8' , 'NONE' ,  7 ,  0 ]
let s:I2 = [ '#feffff' , 'NONE' ,  7 ,  0 ]
let s:I3 = [ '#feffff' , 'NONE' ,  7 ,  0 ]

" Visual mode
let s:V1 = [ '#e47b66' , 'NONE' ,  7 ,  0 ]
let s:V2 = [ '#feffff' , 'NONE' ,  7 ,  0 ]
let s:V3 = [ '#feffff' , 'NONE' ,  7 ,  0 ]

" Replace mode
let s:R1 = [ '#707894' , 'NONE' ,  7 ,  0 ]
let s:R2 = [ '#feffff' , 'NONE' ,  7 ,  0 ]
let s:R3 = [ '#feffff' , 'NONE' ,  7 ,  0 ]

let g:airline#themes#ryuuko#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#ryuuko#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#ryuuko#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#ryuuko#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let g:airline#themes#ryuuko#palette.accents = {
      \ 'red': [ '#feffff' , 'NONE' , 7 , 0 , '' ]
      \ }

" Inactive mode
let s:IN1 = [ '#feffff' , 'NONE' , 7 , 0 ]
let s:IN2 = [ '#feffff' , 'NONE' , 7 , 0 ]

let s:IA = [ s:IN1[1] , s:IN2[1] , s:IN1[3] , s:IN2[3] , '' ]
let g:airline#themes#ryuuko#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

" Warnings
let s:WI = [ '#feffff', 'NONE', 7, 0, 'bold' ]
let g:airline#themes#ryuuko#palette.normal.airline_warning = s:WI
let g:airline#themes#ryuuko#palette.insert.airline_warning = s:WI
let g:airline#themes#ryuuko#palette.visual.airline_warning = s:WI
let g:airline#themes#ryuuko#palette.replace.airline_warning = s:WI

" Tabline
let g:airline#themes#ryuuko#palette.tabline = {
      \ 'airline_tab':     [ '#feffff' , '#2d2b33'    , 7, 0 , 'NONE' ],
      \ 'airline_tabsel':  [ '#feffff' , '#2d2b34'	  , 7, 0 , 'bold' ],
      \ 'airline_tabtype': [ '#feffff' , '#2d2b33'    , 7, 0 , 'NONE' ],
      \ 'airline_tabfill': [ '#feffff' , '#2d2b33'    , 7, 0 , 'NONE' ],
      \ 'airline_tabmod':  [ '#feffff' , '#2d2b33'    , 7, 0 , 'bold' ]
\ }
