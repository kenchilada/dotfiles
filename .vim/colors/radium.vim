" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "pablo"

"NR-16   NR-8    COLOR NAME ~
"0	    0	    Black
"1	    4	    DarkBlue
"2	    2	    DarkGreen
"3	    6	    DarkCyan
"4	    1	    DarkRed
"5	    5	    DarkMagenta
"6	    3	    Brown, DarkYellow
"7	    7	    LightGray, LightGrey, Gray, Grey
"8	    0*	    DarkGray, DarkGrey
"9	    4*	    Blue, LightBlue
"10	    2*	    Green, LightGreen
"11	    6*	    Cyan, LightCyan
"12	    1*	    Red, LightRed
"13	    5*	    Magenta, LightMagenta
"14	    3*	    Yellow, LightYellow
"15	    7*	    White

let perl_extended_vars = 1
let perl_fold = 1
let perl_fold_blocks = 1
"unlet perl_include_pod 
"unlet perl_want_scope_in_variables
"unlet perl_string_as_statement
"unlet perl_no_sync_on_sub
"unlet perl_no_sync_on_global_var
let perl_sync_dist = 100

"cterm=bold,underline,reverse,inverse,italic,standout,NONE

"comments... duh
highlight Comment		ctermfg=darkblue

"variable names
highlight Identifier	ctermfg=white

"operators and language syntax
highlight Statement		ctermfg=yellow

"function names, quotes, hash keys
highlight Normal		ctermfg=grey

"strings
highlight Constant		ctermfg=darkcyan

"enclosing parentheses and braces
highlight Special		ctermfg=magenta

"what
highlight PreProc		ctermfg=green ctermbg=yellow

"affects -> on objects
highlight Type			ctermfg=grey

"status bar in active window
highlight StatusLine	ctermfg=white ctermbg=darkcyan cterm=bold

"search highlight color
highlight Search		ctermfg=white ctermbg=darkblue

highlight Todo			ctermfg=black ctermbg=3
"highlight Error			ctermbg=red
"highlight Directory	ctermfg=2 guifg=#00c000

highlight perlSharpBang			ctermfg=darkyellow
highlight perlPackageDecl		ctermfg=yellow ctermbg=green
highlight perlStatementPackage	ctermfg=black ctermbg=green 

highlight perlStatementScalar	ctermfg=magenta
"highlight perlStatementInclude	ctermfg=magenta

" die carp dump eval exit wantarray (throw, which I added)
highlight perlStatementFlow 	ctermfg=darkred cterm=underline

" last next redo goto return
highlight perlStatementControl	ctermfg=red

" my local our
highlight perlStatementStorage 	ctermfg=lightgreen cterm=bold

"highlight perlType				ctermfg=magenta cterm=underline
"highlight perlPackageRef		ctermfg=red
"highlight perlRepeat 			ctermfg=green cterm=underline
highlight perlConditional		ctermfg=darkmagenta
highlight perlMethod			ctermfg=darkyellow
"highlight perlStatementSub		ctermfg=yellow cterm=reverse

" __DATA__
highlight perlDATA				ctermfg=darkgray

