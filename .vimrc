" vim: fdm=marker:fen:fdn=3:foldcolumn=3
"
" !! Things broken? Try :PlugInstall
" !! Things ugly? Select a powerline font for your terminal
"
" Help Help:
" :help {subject}
" - Supports wildcards in {subject} (ie. * ? [a-z])
" - Use <CTRL-D> to do completion on partial {subject}'s on the commandline
" - Regex searches can be done with ":tag {pattern}" in the help window, then
"   use ":tnext" to jump to other matches, or ":tselect" to list matches and
"   choose one
" - Use ":helpgrep" to make a list of lines that match {pattern}, and jump to
"   the first match; navigate further matches with "|quickfix|" commands, e.g.,
"   use ":cnext" to jump to the next one; use ":cwindow" to view the list of
"   matches in a quickfix window
" - Type <CTRL-]> to jump to a subject for the tag the cursor is on
" - Type <CTRL-T> or <CTRL-O> to jump back

" Registers: (very useful with CTRL+R in insert mode)
"  '"'	contains text of last delete or yank
"  '%'	current filename
"  '#'	alternate filename (huh?)
"  '*'	clipboard contents
"  '+'	clipboard contents
"  '/'	the last search pattern
"  ':'	the last command-line
"  '.'	the last inserted text
"  '-'	the last small (less than a line) delete
"  '='	expression register

" INSERT Mode Tips:
"
" * Useful
" - Press <CTRL-O> to switch to COMMAND mode until a single command is run, then
"   return directly to INSERT mode
" - use <CTRL-C> or <CTRL-[> to exit INSERT mode (same as <ESC>)
" - <CTRL-V> inserts next non-digit literally; special keys inserted as term code
" - <CTRL-Y> will insert the character directly above cursor
" - <CTRL-E> inserts character directly below cursor
" - <CTRL-A> will re-insert the text inserted in the previous insert session
" - <CTRL-U> will delete from start of line to cursor position
" - <CTRL-T> inserts one shiftwidth of indent at the start of the current line
" - <CTRL-D> deletes one shiftwidth of indent at the start of the current line
" - <CTRL-R>{char} inserts contents of register identified by {char}
" - <CTRL-W> will delete the word before the cursor
" - <CTRL-I> inserts a tab character
"
" * Movement:
" - <CTRL-G>k, <CTRL-G><CTRL-K>: cursor one line up, insert start column
" - <CTRL-G>j, <CTRL-G><CTRL-J>: cursor one line down, insert start column
"
" * Less useful:
" - <CTRL-H> acts like backspace; deletes character before cursor
" - <CTRL-J> and <CTRL-M> begin a new line
" - <CTRL-N> and <CTRL-P> will jump to next/previous keyword (completion?)
" - <CTRL-R><CTRL-R>{char} insert register, inserts text literally
" - <CTRL-R><CTRL-O>{char} insert register literally and don't auto-indent
" - <CTRL-R><CTRL-P>{char} insert register literally and fix the indent
"

" {{{1 Vim Tips
" -------------------------------------------------------------------------------
" Visual Mode: {{{2
"
"    V}J                             : Join Visual block (great)
"    V}gJ                            : Join Visual block w/o adding spaces
"    `[v`]                           : Highlight last insert
"    :%s/\%Vold/new/g                : Do a substitute on last visual area [N]

