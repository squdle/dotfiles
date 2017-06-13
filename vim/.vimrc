" ~/.vimrc

" SETTINGS
" ========

" Turn of vi compatible
set nocompatible

" syntax and plugins.
syntax off
filetype plugin on

" Use space as leader key.
let mapleader=" "

" Use relative numbers.
set relativenumber
set number

" Highlight search options
set nohls
set incsearch

" Avoid having to reach for esc key.
inoremap jj <Esc>

" Use swapfiles but store them out of the way
set swapfile
set dir=~/tmp

" Allow filetypes for specific snippets, text objects, etc
filetype on

" Swap ; and : for faster ex mode.
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" Work to 80 and/or 120 columns and don't wrap text by default,
set colorcolumn=80,120
set nowrap
" But don't force new lines if we go over.
set textwidth=0 wrapmargin=0

" Fuzzy file searching
set path+='**'
set wildmenu
set wildmode=longest:full,full

" Reload .vimrc on save
autocmd! bufwritepost .vimrc source %

" Toggle settings.
nnoremap ;- :set colorcolumn=<CR>
nnoremap ;= :set colorcolumn=80,120<CR>
nnoremap ;7 :syntax off<CR>
nnoremap ;8 :syntax on<CR>
nnoremap ;0 :set relativenumber!<CR>
nnoremap ;9 :set wrap!<CR>

" STYLE
" =====

" Try and load our color scheme
try
    " Allow the pretty colours (disable if not using terminal emulator)
    set t_Co=257
    colorscheme squdle
    " Inform vim that we're probably using a dark theme.
    set background=dark 
catch /^Vim\%((\a\+)\)\=:E185/
    pass
endtry


" Toggle between black and transparent background
let $VIM_BG=1
function! Transparent_toggle()
    : echo $VIM_BG
    :if $VIM_BG
    :    highlight Normal ctermbg=none
    :    let $VIM_BG=0
    :else
    :    highlight Normal ctermbg=Black
    :    let $VIM_BG=1
    :endif
:endfunction
nnoremap \ :call Transparent_toggle()<CR>

" Blink cursor
function! Blink_position()
    :set cursorline
    :highlight CursorLine ctermbg=White ctermfg=Black term=bold
    :redraw
    :sleep 250m
    :highlight CursorLine ctermbg=NONE ctermfg=NONE term=NONE
    :set nocursorline
:endfunction
nnoremap ;<leader> :call Blink_position()<CR>

" AUTOCOMPLETE
" ============
" Basic tab auto completion in insert mode, see |ins-completion|
inoremap <tab> <C-n>

" SNIPPETS
" ========

" General search and replace for snippets.
" Looks for and replaces all instances of double 'bang' enclosed keyword:
" !!keyword!!
function! BangReplace()
    :let @y=inputdialog("Replace " . @x . ": ")
    :exe '%s/' . @x . '/\=@y/g'
    :normal '`z'
:endfunction
nnoremap <leader><leader> /!!.*!!<CR>mzv3f!"xy:call BangReplace()<CR>
function! BangReplaceLine()
    :let @y=inputdialog("Replace " . @x . ": ")
    :exe '.s/' . @x . '/\=@y/g'
    :normal '`z'
:endfunction
nnoremap <leader>. /!!.*!!<CR>mzv3f!"xy:call BangReplaceLine()<CR>

" Language specific snippets are in own sections and determined by filetype,
" but all basic templates are global.
" (sh)ell)
nnoremap <leader>sh :r ~/.vim/snippets/sh/template<CR>kdd
" (py)thon
nnoremap <leader>py :r ~/.vim/snippets/python/template.py<CR>kdd

" RUN / EXECUTE
" =============
vnoremap <CR> y:r ! <C-r>"
nnoremap ;<CR> ggVG: ! sh <CR>ggVG"xyu:bel split <bar> ene <CR>"xp:call Temp_buffer()<CR>:file result<CR>

" PYTHON
" ======

