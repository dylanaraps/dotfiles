" =============================================================================
" Filename: autoload/lightline/colorscheme/ryuuko.vim
" Author: dylan araps
" =============================================================================
let s:white = '#f2f3f2'
let s:black = '#34393D'
let s:darkblack = '#2d2b33'
let s:gray = '#75747a'
let s:red = '#BF687F'
let s:orange = '#E68A8B'
let s:yellow = '#e5c196'
let s:green = '#9BB38F'
let s:cyan = '#a9cdd9'
let s:blue = '#8294b4'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:blue, s:black, 'bold' ], [ s:gray, s:black ] ]
let s:p.normal.right = [ [ s:gray, s:black ], [ s:gray, s:black ] ]
let s:p.normal.middle = [ [ s:black, s:black ] ]
let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]

let s:p.inactive.right = [ [ s:black, s:black ], [ s:black, s:black ] ]
let s:p.inactive.left =  [ [ s:black, s:black ], [ s:black, s:black ] ]
let s:p.inactive.middle = [ [ s:black, s:black ] ]

let s:p.insert.left = [ [ s:green, s:black, 'bold' ], [ s:gray, s:black ] ]
let s:p.insert.right = [ [ s:gray, s:black ], [ s:gray, s:black ] ]

let s:p.replace.left = [ [ s:red, s:black, 'bold' ], [ s:gray, s:black ] ]
let s:p.replace.right = [ [ s:gray, s:black ], [ s:gray, s:black ] ]

let s:p.visual.left = [ [ s:orange, s:black, 'bold' ], [ s:gray, s:black ] ]
let s:p.visual.right = [ [ s:gray, s:black ], [ s:gray, s:black ] ]

let s:p.tabline.left = [ [ s:gray, s:black ] ]
let s:p.tabline.tabsel = [ [ s:black, s:blue ] ]
let s:p.tabline.middle = [ [ s:gray, s:black ] ]
let s:p.tabline.right = copy(s:p.normal.right)

let g:lightline#colorscheme#ryuuko#palette = lightline#colorscheme#fill(s:p)