" -------------------------------------------------------------------------------
" Text Objects: {{{2
" Commands starting with "iX" operate on inner text excluding leading and
" trailing whitespace, while "aX" will include leading and trailing whitespace.
" Mnemonics... i="inner object, a="an object".  See ":help text-objects".
"
" objects:
"    aw iw					: select count |word|
"    aW iW					: select count |WORD|
"    as is					: select count |sentence|
"    ap ip					: select count |paragraph|
"    a] a[ i] i[			: select count [] blocks
"    a) a( i) i( ab ib		: select count () blocks
"    a> a< i> i<			: select count <> blocks
"    a} a{ aB i{ i} iB		: select count {} blocks
"    at it					: select count |tag-blocks|
"    a" a' a` i" i' i`		: select count quoted strings
"
"
" examples:
"    diB   daB         : empty a block {}
"    das               : delete a statement or sentence
"    daW               : delete contiguous non whitespace
"    di<   yi<  ci<    : Delete/Yank/Change HTML tag contents
"    da<   ya<  ca<    : Delete/Yank/Change whole HTML tag
"    dat   dit         : Delete HTML tag pair
"

" Color At Cursor: {{{2
" Display RGB colour under the cursor eg #445588
"    :nmap <leader>c :hi Normal guibg=#<c-r>=expand("<cword>")<cr><cr>

" -------------------------------------------------------------------------------
" RegEx Greed: {{{2
" Non-greedy regex, use assinine \{-} operator
"    s/.\{-}foo/bar/
"    s/\_\{-}thee/thou/

" -------------------------------------------------------------------------------
" Start Substitute With Word At Cursor: {{{2
" Pull word under cursor into LHS of a substitute
"    :nmap <leader>z :%s#\<<c-r>=expand("<cword>")<cr>\>#
"
" Pull Visually Highlighted text into LHS of a substitute
"    :vmap <leader>z :<C-U>%s/\<<c-r>*\>/

" -------------------------------------------------------------------------------
" Number Manipulation: {{{2
" Decrement numbers by 3
"    :%s/\d\+/\=(submatch(0)-3)/
"
" Increment numbers by 6 on certain lines only
"    :g/loc\|function/s/\d/\=submatch(0)+6/

" Rename a string with an incrementing number
"    :let i=10 | 'a,'bg/Abc/s/yy/\=i/ |let i=i+1 # convert yy to 10,11,12 etc

" -------------------------------------------------------------------------------
" Global Command Sorcery: {{{2
"
"    :g/gladiolli/#              : display matches and line numbers
"    :g/\<fred\>/                : display all lines fred but not freddy

" Do stuff to range of lines between two matches...
"    :g/joe/,/fred/d             : not line based (very powerfull)
"    :g/fred/,/joe/j             : Join Lines [N]
"
"    :g/-------/.-10,.d          : Delete string & 10 previous lines

" Combining g// with normal mode commands
"    :g/|/norm 2f|r*                      : replace 2nd | with a star

" -------------------------------------------------------------------------------
" Stacked Search: {{{2
" Find fred before beginning search for joe
"    :/fred/;/joe/-2,/sid/+3s/sally/alley/gIC

" -------------------------------------------------------------------------------
" Operate Until Match: {{{2
"    d/fred/                                :delete until fred
"    y/fred/                                :yank until fred
"    c/fred/e                               :change until fred, end

" -------------------------------------------------------------------------------
" Motions And Commands: {{{2
" A motion command can be used after an operator command to have the command
" operate on the text that was moved over.  Motions are either inclusive or
" exclusive. Inclusive motions include the start and end positions in the
" operation.  Exclusive motions do not include the last character towards the
" end of the buffer.  Linewise motions always include start and end position.
"
" OPERATOR COMMANDS:
"	c	: change
"	d	: delete
"	y	: yank
"	g~	: swap case
"	gu	: make lowercase
"	gU	: make uppercase
"	!	: filter through external program
"	gq	: text formatting
"	>	: shift right
"	<	: shift left
"	zf	: define a fold
"
" LEFT RIGHT MOTION COMMANDS:
"	v, V, CTRL-V		: force motion to be linewise, characterwise, or blockwise
"	h, l				: [count] characters to the left or right (exclusive)
"	0					: to the first character of the line (exclusive)
"	^					: to the first non-blank character of the line (exclusive)
"	$, <End>			: to the end of the line and [count - 1] lines downward (inclusive)
"	g_					: like $, but to the last non-blank character (inclusive)
"	g0, g^, gm, g$		: wtf?
"	|					: to screen column [count] in the current line
"	f{char}				: to [count]'th occurence of {char} to the right (inclusive)
"	F{char}				: same as f{char}, but to the left (exlusive)
"	t{char}				: till beforee [count]'th occurence of {char} to the right (inclusive)
"	T{char}				: same as t{char}, but to the right
"	;					: repeat latest f, t, F, or T [count] times
"	,					: like semicolon above, but in opposite direction
"
" UP DOWN MOTION COMMANDS:
" 	k, j				: [count] lines upwards or downward (linewise)
" 	gk, gj				: [count] display lines upward or downward (exclusive)
" 	-, +				: [count] lines upward or downward, on the first non-blank character (linewise)
" 	_					: [count] - 1 lines downward
" 	G, <C-End>			: goto line [count], default last line, on the first or last non-blank character
" 	gg					: goto line [count], default first line, on the first non-blank character (linewise)
" 	{count}%			: goto {count} percentage in the file
" 	:[range]go [count]	: goto {count} byte in the buffer; default count is one, start of the file
"
" WORD MOTION COMMANDS:
"	w, e				: [count] words forward or backward (exclusive)
"	W, E				: [count] WORDS forward or backward (inclusive)
"	b, B				: [count] WORDS backward (exclusive)
"	ge, gE				: backward to the end of word or WORD [count] (inclusive)
"
" TEXT OBJECT MOTION COMMANDS:
"	(, )				: [count] sentences back or forward (exclusive)
"	{, }				: [count] paragraphs back or forward (exclusive)
"	]], ][, [[, []		: [count] sections forward or back, or to the next '{' in the first column
"
" MARKS:
"	m{a-zA-Z}			: set mark at cursor position
"	m' m`				: set the previous context mark
"	m[, m]				: set the '[ or '] mark
"	'{a-z}, `{a-z}		: jump to mark in current buffer
"	'{A-Z}, `{A-Z}		: jump to mark in the file where it was set
"	g'{mark} g`{mark}	: jump to mark without changing jump list
"	:marks {arg}		: list marks, limit to those mentioned in {arg} if given
"	:delmarks {marks}	: delete specified marks
"	'[, `[, '], `]		: to the first or last character of the previously changed or yanked text
"	'<, `<, '>, `>		: to the first or last character of the last selected Visual area
"	'', ``				: to the position before the latest jump
"	'", `"				: to the cursor position when last exiting the current buffer
"	'^, `^				: to the position where the cursor was the last time when Insert mode was stsopped
"	'., `.				: to the position where the last change was made
"	'{, `{, '}, `}		: to the start or end of the current paragraph
"	'(, `(, '), `)		: to the start or end of the current sentences
"
" OTHER MOTIONS:
"	%					: jump to [count] next matching ([{}]) /* */ #if, #ifdef, #else, #elif, $endif
"	[(, [{, ]), ]}		: go to [count] start or end of current code block (cursor can be anywhere in the block)
"	[m, ]M, ]m, [M		: go to [count] start or end of a method (works for stuff like Java)
"	[#, ]#				: go to [count] next or previous unmatched "#if" or "#else"
"	[*, [/, ]*, ]/		: go to [count] next or previous start of a C comment, "/*" or "*/"
"
" Markers And Movements: {{{2
" See ":help jump-motions" and ":help changelist"
"
"    '.               : jump to last modification line (SUPER)
"    `.               : jump to exact spot in last modification line
"    g;               : cycle thru recent changes (oldest first)
"    g,               : reverse direction
"    :changes
"    <C-O>            : retrace your movements in file (starting from most recent)
"    <C-I>            : retrace your movements in file (reverse direction)
"    :ju(mps)         : list of your movements
"    :history         : list of all your commands
"    :his c           : commandline history
"    :his s           : search history
"    q/               : Search history Window (puts you in full edit mode) (exit "    CTRL-C)
"    q:               : commandline history Window (puts you in full edit mode) "    (exit CTRL-C)
"    :<C-F>           : history Window (exit CTRL-C)
"
" -------------------------------------------------------------------------------