" snippets
" --------
autocmd FileType python nnoremap <leader>t :r ~/.vim/snippets/python/template.py<CR>kdd
autocmd FileType python nnoremap <leader>! :r ~/.vim/snippets/python/hashbang.py<CR>ddggP
autocmd FileType python nnoremap <leader>s :r ~/.vim/snippets/python/template.py<CR>
autocmd FileType python nnoremap <leader>m :r ~/.vim/snippets/python/module.py<CR>
autocmd FileType python nnoremap <leader>c :r ~/.vim/snippets/python/class.py<CR>
autocmd FileType python nnoremap <leader>p :r ~/.vim/snippets/python/property.py<CR>
autocmd FileType python nnoremap <leader>f :r ~/.vim/snippets/python/function.py<CR>
autocmd FileType python nnoremap <leader>d :r ~/.vim/snippets/python/docstring.py<CR>
autocmd FileType python nnoremap <leader>if  :r ~/.vim/snippets/python/if.py<CR>
autocmd FileType python nnoremap <leader>ei :r ~/.vim/snippets/python/elif.py<CR>
autocmd FileType python nnoremap <leader>el :r ~/.vim/snippets/python/else.py<CR>
autocmd FileType python nnoremap <leader>arg :r ~/.vim/snippets/python/argparse.py<CR>
autocmd FileType python nnoremap <leader>imp :r ~/.vim/snippets/python/import.py<CR>
autocmd FileType python nnoremap <leader>lc :r ~/.vim/snippets/python/list_comprehension.py<CR>
autocmd FileType python nnoremap <leader>ge :r ~/.vim/snippets/python/generator_expression.py<CR>
autocmd FileType python nnoremap <leader>di :r ~/.vim/snippets/python/dict.py<CR>
autocmd FileType python nnoremap <leader>fo :r ~/.vim/snippets/python/for.py<CR>
autocmd FileType python nnoremap <leader>wh :r ~/.vim/snippets/python/while.py<CR>
autocmd FileType python nnoremap <leader>wi :r ~/.vim/snippets/python/with.py<CR>

" Run / execute
" -------------
" Run python code on entire file.
autocmd FileType python nnoremap <F5> ggVG!python<CR>
autocmd FileType python nnoremap ;<CR> ggVG!python<CR>
" Run python on selection
" vnoremap <F5>  !python<CR>
autocmd FileType python vnoremap <F5> :read '<.'>!python<CR>
autocmd FileType python vnoremap <CR> :read '<.'>!python<CR>

" NAVIGATION
" ##########

" Follow filepaths under cursor from any file (must save current buffer).
" Entire WORD:
nnoremap ;] yaW:e <C-r>"<CR>
" Visual selection:
vnoremap ;] y:e <C-r>"<CR>

" Make netrw less ugly for when we do need it.
let g:netrw_banner=0

" CTAGS
" -----
" Regenerate ctags for current working directory
nnoremap ;t :!ctags -R<CR>

" Plain text file browser
" =======================
" Simple plain text file tree.
"
" ;;        - browse from cwd
" ;.        - browse from current file directory
" <count>;, - browse from cwd as tree (default depth 3)
" <CR>      - follow links
"
" If a folder is found this will fallback to netrw/default file browswr

function! Remove_trailing_blanks()
   :g/^$/d
   :normal gg
:endfunction

function! Temp_buffer()
    :setlocal buftype=nofile noswapfile bufhidden=delete
:endfunction

function! Remap_tmp_CR_view_rel()
" Temporarily remap carriage return to open a selected filename.
    :let @x=expand("%:p:h")
    :nnoremap <buffer> <CR> 0df/yaW:e! <C-r>x/<C-r>"<CR>
:endfunction

" Pop up a vertical split buffer, list files in current directory, temporarily remap <CR> to open.
"nnoremap ;; :vs <bar> enew <bar> set nowrap <bar> r!find . -maxdepth 1<CR>ggdd<CR>: call Temp_buffer()<CR>:call Remap_tmp_CR_view_rel()<CR>+

function! Remap_tmp_CR_view_abs()
" Temporarily remap carriage return to open a selected absolute filename.
    :nnoremap <buffer> <CR> 0f<bar>ly$:e! <C-r>"<CR>
:endfunction

" Pop up a vertical split buffer, list files in current directory, temporarily remap <CR> to open.
nnoremap ;. :let @x=expand("%:p:h")<CR>:vs <bar> enew <bar> set nowrap <CR>:  r!find <C-r>x -maxdepth 1<CR>ggdd<C-v>G$"yy<C-v>G0I<bar><Esc><C-v>G0200I <Esc><C-v>G0"yP:%s!<C-r>x!.!<CR>:call Remap_tmp_CR_view_abs()<CR>: call Temp_buffer()<CR>gg+

function! Remap_tmp_CR_view_tree()
" Temporarily remap carriage return to open a selected absolute filename.
    :nnoremap <buffer> <CR> 0f<bar>ly$:e! <C-r>"<CR>
:endfunction

" Pop up a vertical split buffer, list files in current directory, temporarily remap <CR> to open.
nnoremap ;v :<C-u>let @x=system("echo " . v:count . " <bar> sed s/^0$/3/")<CR>:<C-U>vs <bar> enew <bar> set nowrap <bar> r!tree -a --noreport -L <C-r>x <CR>mb:r ! tree -a -fi --noreport -L <C-r>x <CR>'b+<C-v>G$I<bar><Esc><C-v>G$dggj2000A <Esc>$Pggdd:call Remap_tmp_CR_view_tree()<CR>: call Temp_buffer()<CR>: call Remove_trailing_blanks()<CR>+

