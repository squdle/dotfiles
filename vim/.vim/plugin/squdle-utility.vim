" UTILITY FUNCTIONS
" =================
" Remove all blank lines in the file
function! RemoveBlankLines()
   g/^$/d
   normal! gg
endfunction

" Make buffer temporary (No warning when closing with unsaved changes).
function! TempBuffer()
    setlocal buftype=nofile noswapfile bufhidden=delete
endfunction

" Copy all of current buffer to new vertical split.
function! CopyAllToTempBuffer()
    normal! mxggyG`x
    vs | ene
    call TempBuffer()
    normal! pggdd
endfunction

" Check if a test has passed by looking for an empty buffer.
" A test is considered as having passed if nothing is output to the buffer.
function! CheckTestPass(message, stay)
    let line=getline(".")
    if line == ""
        close
        redraw
        echo a:message
    else
        redraw
        normal! vv
        if a:stay != 1
            wincmd p
        endif
    endif
endfunction
