" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White

highlight Normal          ctermbg=0 ctermfg=231
highlight ColorColumn     ctermbg=233
highlight LineNr          term=bold ctermbg=233 ctermfg=240
highlight CursorLineNr    ctermfg=White gui=bold guifg=White term=bold
highlight Visual          ctermfg=231 ctermbg=240
highlight Wildmenu        ctermfg=0 ctermbg=231
highlight Folded          ctermfg=231 ctermbg=240
highlight FoldColumn      ctermfg=231 ctermbg=240
highlight VerticalSplit   ctermfg=231 ctermbg=240
highlight VertSplit       ctermfg=231 ctermbg=240
highlight StatusLine      ctermfg=231 ctermbg=240
highlight Question        ctermfg=231 ctermbg=240
highlight StatusLineNC    ctermfg=231 ctermbg=233
highlight Title           ctermfg=231 ctermbg=240
highlight WarningMsg      term=reverse
highlight DiffAdd         ctermbg=22
highlight DiffChange      ctermbg=53
highlight DiffDelete      ctermbg=124 ctermfg=231
highlight DiffText        term=reverse ctermbg=124
"highlight SignColumn     term=standout ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
"highlight Conceal        ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
"highlight SpellBad       term=reverse ctermbg=9 gui=undercurl guisp=Red
"highlight SpellCap       term=reverse ctermbg=12 gui=undercurl guisp=Blue
"highlight SpellRare      term=reverse ctermbg=13 gui=undercurl guisp=Magenta
"highlight SpellLocal     term=underline ctermbg=14 gui=undercurl guisp=Cyan
highlight Pmenu           ctermfg=231 ctermbg=233
highlight PmenuSel        ctermfg=231 ctermbg=240 term=bold
"highlight PmenuSbar      ctermbg=248 guibg=Grey
"highlight PmenuThumb     ctermbg=15 guibg=White
"highlight TabLine        term=underline cterm=underline ctermfg=15 ctermbg=242 gui=underline guibg=DarkGrey
"highlight TabLineSel     term=bold cterm=bold gui=bold
"highlight TabLineFill    term=reverse cterm=reverse gui=reverse
"highlight CursorColumn   term=reverse ctermbg=242 guibg=Grey40
"highlight CursorLine     term=underline cterm=underline guibg=Grey40
"highlight ColorColumn    term=reverse ctermfg=242 ctermbg=242 guibg=DarkGrey
highlight  MatchParen     ctermbg=233 ctermfg=240

" Syntax guide:
" option
" output
" Main command:
" highlight <group> <attr>=value [ <attr>=walue ...]

" Example:
" highlight Comment cterm=underline ctermbg=Blue ctermfg=White

