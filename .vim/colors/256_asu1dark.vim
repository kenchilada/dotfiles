" NOTE: this is not the original file! converted for use with xterm-256
" Vim color file
" Maintainer:   A. Sinan Unur
" Last Change:  2001/10/04

" Dark color scheme

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="256_asu1dark"

" GUI Color Scheme
hi Normal       cterm=none     ctermfg=248 ctermbg=16
hi NonText      cterm=none     ctermfg=210	 ctermbg=16
hi Function     cterm=none     ctermfg=105	 ctermbg=233	
hi Statement    cterm=bold     ctermfg=11	 ctermbg=233	
hi Special      cterm=none     ctermfg=14	 ctermbg=233	
hi Constant     cterm=none     ctermfg=208	 ctermbg=233	
hi Comment      cterm=none     ctermfg=114	 ctermbg=233	
hi Preproc      cterm=none     ctermfg=83	 ctermbg=233	
hi Type         cterm=none     ctermfg=204	 ctermbg=233	
hi Identifier   cterm=none     ctermfg=14	 ctermbg=233	
hi StatusLine   cterm=bold     ctermfg=15	 ctermbg=58	
hi StatusLineNC cterm=none     ctermfg=0	 ctermbg=252	
hi Visual       cterm=none     ctermfg=15	 ctermbg=35	
hi Search       cterm=bold     ctermbg=11	 ctermfg=19	
hi VertSplit    cterm=none     ctermfg=15	 ctermbg=241	
hi Directory    cterm=none     ctermfg=10	 ctermbg=233	
hi WarningMsg   cterm=standout ctermfg=20	 ctermbg=11	
hi Error        cterm=none     ctermfg=15	 ctermbg=9	
hi Cursor                      ctermfg=15	 ctermbg=47	
hi LineNr       cterm=none     ctermfg=252	 ctermbg=233
hi ModeMsg      cterm=none     ctermfg=21	 ctermbg=15	
hi Question     cterm=none     ctermfg=84	 ctermbg=233	

hi StatusLine	cterm=none ctermfg=226 ctermbg=237
hi StatusLineNC cterm=none ctermfg=94 ctermbg=235

hi Search		ctermfg=202 ctermbg=232 cterm=underline,reverse,italic
hi Visual		ctermbg=172 ctermfg=232

hi Statement	ctermfg=136
hi Folded		ctermfg=95 ctermbg=233
hi Constant		ctermfg=124 ctermbg=232
hi PreProc		ctermfg=127 ctermbg=232
hi Type			ctermfg=40 ctermbg=232 cterm=underline
hi Comment		ctermfg=24 ctermbg=232

hi Macro		ctermfg=163

hi cType		cterm=none
hi cStorageClass ctermfg=119
hi cStruct 		ctermfg=76
hi cFunction	ctermbg=233 ctermfg=130
hi cIdentifier	ctermfg=248
"hi c89Identifier
"hi cEllipses

hi Conditional cterm=none ctermfg=224 ctermbg=233
hi Operator cterm=none ctermbg=232 ctermfg=64
hi c89Statement ctermfg=92
hi cRepeat ctermbg=233 ctermfg=184
hi cLabel ctermfg=177