" }}}
" Jumps: {{{2
" A jump is a command that remembers the cursor position before moving the
" cursor somewhere.
"
" These commands are jumps:
"    ' ` G / ? n N % ( ) [[ ]] { } :s :tag L M H
"
" You can return to a jump position with "''" and "``" commands
"
" CTRL-O
" 	Go to [count] older cursor position in the jump list
"
" CTRL-I or <Tab>
" 	Go to [count] newer cursor position in the jump list
"
" Use the :ju[mps] command to print the jump list
"
" The :keepjumps modifier does something... ?
"
" CHANGE JUMP
" There is another jump list kept for changes (use :changes to print it)
"
" Jump to positions with the g; and g, commands
"
" ==========================================================================
"
"}}}
" -------------------------------------------------------------------------------
" }}}

" -------------------------------------------------------------------------------
" {{{1 ABBREVIATIONS

" common typos
iabbrev tihs this
iabbrev slef self
iabbrev teh th

" {{{1 SETTINGS

set nocompatible					" disable vi compatibility mode
let mapleader=","					" defines the mapleader; referred to in vim docs as <leader> (default '\')
set ttimeoutlen=10					" milliseconds to wait for a key sequence to complete

" default updatetime 4000ms is not good for async update
set updatetime=100
set signcolumn=auto