" cterm-colors
" 
" NR-16   NR-8    COLOR NAME 
" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White
" 
" *;highlight-groups*
" 
" 							*hl-ColorColumn*
" ColorColumn	used for the columns set with 'colorcolumn'
" 							*hl-Conceal*
" Conceal		placeholder characters substituted for concealed
" 		text (see 'conceallevel')
" 							*hl-Cursor*
" Cursor		the character under the cursor
" 							*hl-CursorIM*
" CursorIM	like Cursor, but used when in IME mode |CursorIM|
" 							*hl-CursorColumn*
" CursorColumn	the screen column that the cursor is in when 'cursorcolumn' is
" 		set
" 							*hl-CursorLine*
" CursorLine	the screen line that the cursor is in when 'cursorline' is
" 		set
" 							*hl-Directory*
" Directory	directory names (and other special names in listings)
" 							*hl-DiffAdd*
" DiffAdd		diff mode: Added line |diff.txt|
" 							*hl-DiffChange*
" DiffChange	diff mode: Changed line |diff.txt|
" 							*hl-DiffDelete*
" DiffDelete	diff mode: Deleted line |diff.txt|
" 							*hl-DiffText*
" DiffText	diff mode: Changed text within a changed line |diff.txt|
" 							*hl-EndOfBuffer*
" EndOfBuffer	filler lines (~) after the last line in the buffer.
" 		By default, this is highlighted like |hl-NonText|.
" 							*hl-ErrorMsg*
" ErrorMsg	error messages on the command line
" 							*hl-VertSplit*
" VertSplit	the column separating vertically split windows
" 							*hl-Folded*
" Folded		line used for closed folds
" 							*hl-FoldColumn*
" FoldColumn	'foldcolumn'
" 							*hl-SignColumn*
" SignColumn	column where |signs| are displayed
" 							*hl-IncSearch*
" IncSearch	'incsearch' highlighting; also used for the text replaced with
" 		":s///c"
" 							*hl-LineNr*
" LineNr		Line number for ":number" and ":#" commands, and when 'number'
" 		or 'relativenumber' option is set.
" 							*hl-CursorLineNr*
" CursorLineNr	Like LineNr when 'cursorline' or 'relativenumber' is set for
" 		the cursor line.
" 							*hl-MatchParen*
" MatchParen	The character under the cursor or just before it, if it
" 		is a paired bracket, and its match. |pi_paren.txt|
" 
" 							*hl-ModeMsg*
" ModeMsg		'showmode' message (e.g., "-- INSERT --")
" 							*hl-MoreMsg*
" MoreMsg		|more-prompt|
" 							*hl-NonText*
" NonText		'@' at the end of the window, characters from 'showbreak'
" 		and other characters that do not really exist in the text
" 		(e.g., ">" displayed when a double-wide character doesn't
" 		fit at the end of the line).
" 							*hl-Normal*
" Normal		normal text
" 							*hl-Pmenu*
" Pmenu		Popup menu: normal item.
" 							*hl-PmenuSel*
" PmenuSel	Popup menu: selected item.
" 							*hl-PmenuSbar*
" PmenuSbar	Popup menu: scrollbar.
" 							*hl-PmenuThumb*
" PmenuThumb	Popup menu: Thumb of the scrollbar.
" 							*hl-Question*
" Question	|hit-enter| prompt and yes/no questions
" 							*hl-Search*
" Search		Last search pattern highlighting (see 'hlsearch').
" 		Also used for highlighting the current line in the quickfix
" 		window and similar items that need to stand out.
" 							*hl-SpecialKey*
" SpecialKey	Meta and special keys listed with ":map", also for text used
" 		to show unprintable characters in the text, 'listchars'.
" 		Generally: text that is displayed differently from what it
" 		really is.
" 							*hl-SpellBad*
" SpellBad	Word that is not recognized by the spellchecker. |spell|
" 		This will be combined with the highlighting used otherwise.
" 							*hl-SpellCap*
" SpellCap	Word that should start with a capital. |spell|
" 		This will be combined with the highlighting used otherwise.
" 							*hl-SpellLocal*
" SpellLocal	Word that is recognized by the spellchecker as one that is
" 		used in another region. |spell|
" 		This will be combined with the highlighting used otherwise.
" 							*hl-SpellRare*
" SpellRare	Word that is recognized by the spellchecker as one that is
" 		hardly ever used. |spell|
" 		This will be combined with the highlighting used otherwise.
" 							*hl-StatusLine*
" StatusLine	status line of current window
" 							*hl-StatusLineNC*
" StatusLineNC	status lines of not-current windows
" 		Note: if this is equal to "StatusLine" Vim will use "^^^" in
" 		the status line of the current window.
" 							*hl-TabLine*
" TabLine		tab pages line, not active tab page label
" 							*hl-TabLineFill*
" TabLineFill	tab pages line, where there are no labels
" 							*hl-TabLineSel*
" TabLineSel	tab pages line, active tab page label
" 							*hl-Title*
" Title		titles for output from ":set all", ":autocmd" etc.
" 							*hl-Visual*
" Visual		Visual mode selection
" 							*hl-VisualNOS*
" VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
" 		Only X11 Gui's |gui-x11| and |xterm-clipboard| supports this.
" 							*hl-WarningMsg*
" WarningMsg	warning messages
" 							*hl-WildMenu*
" WildMenu	current match in 'wildmenu' completion
" 
" *highlight-term* *attr-list*
" bold
" underline
" reverse
" italic
" none
" 
" 
