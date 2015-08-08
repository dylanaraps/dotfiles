" Normal mode
let s:N1 = [ '#080808' , '#6f8e9a' , 15 , 55  ]
let s:N2 = [ '#080808' , '#2d4963' , 15 , 98  ]
let s:N3 = [ '#a3a69a' , '#080808' , 15 , 233 ]

" Insert mode
let s:I1 = [ '#080808' , '#9dae71' , 15 , 33  ]
let s:I2 = [ '#080808' , '#3b4a35' , 15 , 39  ]
let s:I3 = [ '#a3a69a' , '#080808' , 15 , 233 ]

" Visual mode
let s:V1 = [ '#080808' , '#d8c27a' , 233 , 202 ]
let s:V2 = [ '#080808' , '#4d3c2e' , 233 , 214 ]
let s:V3 = [ '#a3a69a' , '#121212' , 15  , 233 ]

" Replace mode
let s:R1 = [ '#080808' , '#b59cd8' , 15 , 196 ]
let s:R2 = [ '#080808' , '#564059' , 15 , 203 ]
let s:R3 = [ '#a3a69a' , '#080808' , 15 , 233 ]

let g:airline#themes#crayon#palette = {}
let g:airline#themes#crayon#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#crayon#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#crayon#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#crayon#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Inactive mode
let s:IN1 = [ '#a3a69a' , '#191919' , 247 , 241 ]
let s:IN2 = [ '#a3a69a' , '#080808' , 15  , 233 ]

let s:IA = [ s:IN1[1] , s:IN2[1] , s:IN1[3] , s:IN2[3] , '' ]
let g:airline#themes#crayon#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

" Tabline
let g:airline#themes#crayon#palette.tabline = {
      \ 'airline_tab':     [ '#080808' , '#6f8e9a' ,  15 , 55  , 'bold' ],
      \ 'airline_tabsel':  [ '#080808' , '#6f8e9a' ,  15 , 98  , 'bold' ],
      \ 'airline_tabtype': [ '#080808' , '#6f8e9a' ,  15 , 98  , 'bold' ],
      \ 'airline_tabfill': [ '#a3a69a' , '#080808' ,  15 , 233 , 'bold' ],
      \ 'airline_tabmod':  [ '#080808' , '#9dae71' ,  15 , 33  , 'bold' ]
\ }