set encoding=utf-8
"set fileencoding=utf-8
set termencoding=utf-8

set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab						" if enabled, insert spaces for tabs in insert mode
set smarttab						" umm... see docs
set nostartofline					" move cursor to first non-blank of line for various movements

" text formatting
set autoindent
set nosmartindent
set nocindent						" indenting based on C structure
set iskeyword+=						" additional chars that split words
set formatoptions+=					" vim default is 'tcq', see |fo-table| in docs
set textwidth=80					" wrap after this many characters; applies to text or comments when formatoptions includes 't' or 'c'
set copyindent						" copy structure of indentation when autoindenting new line
set backspace=indent,eol,start		" controls how <BS> and <Del> work in insert mode

" configure command mode stuff
set wildmenu						" show command completion as you type
set wildmode=list:longest,full		" settings for wildmenu
set wildchar=<Tab>
set cmdheight=1						" lines used for command line
set history=2000					" more scrollback for ex history

" file-related actions
set hidden							" allows you to switch buffers even if the current one is modified
set confirm							" asks for confirmation when performing a command that would otherwise abort
set report=0						" threshold for reporting number of lines changed (0 for always)
set shortmess=atI					" affects various messages that are displayed (read help)
set modeline						" parse vim modelines found in files
set autoread						" reload files changed outside of vim have not changed inside of vim

" configure display stuff
set nowrap							" do wrapping of long lines?
set ruler							" use ruler?
set showcmd							" show partial command in last line of the screen
set cursorline						" highlight current line
set noeb visualbell t_vb=			" disable annoying beeping and screen flashing on error
set nolazyredraw					" if set, screen is not redrawn during macros, registers, etc
set number							" show line numbers in gutter
set scrolloff=3						" show more context lines when cursor goes outside of viewport
set display=uhex					" comma-separated-list; may contain 'uhex' and/or 'lastline' (:help 'display')
set splitright						" if on, splitting a window puts the new window to the right of the current one
set ttyfast							" optimize for fast terminal
set laststatus=2					" show status line: 0=never, 1=if two or more windows, 2=always

set fillchars+=vert:\|				" sets characters used to draw various items
"set fillchars+=fold:·,vert:\|

set helpheight=9999 				" minimum height in lines of a help window

"{{{2 Mouse

" use the mouse in vim; works in some terminals; supports wheel scrolling, text
" selection, and (if x-server is available) copy selection to system clipboard
if has("mouse")
	set mouse=a

	" copy selection to clipboard when mouse is released
	"noremap <LeftRelease> "+y<LeftRelease>
endif

"{{{2 Tab Pages

"" TODO: read about tagpage features in vim and set this up (instead of minibuffexplorer?)
if version >= 700
	set tabpagemax=30
endif

"{{{2 Backups and Swapfiles

" sets what gets stored in viminfo file
set viminfo='100,f1,:100,@100,/20

" list of places to try to store swapfiles
set directory=$HOME/.vim-tmp,$HOME/tmp,.
set swapfile

set backup
set backupcopy=yes
if empty(glob($HOME . '/.vim/backups'))
	call mkdir($HOME . "/.vim/backups", "p")
