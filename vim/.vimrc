" ~/.vimrc

" SETTINGS
" ========
" Turn of vi compatible
set nocompatible
" plugins.
filetype plugin on
" syntax default off
syntax off
" Use space as leader key.
let mapleader=" "
" Use relative numbers  and number for current line.
" (modern vim versions allow both simultaneously).
set relativenumber
set number
" Highlight search options
set nohls
set incsearch
" Avoid having to reach for esc key.
inoremap jj <Esc>
" Use swapfiles but store them out of the way of harm / annoyance.
set swapfile
set dir=~/tmp
" Allow filetypes for specific snippets, text objects, etc.
filetype on
" Swap ; and : for faster ex mode.
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :
" Work to 80 and/or 120 columns and don't wrap text by default,
set colorcolumn=80,120
set nowrap
" Use 80 character width
set textwidth=79
" But don't force new lines if we go over.
set wrapmargin=0
" Spaces instead of tabs please.
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on
" Stop neovim messing with macros (used different default values to vim).
set formatoptions=tcq
" Fuzzy file searching
set path=$PWD/**
set wildmenu
set wildmode=longest:full,full
" reload .vimrc on save
autocmd! bufwritepost .vimrc source %
" Edit vimrc quickly
nnoremap ;rc :vs ~/.vimrc<CR>
" Toggle settings.
nnoremap ;- :set colorcolumn=<CR>
nnoremap ;= :set colorcolumn=80,120<CR>
nnoremap ;0 :set relativenumber!<CR>
nnoremap ;9 :set number!<CR>
nnoremap ;8 :set wrap!<CR>
nnoremap ;7 :syntax on<CR>
nnoremap ;6 :syntax off<CR>
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set fileformat=unix " unix line endings

" STYLE
" =====
" guiterminal and cterminal color schemes.
" Loads guicolorscheme by default and falls back to ctermfg.
let g:guicolorscheme = "base16-eighties"
let g:ctermcolorscheme = "default"

" Load gui colour scheme set by g:guicolorscheme
function! TermGuiColors()
    set termguicolors
    exe "colorscheme" g:guicolorscheme
    syntax on
endfunction

" Load cterm colour scheme set by g:cterm color scheme.
function! CTermColors()
    "Inform vim that we're probably using a dark theme.
    set background=dark 
    " Turn of gui colors
    if has("termguicolors")
        set notermguicolors
    endif
    syntax off
    "Try to load color scheme
    try
        set t_Co=256
        exe "colorscheme" g:ctermcolorscheme
    catch /^Vim\%((\a\+)\)\=:E185/
         echom "Couldn't find colorscheme"
        pass
    endtry
endfunction

if has("termguicolors")
    call TermGuiColors()
else
    call CTermColors()
endif

" Toggle between black and transparent background
let $VIM_BG=1
function! Transparent_toggle()
     echo $VIM_BG
    if $VIM_BG
        "highlight Normal ctermbg=none
        highlight Normal ctermbg=none guibg=NONE
        highlight NonText ctermbg=none guibg=NONE
        let $VIM_BG=0
    else
        highlight Normal ctermbg=Black guibg=#000000
        let $VIM_BG=1
    endif
endfunction

" Switch color schemes on the fly.
nnoremap ;1 :call TermGuiColors()<CR>
nnoremap ;2 :call CTermColors()<CR>
nnoremap ;3 :call Transparent_toggle()<CR>

" Blink cursor - useful for when you loose your cursor or demonstrations.
function! BlinkPosition()
    set cursorline
    highlight CursorLine ctermbg=White ctermfg=Black guibg=#000000 term=bold
    redraw
    sleep 500m
    highlight CursorLine ctermbg=NONE ctermfg=NONE term=NONE
    set nocursorline
endfunction
nnoremap \ :call BlinkPosition()<CR>

" STARTUP
" =======
" Skip lockscreen.
set shortmess+=I
" Run custom behaviour on startup.
" This is a bit experimental and git doesn't like it!
"function! Startup()
"    w ! echo "" && cat ~/.config/splash && echo ""
"    sleep 1000m
"endfunction
" autocmd VimEnter  * :call Startup()

" AUTOCOMPLETE
" ============
" Basic tab auto completion in insert mode, see |ins-completion| for more.
" Tab completion (may need to generate tags).
inoremap <tab> <C-n>
" Regenerate ctags for current working directory
" vim may complain if tags doesn't exist for the above tab completion command.
nnoremap ;t :!ctags -R<CR>

" GENERAL HOTKEYS (any filetype / programming language)
" ===============
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

" NAVIGATION
" ==========
" Make netrw less ugly for when we do want it.
let g:netrw_banner=0

" Open file browser in current split (if no unsaved changes).
nnoremap ;; :call BrowseProjectTree(3, getcwd(), 0)<CR>
" Open current directory in current split (if no unsaved changes).
nnoremap ;. :call BrowseProjectTree(1, expand("%:p:h"), 1)<CR>
" Open parent directory in current split (if no unsaved changes).
nnoremap ;, :call BrowseProjectTree(3, expand("%:p:h") . '/..', 1)<CR>
" Open in split window
nnoremap ;<leader> :vs <bar> call BrowseProjectTree(5, getcwd(), 1)<CR>
" Keymappings for scratch tree navigation.

" Open file
let g:scratch_tree_open = '<CR>'
" Open file
let g:scratch_tree_jump = '.'
" Fallback to 3 levels when opening a folder
let g:scratch_tree_default_level = 3
" Toggle file preview
let g:scratch_tree_preview_toggle = 'p'
" File preview on/off by default
let g:scratch_tree_preview_on = 1
" File preview height
let g:scratch_tree_preview_height = 10
" File preview height
let g:scratch_tree_preview_margin = 1

" ========
" Search and replace for snippets.
" Looks for and replaces all instances of double 'bang' enclosed keyword:
" !!keyword!!
function! BangReplace()
    let @y=inputdialog("Replace " . @x . ": ")
    exe '%s/' . @x . '/\=@y/g'
    normal! '`z'
endfunction
nnoremap <leader><leader> /!!.*!!<CR>mzv3f!"xy:call BangReplace()<CR>

" Language specific snippets are in own sections and determined by filetype,
" but all basic templates are global.
" (sh)ell)
nnoremap <leader>sh :r ~/.vim/snippets/sh/template<CR>kdd
" (py)thon
nnoremap <leader>py :r ~/.vim/snippets/python/template.py<CR>kdd

" ----------------------------------------------------------------------------
" FILETYPE SPECIFIC
" ----------------------------------------------------------------------------

" SH / SHELL
" ==========

" snippets
" --------
autocmd FileType sh nnoremap <leader>t :r ~/.vim/snippets/sh/template<CR>kdd
autocmd FileType sh nnoremap <leader>i :r ~/.vim/snippets/sh/if<CR>

" Run / execute
" -------------
vnoremap <CR> y:r ! <C-r>"<CR>
nnoremap ;<CR> mxggVG: ! sh <CR>ggVG"yyu:bel split <bar> ene <CR>"yp:call TempBuffer()<CR>:file result<CR><C-w><C-p>`x

" ----------------------------------------------------------------------------

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
autocmd FileType python nnoremap <leader>arg :r ~/.vim/snippets/python/args.py<CR>
autocmd FileType python nnoremap <leader>imp :r ~/.vim/snippets/python/import.py<CR>
autocmd FileType python nnoremap <leader>fro :r ~/.vim/snippets/python/import_from.py<CR>
autocmd FileType python nnoremap <leader>lc :r ~/.vim/snippets/python/list_comprehension.py<CR>
autocmd FileType python nnoremap <leader>ge :r ~/.vim/snippets/python/generator_expression.py<CR>
autocmd FileType python nnoremap <leader>di :r ~/.vim/snippets/python/dict.py<CR>
autocmd FileType python nnoremap <leader>fo :r ~/.vim/snippets/python/for.py<CR>
autocmd FileType python nnoremap <leader>wh :r ~/.vim/snippets/python/while.py<CR>
autocmd FileType python nnoremap <leader>wi :r ~/.vim/snippets/python/with.py<CR>
autocmd FileType python nnoremap <leader>cm :r ~/.vim/snippets/python/class_method.py<CR>
autocmd FileType python nnoremap <leader>sm :r ~/.vim/snippets/python/static_method.py<CR>
autocmd FileType python nnoremap <leader>test :r ~/.vim/snippets/python/test.py<CR>
autocmd FileType python nnoremap <leader>tc :r ~/.vim/snippets/python/test_case.py<CR>
autocmd FileType python nnoremap <leader>tm :r ~/.vim/snippets/python/test_method.py<CR>
autocmd FileType python nnoremap <leader>try :r ~/.vim/snippets/python/try.py<CR>
autocmd FileType python nnoremap <leader>env :r ~/.vim/snippets/python/env.py<CR>

" Debug
" -----
"Create temp file from buffer, run with pdb and then remove tempfile.
function! PyDebug()
    let filepath = expand("%:p:h") . "/pdb_vim.py"
    exe "w! " . filepath
    let command = "python -m pdb " . filepath . " || rm " . filepath
    if has('nvim')
        vs | ene | call TempBuffer()
        exe "terminal " . command
    else
        exe "! " . command
    endif
endfunction

" Add a python pdb breakpoint (two lnes to not conflict with pep8)
" These can be removed with PyNoBreakPoint() or by filtering for '# DEBUG'
function! PyBreakPoint()
    normal! mx
    normal! Opdb.set_trace()  # DEBUG
    normal! Oimport pdb       # DEBUG
    normal! Vk=`x
endfunction

" Remove pdb debug set_trace calls and pdb imports.
function! PyNoDEBUG()
    g/#.*DEBUG/d
endfunction

autocmd FileType python nnoremap <leader>db :call PyBreakPoint()<CR>
autocmd FileType python nnoremap <leader>nodb :call PyNoDebug()<CR>
autocmd FileType python nnoremap <leader>4 :call PyDebug()<CR>

" Run / execute
" -------------
" Run python code on entire file.
autocmd FileType python nnoremap <F5> g:%w !python<CR>
" Run python but ignore debug
autocmd FileType python nnoremap <leader>5 :%w !grep -v 'DEBUG' <bar> python<CR>
" Run python on selection
autocmd FileType python vnoremap <F5> :read '<.'>!python<CR>
autocmd FileType python vnoremap <CR> :read '<.'>!python<CR>

" Formatting
" ----------
" Horizontal arguments ( )
nnoremap <leader>9 vi)2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical arguments ( )
nnoremap <leader>0 mx^"yy0`xva)o<Esc>a<CR><Esc>^d0:s/, /,\r/g<CR>va)<Esc>i<CR><Esc>vi)<C-v>I<C-r>y    <Esc>va)<Esc>"yP
" Horizontal arguments [ ]
nnoremap <leader>[ vi]2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical arguments [ ]
nnoremap <leader>] "xdi]my^"zy0`yi<CR><Esc>"xgPi<CR><Esc>"zgPk:.s/ /\=@z/g<CR>I    <Esc>"zgP:.s/,/,\r    /g<CR>
" Horizontal arguments { }
nnoremap <leader>{ vi}2:s/[\n<bar> ]//g<CR>:.s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical arguments { }
nnoremap <leader>} "xdi}my^"zy0`yi<CR><Esc>"xgPi<CR><Esc>"zgPk:.s/ /\=@z/g<CR>I    <Esc>"zgP:.s/,/,\r    /g<CR>
" Horizontal function definition parameters
nnoremap <leader>( vi):s/,\n/,/g<CR>:s/ //g<CR>V:s/,/, /g<CR>kgJ
" Vertical function definition parameters
nnoremap <leader>) "xdi)my^"zy0`yi<CR><Esc>"xgPi<CR>    <Esc>"zgPk:.s/ /\=@z/g<CR>I        <Esc>"zgP:.s/,/,\r        /g<CR>Jdt)vi)=
" Fit function definition parameters within line limit.
nnoremap <leader>() va(o<Esc>R(<CR><Esc>vi)gqvi):s/^$\n//g<CR>

" Text objects
" ------------
" Function
autocmd FileType python vnoremap af <Esc>$?^ *def <CR>V/\v\n^$\n^$<bar>\n^$\n.*def.*\(<bar>.*%$<CR>
autocmd FileType python omap af :normal! Vaf<CR>
autocmd FileType python vnoremap if <Esc>$?^ *def <CR>/):<CR>j0v/\v\n^$\n^$<bar>\n^$\n.*def.*\(<bar>.*%$<CR>V
autocmd FileType python omap if :normal! Vif<CR>
" Class
autocmd FileType python vnoremap ac j:<C-U>silent! ?class <CR>V/\n^$\n^$\<bar>\%$<CR>
autocmd FileType python omap ac :normal! Vac<CR>
autocmd FileType python vnoremap ic j:<C-U>silent! ?class <CR>jV/\n^$\n^$\<bar>\%$<CR>
autocmd FileType python omap ic :normal! Vic<CR>

" Folds
" -----
" Simple single level folding <C-f> to fold all, zE to unfold all.
autocmd FileType python nnoremap <C-f> mxzEgg:g/^ *def.*(/:normal! jzfif<CR>:g/^ *class /:normal! jzfic<CR>`x


" Pep8 and Linting
" ----------------
function! Remap_tmp_CR_debug_jump()
" Temporarily remap carriage return to open a selected filename.
    nnoremap <buffer> <CR> $?stdin:P/\d<CR>"xyw:wincmd p<CR>:<C-r>x<CR>
endfunction
function! Remap_tmp_CR_debug_jump_close()
" Temporarily remap carriage return to open a selected filename.
    nnoremap <buffer> <CR> $?stdin:<CR>/\d<CR>"xyw:wincmd p<CR>:<C-r>x<CR>:wincmd p<bar>bd<CR>
endfunction

" Lint code tries to use flake8, then falls back to pycodestyle / pep8
function! PyLint()
    call CopyAllToTempBuffer()
    normal! VG
    let pep8 = "import sys, pep8; print(pep8.Checker(lines=sys.stdin.readlines(), show_source=True, verbose=True).check_all() or '')"
    let pycodestyle = "import sys, import pycodestyle as pep8; print(pep8.Checker(lines=sys.stdin.readlines(), show_source=True, verbose=True).check_all() or '')"
    let flake8 = "import flake8.main.cli; flake8.main.cli.main()"
    "echom '"' . flake8 . '" || python -c "' . pycodestyle . '" || python -c "' . pep8 '"  ; rm ' . filepath 
    exe '%! python -c "' . flake8 . '" || python -c "' . pycodestyle . '" || python -c "' . pep8 '"  ; rm ' . filepath 
    call Remap_tmp_CR_debug_jump_close()
    call CheckTestPass("Linter pass", 1)
endfunction

" Check docstring style. Looks for pydocstyle then pep257 
function! PyDocStyle()
    let filepath = expand("%:p:h") . "/doc_vim.py"
    exe "w! " . filepath
    vs | ene | call TempBuffer()
    let command = "python -m pydocstyle " . filepath . " || python -m pep257 " . filepath . " ; rm " . filepath
    let command = "python -m pydocstyle " . filepath . " || python -m pep257 " . filepath . " ; rm " . filepath
    exe "r ! " . command
    %s/^.*\.py:/stdin:/ge
    call Remap_tmp_CR_debug_jump_close()
    call CheckTestPass("Docstyle pass", 1)
endfunction

" Automatically change code to pep8 (requires autopep8)
function! AutoPep8()
    normal! mxggVG
    %! python -m autopep8 --max-line-length 79 -a -a -a -a --pep8-passes 2000 -
    normal! vv`x
endfunction

autocmd FileType python nnoremap <leader>1 :call PyLint()<CR>
autocmd FileType python nnoremap <leader>2 :call PyDocStyle()<CR>
autocmd FileType python nnoremap <leader>3 :call AutoPep8()<CR>

" Profiling
" -------
" Run cProfile on current buffer
function! PyProfile()
    call CopyAllToTempBuffer()
    %! python -c 'import sys,cProfile;cProfile.run(sys.stdin.read())'
endfunction
nnoremap <leader>7 :call PyProfile()<CR>

" GIT
" ---

" Call git log on project of current buffer. Runs app if command provided.
" Pass empty string to get a text based git log.
function! GitLog(app)
    let bufferpath = expand("%:p:h")
    let command = 'cd ' . bufferpath . ';git log --graph --abbrev --decorate --oneline --graph'
    echo command
    if a:app == ""
        if has('nvim')
            sp | ene | call TempBuffer()
            exe "terminal " . command
        else
            exe '! ' . command
        endif
    else
        let message = '\nlaunching external git log viewer...\n'
        let command = 'cd ' . bufferpath . ' && ' . a:app
        exe '! echo -e "' . message . '"'
        exe '! ' . command
    endif
endfunction

" Call git status on project of current buffer.
function! GitStatus()
    let bufferpath = expand("%:p:h")
    exe '! cd ' . bufferpath . ' && git status'
endfunction

" Use normal git log
nnoremap <leader>6 :call GitStatus() <bar> call GitLog("")<CR>
" Launch GUI git log
nnoremap <F6> :call GitLog("gitg")<CR>

" NVIM SPECIFIC
" -------------
" In nvim, open keyword/help in new terminal,
" as nvim doesn't currently allow terminal scrollback.
function! KeywordNvim()
    if &keywordprg == ':Man'
        let l:man = 'man'
    else
        let l:man = &keywordprg
    endif
    let l:wordUnderCursor = expand("<cword>")
    vsplit | enew
    exe 'terminal ' . l:man l:wordUnderCursor
endfunction
if has("nvim")
    nnoremap K :call KeywordNvim()<CR>
    vnoremap K <Esc>:call KeywordNvim()<CR>
endif