" Pop up a vertical split buffer, list files in current directory, temporarily remap <CR> to open.
nnoremap ;; :<C-u>let @x=system("echo " . v:count . " <bar> sed s/^0$/3/")<CR>:<C-U> enew <bar> set nowrap <bar> r!tree -a --noreport -L <C-r>x <CR>mb:r ! tree -a -fi --noreport -L <C-r>x <CR>'b+<C-v>G$I<bar><Esc><C-v>G$dggj2000A <Esc>$Pggdd:call Remap_tmp_CR_view_tree()<CR>: call Temp_buffer()<CR>: call Remove_trailing_blanks()<CR>+

" STARTUP
" =======

" Skip lockscreen
set shortmess+=I

function! Startup()
:endfunction

autocmd VimEnter  * :call Startup()

" STATUSLINE
" ==========
function! Statusline()
  return system('echo "$VIMSTATUS"')
endfunction
"set laststatus=1
"set qstatusline=
"set statusline=%!Statusline()

" PYTHON
" ======
" Horizontal function definition parameters
nnoremap <leader>( vi)2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical function definition parameters
nnoremap <leader>) "xdi)my^"zy0`yi<CR><Esc>"xgPi<CR>    <Esc>"zgPk:.s/ /\=@z/g<CR>I        <Esc>"zgP:.s/,/,\r        /g<CR>

" Horizontal / vertical arguments
" -------------------------------
" Horizontal arguments ( )
nnoremap <leader>9 vi)2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical arguments ( )
nnoremap <leader>0 "xdi)my^"zy0`yi<CR><Esc>"xgPi<CR><Esc>"zgPk:.s/ /\=@z/g<CR>I    <Esc>"zgP:.s/,/,\r    /g<CR>
" Horizontal arguments [ ]
nnoremap <leader>[ vi]2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical arguments [ ]
nnoremap <leader>] "xdi]my^"zy0`yi<CR><Esc>"xgPi<CR><Esc>"zgPk:.s/ /\=@z/g<CR>I    <Esc>"zgP:.s/,/,\r    /g<CR>
" Horizontal arguments { }
nnoremap <leader>{ vi}2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical arguments { }
nnoremap <leader>} "xdi}my^"zy0`yi<CR><Esc>"xgPi<CR><Esc>"zgPk:.s/ /\=@z/g<CR>I    <Esc>"zgP:.s/,/,\r    /g<CR>

" Text objects
" ------------
" Horizontal function definition parameters
nnoremap <leader>( vi)2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical function definition parameters
nnoremap <leader>) "xdi)my^"zy0`yi<CR><Esc>"xgPi<CR>    <Esc>"zgPk:.s/ /\=@z/g<CR>I        <Esc>"zgP:.s/,/,\r        /g<CR>

" Function
vnoremap af <Esc>$?def <CR>V/\v^$\n^$<bar>^$\n.*def<CR>k
omap af :normal Vaf<CR>
vnoremap if <Esc>$?def <CR>/):<CR>jV/\v^$\n^$<bar>^$\n.*def<CR>k
omap if :normal Vif<CR>

" Class
vnoremap ac j:<C-U>silent! ?class <CR>V/^$\n^$<CR>k
omap ac :normal Vac<CR>
vnoremap ic j:<C-U>silent! ?class <CR>jV/^$\n^$<CR>k
omap ic :normal Vic<CR>


" Folds
" =====
" Simple single level folding <C-f> to fold all, zE to unfold all.
autocmd FileType python nnoremap <C-f> mx:g/def.*(/:normal jzfif<CR>:g/class /:normal jzfic<CR>`x

" SH / SHELL
" ==========
autocmd FileType sh nnoremap <leader>t :r ~/.vim/snippets/sh/template<CR>kdd
autocmd FileType sh nnoremap <leader>i :r ~/.vim/snippets/sh/if<CR>

" WIP
" ===

" increment/decrement ascii values linewise from selection
vnoremap <C-A> :s/./\=nr2char(char2nr(submatch(0))+1)/g<CR><Esc>
vnoremap <C-X> v:'<,'>s/./\=nr2char(char2nr(submatch(0))-1)/g<CR><Esc>

" Move selection up / down
vnoremap <C-j> dp`[V`]
vnoremap <C-k> dkP`[V`]
nnoremap <C-j> Vdp`[V`]
nnoremap <C-k> VdkP`[V`]

" Goto last pasted (like gv for last visual)
nnoremap gp `[V`] 

" Enclose "quotes"
nnoremap <leader>" lbi"<Esc>ea"<Esc> 
nnoremap <leader>' lbi'<Esc>ea'<Esc> 