endif
set backupdir=$HOME/.vim/backups
set writebackup

" vim 7.3 writes *.un~ files for persistent undo
set undodir=$HOME/.vim-tmp

"{{{2 Folding

set foldmethod=marker
set foldcolumn=0			" width of the column at screen left used to display fold hierarchy (default 0)
set foldlevelstart=1
"set foldtext=FoldText()	" expression used to specify text displayed for a closed fold

"{{{2 Search

set ignorecase				" ignore case in searches
set smartcase				" do case-sensitive search if there is a capital letter in the search pattern
set wrapscan				" search commands wrap around end of buffer

set showmatch				" jumps to a matching bracket if inserted
set mat=5					" duration to stay on matching brace for showmatch (1 = 100ms)

if has("extra_search")
	set noincsearch			" show partial match for search as you type
	set hlsearch			" highlight search mappings (see mappings for this below)
endif

"{{{2 GUI

" is this possibly Windows?
if has("gui_win32") || ! has("unix")
	let g:LustyJugglerSuppressRubyWarning = 1
	" need to create windows environment var HOME=%HOMEDRIVE%%HOMEPATH%
	if isdirectory($HOME)
		set runtimepath=$HOME/.vim,$VIMRUNTIME
	endif
endif

if has("gui")
	" gVim: these skip the goofy menus
	let did_install_default_menus = 1
	let did_install_syntax_menu = 1

	" Windows?
	if has("gui_win32") || ! has("x11")
		set guifont=Courier_New:h11:cDEFAULT
		set guifont=Droid\ Sans\ Mono\ for\ Powerline:h10
		"set guifont=Inconsolata\ for\ Powerline:h12
	endif
endif

"{{{2 Filetype

"
" For info on this stuff, read this....
" 	:help :filetype-overview
"
filetype on					" enable filetype detection
filetype indent on			" enable loading the indent file for specific file types (also does 'filetype on')
if has("unix")
	filetype plugin on		" enable use of filetype plugins (see ~/.vim/ftplugin/)
endif

"{{{2 Statusline

set statusline=
if version >= 700
	set statusline+=%*%1*
	set statusline+=%1*%8*%3n%1*\:%<\ %2*%F			" buffer number, filename
	"set statusline+=%1*\ [%4*%Y%R%M%1*]				" flags for buffer
	"set statusline+=%1*\ %6*byte:0x%B
	"set statusline+=%1*\ %6*pos:0x%o

	set statusline+=%1*\ %=
	set statusline+=%1*\ %3*line:%l\/%L				" line number, total lines
	set statusline+=%1*\ %2*F:%{&foldlevel}			" line number, total lines
	set statusline+=%1*\ %1*%7*C\:%03c				" column number
	set statusline+=%1*\ %4*%p%%
	set statusline+=%1*\ %*
else
	set statusline+=%n:%F\ (line:%l/%L\ byte:0x%B)\ %r%y
endif



