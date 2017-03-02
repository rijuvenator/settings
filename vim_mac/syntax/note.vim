" Syntax for .note files
" Folds between {{{ and }}}
" Smart indent and 2 space tabs
" ^Whitespace are tabs or groups of 2 spaces
" H1 are ^==                         ; bold blue
" H2 are ^===                        ; blue
" list bullets are ^Whitespace - or *; darkblue
" warnings are ^Whitespace!          ; bold red
" green are ^#                       ; darkgreen
" red are between []                 ; red
" magenta are between ``             ; magenta
" cyan are between {}                ; darkcyan
" bold are between --                ; bold
"
if exists("b:current_syntax")
	finish
endif

syntax match CSC   /\<ME[mp+-]*[0-9/_-]*\>/
syntax match VME   /\<VME[mp+-]*[0-9/_-]*\>/
syntax match Arrow /=>/
syntax match URL   `\v<(((https?|ftp|gopher)://|(mailto|file|news):)[^'    <>"]+|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.[^'    <>"]+)[a-z0-9/]`
syntax keyword Component ALCT[s] CFEB[s] DCFEB[s] TMB[s] OTMB[s] DMB[s] ODMB[s] FED[s] CSC[s] CCB[s]
syntax match   Component /\<D\=CFEB\d\>/

syntax match Heading1  /^== .*/
syntax match Heading2  /^=== .*/
syntax match ListDash  /^\(\t\|  \)\+-/
syntax match ListStar  /^\(\t\|  \)\+\*/
syntax match ListNum   /^\(\t\|  \)\+\d\+)/
"syntax match ListCheck /^\(\t\|  \)\+\[[ x]*\]/
syntax match Warning   /^\(\t\|  \)*!.*/
syntax match Comm      /^\(\t\|  \)*#.*/
syntax match Important /\[.\{-}\]/hs=s+1,he=e-1
syntax match PinkNote  /\`.\{-}\`/hs=s+1,he=e-1
syntax match CyanNote  /{.\{-}\}/hs=s+1,he=e-1
syntax match GreenNote /\~.\{-}\~/hs=s+1,he=e-1
syntax match BlueNote  /%.\{-}%/hs=s+1,he=e-1
syntax match Bold      /_.\{-}_/hs=s+1,he=e-1
"syntax region Important start=/\[/ end=/\]/
"syntax region PinkNote  start=/\`/ end=/\`/
"syntax region CyanNote  start=/{/  end=/}/
"syntax region GreenNote start=/\~/ end=/\~/
"syntax region BlueNote  start=/%/  end=/%/
"syntax region Bold      start=/_/  end=/_/

highlight link CSC       DarkMagenta
highlight link VME       DarkMagenta
highlight link Arrow     Gray
highlight link URL       DarkBlueUnderl
highlight link Component Orange

highlight link Heading1  BoldBlue
highlight link Heading2  Blue
highlight link ListDash  DarkBlue
highlight link ListStar  DarkBlue
highlight link ListNum   DarkBlue
"highlight link ListCheck DarkBlue
highlight link Warning   BoldRed
highlight link Comm      BoldDarkGreen
highlight link Important Red
highlight link PinkNote  Magenta
highlight link CyanNote  DarkCyan
highlight link GreenNote DarkGreen
highlight link BlueNote  Blue
