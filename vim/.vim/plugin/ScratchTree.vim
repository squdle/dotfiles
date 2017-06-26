" ScratchTree - A plain text tree file browser
" ------------------------------------------
" Make a buffer from the tree command for quick simple file browsing.
"
" Create buffer :
" ;;     - Browse from project directory (cwd).
" ;.     - Browse from current file directory.
"
" Navigate buffer :
" <CR>               - Follow links. Falls back to netrw if folder selected.
" 0 - 9              - Recreate buffer with different tree level, 0 = all.
" , (COMMA)          - Jump to tree.
" . (PERIOD)         - Jump to filepath.

" Temporarily remap some keys for easier navigation.

function! BrowseProjectOpenFile()
    if getline(".") == "."
        return ''
    endif
    if b:tree_offset >= line(".")
        exe 'normal! ' . (b:tree_offset + line(".")) . 'G'
    endif
    if filereadable(getline("."))
        normal! gf
    elseif match(getline("."), "->") != -1
        s/[^/]*\s*->\s*//
        normal! gf
    else
        call BrowseProjectTree(g:scratch_tree_default_level, getline("."), 0)
    endif
endfunction

function! BrowseProjectFilepathJump()
    if b:tree_offset < line(".") 
        exe 'normal! ' . (line(".") - b:tree_offset) . 'G'
    else
        exe 'normal! ' . (b:tree_offset + line(".")) . 'G'
    endif
endfunction

function! BrowseProjectPreviewToggle()
    if g:scratch_tree_preview_on
        call BrowseProjectKillPreview()
    endif
    let g:scratch_tree_preview_on = !g:scratch_tree_preview_on
    call BrowseProjectPreview()
endfunction

function! BrowseProjectTreeKeyMap()
    exe 'nnoremap <buffer> ' . g:scratch_tree_open . ' :call BrowseProjectOpenFile()<CR>:call BrowseProjectKillPreview()<CR>'
    exe 'nnoremap <buffer> ' . g:scratch_tree_jump . ' :call BrowseProjectFilepathJump()<CR>'
    exe 'nnoremap <buffer> ' . g:scratch_tree_preview_toggle . ' :call BrowseProjectPreviewToggle()<CR>'
    for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
        exe 'nnoremap <buffer>' i ':call BrowseProjectDepth('i')<CR>'
    endfor
    nnoremap <buffer> 0 :call BrowseProjectDepth(0)<CR>
    "exe 'nnoremap <buffer> ' . 'k k' . ':call BrowseProjectPreview()<CR>'
    "exe 'nnoremap <buffer> ' . 'j j' . ':call BrowseProjectPreview()<CR>'
endfunction

" Recreate project tree at specified depth.
function! BrowseProjectDepth(depth)
    normal! ggdG

    let l:root = 'cd ' . b:root 
    if a:depth == 0
        let l:tree = 'tree --noreport -a'
        let l:files = 'tree -fi --noreport -a'
    else
        let l:tree = 'tree --noreport -a -L ' . a:depth 
        let l:files = 'tree -fi --noreport -a -L ' .  a:depth
    endif
    silent exe '-1 read ! ' l:root . ';' . l:tree . ';' . l:files
    let b:tree_offset =  line(".") / 2 
    normal! Gdd
    exe 'silent! %s@^\.\/@' . b:root .  '\/@e'
    if b:root == '/'
        exe 'silent! %s@^\/\/@\/@e'
    endif
    normal! gg
endfunction

" Create a browser tree, map some navigation keys and make into scratch buffer.
function! BrowseProjectTree(depth, root, jump_current)
    let l:bufferprevious = substitute(expand("%:p"), "/\\.$", "", "")
    let l:bufferprevious = substitute(l:bufferprevious, "ScratchTree.:", "", "")
    try
        enew
    catch /^Vim\%((\a\+)\)\=:E37/
        echom "Save file before opening project tree."
        return ''
    endtry
    call TempBuffer() | set nowrap
    let b:root = substitute(a:root, "ScratchTree.:", "", "")
    let b:root = substitute(b:root, "/[^/]*/\\.\\.", "", "")
    if b:root == ''
        let b:root = '/'
    elseif b:root == '/..'
        let b:root = '/'
    endif
    call BrowseProjectDepth(a:depth) 
    call BrowseProjectTreeKeyMap()
    for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
        if bufwinnr('ScratchTree' . i) > 0
            continue
        else
            let l:name = 'ScratchTree' . i  . ':' . b:root . '/.'
            let l:name = substitute(l:name, "//", "/", "")
            exe 'silent! file! ' . l:name
            break
        endif
    endfor
    if a:jump_current
        call BrowseProjectGotoFilepath(l:bufferprevious)
    endif
    setlocal cursorline
    call BrowseProjectPreview()
    autocmd WinLeave,QuitPre,BufHidden,BufDelete,BufUnload "ScratchTree:" call BrowseProjectKillPreview()
    autocmd CursorMoved <buffer> call BrowseProjectPreview()
endfunction

function! BrowseProjectGotoFilepath(name)
   let l:name = substitute(a:name, '/\\.$', '', '')
   call search('\V' . l:name) 
   exe ':silent!' . (line('.') - b:tree_offset)
endfunction

function! BrowseProjectKillPreview()
    try
        bd! ScratchTree:preview
    catch /^Vim\%((\a\+)\)\=:E94/
    endtry
endfunction

function! BrowseProjectPreview()
    if g:scratch_tree_preview_on != 1
        return ''
    endif
    call BrowseProjectKillPreview()
    normal! mx
    if getline(".") == "."
        "return ''
    endif
    if b:tree_offset >= line(".")
        exe 'normal! ' . (b:tree_offset + line(".")) . 'G'
    endif
    if match(getline("."), "->") != -1
        s/[^/]*\s*->\s*//
    endif
    if filereadable(getline("."))
        "exe 'w ! head -n ' . g:scratch_tree_preview_height getline(".") . ' || ls ' . getline(".")
        let l:command = '-1r ! head -n ' . g:scratch_tree_preview_height . ' "' . getline(".") . '"'
        split | ene | call TempBuffer()
        exe 'resize ' . (g:scratch_tree_preview_height + g:scratch_tree_preview_margin)
        normal! gg
        exe l:command
        exe 'silent! file! ScratchTree:preview'
        wincmd p
    else
        split | ene | call TempBuffer()
        exe 'resize ' . (g:scratch_tree_preview_height + g:scratch_tree_preview_margin)
        normal! gg
        exe 'silent! file! ScratchTree:preview'
        wincmd p
    endif
    normal! `x
endfunction