""{{{2 list mode
"
"" sets characters used to display non-printables when 'set list' is on
""	eol: end of line
""	tab: a tab, default is ^I
""	extends: shown at the end of a line when it wraps to the next
""	precedes: shown at beginning of line when line continues a wrapped line
""	nbsp: non breaking space character 0xA0
""	trail: shown for trailing space
""
"set listchars=eol:$
"if (&termencoding == "utf-8") || has("gui_running")
"	set listchars+=tab:▸·,trail:█,extends:…
"else
"	set listchars+=tab:>-,trail:.,extends:>
"endif
"
"" stolen from http://github.com/ciaranm/dotfiles-ciaranm/tree/master
"if (&termencoding == "utf-8") || has("gui_running")
"	if v:version >= 700
"		set list listchars+=precedes:…,nbsp:‗
"	endif
"endif
"
"set nolist

"}}}

" {{{1 SYNTAX COLORSCHEME
" ---------------------------------------------------------------------
"

"
" The 't_Co' variable is the terminfo setting that says how many colors the term
" supports.  Usually "xterm" supports only eight colors.  Changing the value of
" 't_Co' will override the system term settings.  Check term settings on your
" system using this command:
" 		$ infocmp -1L xterm |grep max_colors
"
" If you are seeing problems with the background color (such as the background
" color not continuing past the right-most character of each line), check that
" your term type has "bce" enabled.  If you are inside of GNU screen, make sure
" you enable "defbce" in .screenrc.  You and see term capabilities in screen by
" using the :info command.
"

if &t_Co > 2 || has("gui_running")
	set t_Co=16
	syntax on
endif

" because screen still needs it...
if ! has("gui_running")
	set t_Co=256
endif

if $TERM == "cygwin"
	color desert
else
	let g:molokai_original = 1
	color molokai
endif

" setup statusline after colorscheme is loaded or user highlights are wiped
if version >= 700
	hi StatusLine ctermbg=53 ctermfg=white cterm=bold
	hi StatusLineNC ctermbg=239 ctermfg=111 cterm=bold
	hi LineNr ctermfg=236 ctermbg=233

	hi User1 ctermfg=white ctermbg=53
	hi User2 ctermfg=112 ctermbg=53
	hi User3 ctermfg=blue ctermbg=53
	hi User4 ctermfg=yellow ctermbg=53
	hi User5 ctermfg=green ctermbg=53

	" 6:gray 7:purple
	hi User6 ctermfg=242 ctermbg=53
	hi User7 ctermfg=135 ctermbg=53

	hi User8 ctermfg=208 ctermbg=53
endif

" ---------------------------------------------------------------------
" {{{1 AUTOCOMMANDS
" ---------------------------------------------------------------------
"
"if has("autocmd")
"	" Use perl compiler for all *.pl and *.pm files.
"	" See ~/.vimrc/compiler/perl.vim, and
"	"   http://www.vim.org/scripts/script.php?script_id=56
"	"
"	" the 'so' commands load a script that enables testing shortcuts
"	" 	,t ,w ,W
"	"
"	autocmd BufNewFile,BufRead *.p? compiler perl
"	autocmd BufNewFile,BufRead *.t set filetype=perl | compiler perl
"
"	autocmd BufNewFile,BufRead *.rl set filetype=ragel | foldmethod=marker
"	autocmd BufNewFile,BufRead *.c set foldmethod=syntax
"
"	" regenerate ctags when php file is changed
"	au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
"
"	" automatically change to the directory of the current file
"	"autocmd BufEnter * silent! lcd %:p:h
"endif

" ---------------------------------------------------------------------
" {{{1 SYNTAX SETTINGS
" ---------------------------------------------------------------------
"
" Perl:
let perl_want_scope_in_variables=1
let perl_extended_vars=1
"let perl_fold=1
"let perl_include_pod=1
"unlet perl_string_as_statement
"unlet perl_no_sync_on_sub
"unlet perl_no_sync_on_global_var
"let perl_sync_dist = 100
"unlet perl_fold_blocks
"
" PHP:
let g:php_sql_query = 1
let g:php_htmlInStrings = 1
let g:php_baselib = 1
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_folding = 2
"
" C:
"let c_C99=1
"

" ---------------------------------------------------------------------
" {{{1 HIGHLIGHTING
" ---------------------------------------------------------------------
"
" highlighting of the stuff in the minibufexplorer window can be configured by
" changing these highlight groups
"
"                 MBENormal         - for buffers that have NOT CHANGED and
"                                     are NOT VISIBLE.
"                 MBEChanged        - for buffers that HAVE CHANGED and are
"                                     NOT VISIBLE
"                 MBEVisibleNormal  - buffers that have NOT CHANGED and are
"                                     VISIBLE
"                 MBEVisibleChanged - buffers that have CHANGED and are VISIBLE
"
"highlight link MBENormal Folded
"highlight MBEVisibleNormal ctermfg=118 ctermbg=235
"highlight MBEVisibleChanged ctermfg=darkred
"
" MiniBufExpl Colors (since https://github.com/fholgado/minibufexpl.vim)
"hi MBENormal guifg=#808080 guibg=fg
"hi MBEChanged guifg=#CD5907 guibg=fg
"hi MBEVisibleNormal guifg=#5DC2D6 guibg=fg
"hi MBEVisibleChanged guifg=#F1266F guibg=fg
"hi MBEVisibleActive guifg=#A6DB29 guibg=fg
"hi MBEVisibleChangedActive guifg=#F1266F guibg=fg

"
highlight MatchParen ctermbg=22 ctermfg=7
highlight Search term=reverse ctermbg=3 ctermfg=0
highlight perlStatementControl ctermfg=darkred
"highlight Folded	ctermbg=darkred ctermfg=4 cterm=bold

highlight Todo ctermfg=208 cterm=reverse

" affects non-printable characters when in list mode (see :help 'listchars' and
" :help 'list' for more info).
"
" used for showing end-of-line placeholders
highlight NonText ctermfg=54 ctermbg=232
" used to show unprintable chars such as tabs or escape sequences, and also
" for showing meta and special keys listed with ":map"
highlight SpecialKey ctermbg=202 ctermfg=234 cterm=reverse
highlight IncSearch ctermfg=196 ctermbg=0 cterm=reverse

highlight MBEVisibleChangedActive ctermbg=20 ctermfg=196
highlight MBEVisibleChanged ctermbg=235 ctermfg=160
highlight MBEChanged ctermbg=0 ctermfg=160

highlight MBEVisibleActive ctermbg=20 ctermfg=226
highlight MBEVisibleNormal ctermbg=232 ctermfg=253
highlight MBENormal ctermbg=232 ctermfg=253

" {{{1 FUNCTIONS
"------------------------------------------------------------------------------

function! GetCWD()
	"let curdir=getcwd()
	let curdir=substitute(getcwd(), '/home/ken/', "~", "g")
	return curdir
endfunction

" strip all trailing whitespace in entire file...
function! TrimEOL ()
	exec ':%s/\v[ \t]+$//gce'
endfunction

" text to return for closed fold
function! FoldText()
    let numlines = v:foldend - v:foldstart
    let firstline = getline(v:foldstart)
	"let spaces = 60 - len(firstline)
    return printf("%3d » %s ", numlines, firstline)
endfunction

"-------------------------------------------------------------------------------
"{{{1 MAPS
"-------------------------------------------------------------------------------

" under GNU screeen, these maps fix the home/end/pageup/pagedown keys so
" that <Home> and friends are mappable.  if other keys are screwed, use CTRL+V
" to get the key term sequence and map it here like the ones below...
map [1~ <Home>
map [5~ <PageUp>
map [6~ <PageDown>
map [4~ <End>
map OA <Up>
map OB <Down>
map OC <Right>
map OD <Left>

" visually select last text that was edited/pasted
nmap gV `[v`]

" repeat command and put the cursor at start of change instead of after it
nmap . .`[

" folding and unfolding
map <leader>f :set foldmethod=indent<cr>zM<cr>
map <leader>F :set foldmethod=manual<cr>zR<cr>

" toggle showing trailing tabs and spaces (see listchars)
nmap <leader>ss :set nolist!<cr>

" toggle text wrapping
noremap <leader>w :setlocal nowrap!<cr>

" strips trailing whitespace from all lines
nmap <leader>S :call TrimEOL()<cr>

" indent all lines in the file
map <leader>I :call MyIndent()<cr>

" make searches use very magic by default, so that regular expressions are
" evaluated more like perl regular expressions and dont require things like
" parentheses to be escaped
nnoremap / /\v
nnoremap ? ?\v

" make <C-e> and <C-y> scroll more lines
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

if has("extra_search")
	" press ,n to disable search highlight until next search
	" press ,m to toggle search highlight
	map <silent> <leader>c :silent :nohlsearch<cr>
	map <silent> <leader>C :silent set nohlsearch!<cr>:silent set nohlsearch?<cr>
endif

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" delete all buffers
nnoremap <leader>bd :silent bufdo! bd<cr>
nnoremap <leader>BD :silent bufdo! bd!<cr>

" open window below instead of above
nnoremap <silent> <C-W>N :let sb=&sb<bar>set sb<bar>new<bar>let &sb=sb<cr>

" vertical equivalent of C-w-n and C-w-N
nnoremap <C-w>v :vnew<cr>
nnoremap <C-w>V :let spr=&spr<bar>set nospr<bar>vnew<bar>let &spr=spr<cr>

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>
nmap <silent> <leader>sgv :so $MYGVIMRC<cr>

nnoremap <silent> <leader>n :bn<cr>
nnoremap <silent> <leader>p :bp<cr>

" use semicolon to go to command, saving the shift keypress
nnoremap ; :

" use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" changes up/down movements to move to the literal next row of text, even if it
" is a wrapped line
nnoremap j gj
nnoremap k gk

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" close buffer without changing window layout (vim-bbye plugin)
nnoremap <leader>q :Bdelete<cr>

nnoremap <leader>gs :Gstatus<cr>

"}}}
" -------------------------------------------------------------------------------

"Plugins: {{{1
" try :PlugInstall
call plug#begin('~/.vim/plugged')
	Plug 'sheerun/vim-polyglot'					 " language support for a bunch of popular languages
	
	Plug 'scrooloose/nerdtree'					 " nerdtree file browser (try <leader>f)
	Plug 'majutsushi/tagbar'

	Plug 'moll/vim-bbye'						 " adds :Bdelete to delete buffer without changing window layout

	" adds 'gc' to comment out a line (works with movement commands)
	Plug 'tpope/vim-commentary'

	" adds some fuzzy matching and case-switching help (see :Abolish, :Subvert, crs/crc/cru/crm/cr-/cr.)
	Plug 'tpope/vim-abolish'

	" can be used to have per-project configuration (see docs to setup)
	"Plug 'amiorin/vim-project'

	" replaces empty buffer with a recent-used files list
	Plug 'mhinz/vim-startify'

	" php7 syntax support
	Plug 'StanAngeloff/php.vim'

	" php coding standards
	"Plug 'stephpy/vim-php-cs-fixer'

	Plug 'ncm2/ncm2'
	Plug 'roxma/nvim-yarp'

	" https://github.com/junegunn/fzf.vim
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	"Plug 'neomake/neomake'
	"call neomake#configure#automake('nrwi', 500)

	" adds :Ack, :Lack, :Back, :Quack
	let g:FerretMap = 0
	Plug 'wincent/ferret'
	nmap <leader>a <plug>(FerretAck)
	nmap <leader>l <plug>(FerretLack)
	nmap <leader>s <plug>(FerretAckWord)

	Plug 'hashivim/vim-terraform'				 " language support for Terraform tf files
	Plug 'tpope/vim-fugitive'					 " adds git support (try :Git and <leader>gs for git status, type g? on status screen)

	if has('nvim') || has('patch-8.0.902')
		Plug 'mhinz/vim-signify'
	else
		Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
	endif

    "Plug 'airblade/vim-gitgutter'
	Plug 'vim-airline/vim-airline'				 " enhanced status line
	Plug 'ryanoasis/vim-devicons'				 " adds file icons to nerdtree and others
call plug#end()
"}}}

"
"NERDTree settings
	" automatically open nerdtree on vim start
	autocmd vimenter * NERDTree
	let g:NERDTreeMouseMode = 2
	let NERDTreeMinimalUI = 1
"
"airline settings
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	" unicode symbols
	let g:airline_left_sep = '»'
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '«'
	let g:airline_right_sep = '◀'
	let g:airline_symbols.linenr = '␊'
	let g:airline_symbols.linenr = '␤'
	let g:airline_symbols.linenr = '¶'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.paste = 'Þ'
	let g:airline_symbols.paste = '∥'
	let g:airline_symbols.whitespace = 'Ξ'
"

nnoremap <leader>b :Buffers<space>
nnoremap <leader>f :Files<cr>
nnoremap <leader>F :NERDTreeToggle<cr>
nnoremap <leader>rm :Gremove<cr>
nnoremap <leader>t :TagbarToggle<cr>

set tags+=.git/tags

