let g:tomux_paste_file = expand("$HOME/.tomux_paste")
nnoremap <silent> yot :TomuxUseClipboardToggle<Cr>

if $SSH_CONNECTION
  let g:tomux_use_clipboard = 0
else
  let g:tomux_use_clipboard = 1
endif

augroup tomux_send
  autocmd!

  "-----------------------------------------------------------------------------
  " `s` to send motion/text-object
  "-----------------------------------------------------------------------------
  autocmd FileType julia,python,octave nmap <buffer> s <Plug>TomuxMotionSend
  "autocmd FileType julia,python,octave nmap <silent> s :set opfunc=MySendOperator<Cr>g@
  autocmd FileType julia,python,octave xmap <buffer> s <Plug>TomuxVisualSend
  autocmd FileType julia,python,octave omap <buffer> s _

  "-----------------------------------------------------------------------------
  " Atom-like mappings for sending text (the `\` key is used as helper/hack)
  "-----------------------------------------------------------------------------
  autocmd FileType julia,python,octave nmap <buffer> \ <Plug>TomuxMotionSend

  " Ctrl+Enter to send text in visual, normal and insert modes
  "autocmd FileType julia,python,octave xmap <buffer> <C-Cr> <Plug>TomuxVisualSend
  "autocmd FileType julia,python,octave nmap <buffer> <C-Cr> \_
  "autocmd FileType julia,python,octave imap <buffer> <C-Cr> <Esc>\_gi

  " Alt+Enter to send cell
  autocmd FileType julia,python,octave nmap <buffer> <M-Cr> \ic

  " Ctrl+Shift+Enter to send entire buffer
  autocmd FileType octave              nmap <buffer> <C-S-Cr> \id

  " Shift+Enter to send paragraph and jump to next statement
  autocmd FileType julia,python,octave nmap <silent> <S-Cr> :set opfunc=MySendOperator<Cr>g@ap

  "-----------------------------------------------------------------------------
  " `|` operator to send text up to the | character
  "-----------------------------------------------------------------------------
  "autocmd FileType julia nnoremap <expr> <Bar> SendUpToBarOperator()
  "autocmd FileType julia xnoremap <expr> <Bar> SendUpToBarOperator()
  "autocmd FileType julia nnoremap <expr> <Bar><Bar> SendUpToBarOperator() .. '_'

  "-----------------------------------------------------------------------------
  " Convenience mapping to send code that uses Julia's pipe operator (|>)
  "-----------------------------------------------------------------------------
  autocmd FileType julia nnoremap <Bar><Bar> :call SendUpToBarChar()<Cr>

augroup END

" My custom operator: sends a motion/text-object to the REPL and moves to the
" next statement (skips comments and empty lines) (see :h map-operator)
" See: https://vi.stackexchange.com/questions/5495/mapping-with-motion
function! MySendOperator(type, ...)
  " Select lines involved in the motion
  silent exe "normal! `[V`]"
  " Send the selected region
  silent exe "normal \<Plug>TomuxVisualSend"
  " Go to the last char of the selection
  silent exe "normal! `>"
  " Get the first character of the 'commentstring'
  let l:commentchar = split(&commentstring, '%s')[0][0]
  " Jump to next statement (skips empty lines or lines that start with comment char)
  let l:pattern =  '^\(\s*' . l:commentchar . '\)\@!\s*\S\+'
  call search(l:pattern, "W")
endfunction

" My custom operator: sends a motion/text-object to the REPL up to the "|"
" char in the last line covered by the motion/text-object
" Deprecated in favor of the function below
function! SendUpToBarOperator(type = '') abort
  if a:type == ''
    set opfunc=SendUpToBarOperator
    return 'g@'
  endif
  let sel_save = &selection
  let reg_save = getreginfo('"')
  let cb_save = &clipboard
  let visual_marks_save = [getpos("'<"), getpos("'>")]
  try
    set clipboard= selection=inclusive
    silent exe 'noautocmd keepjumps normal! `[^v`]^t|ge'
    silent exe "normal \<Plug>TomuxVisualSend"
  finally
    call setreg('"', reg_save)
    call setpos("'<", visual_marks_save[0])
    call setpos("'>", visual_marks_save[1])
    let &clipboard = cb_save
    let &selection = sel_save
  endtry
endfunction

" Sends from the beginning of the paragraph up to the first "|" char on the
" line where the cursor is at.
function! SendUpToBarChar() abort
  let win_save = winsaveview()
  let sel_save = &selection
  let visual_marks_save = [getpos("'<"), getpos("'>")]
  try
    set clipboard= selection=inclusive
    silent exe "noautocmd keepjumps normal! mz{jv'zt|ge"
    silent exe "normal \<Plug>TomuxVisualSend"
  finally
    call setpos("'<", visual_marks_save[0])
    call setpos("'>", visual_marks_save[1])
    let &selection = sel_save
    call winrestview(win_save)
  endtry
endfunction
