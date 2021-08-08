let g:tomux_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
let g:tomux_paste_file = expand("$HOME/.tomux_paste")
let g:tomux_use_clipboard = 0
nnoremap <silent> yot :TomuxUseClipboardToggle<CR>

augroup tomux_send
	autocmd!
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" `s` to send motion and jump to next statement
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	autocmd FileType julia,python,octave nmap <silent> s :set opfunc=MySendMotion<CR>g@
	autocmd FileType julia,python,octave xmap <buffer> s <Plug>TomuxVisualSend
	autocmd FileType julia,python,octave omap <buffer> s _

	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"	Atom-like mappings for sending text (the `0` key is used as helper/hack)
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	autocmd FileType julia,python,octave nmap <buffer> 0 <Plug>TomuxMotionSend
	" Ctrl+Enter to send text in visual, normal and insert modes
	autocmd FileType julia,python,octave xmap <buffer> <C-CR> <Plug>TomuxVisualSend
	autocmd FileType julia,python,octave nmap <buffer> <C-CR> 0_
	autocmd FileType julia,python,octave imap <buffer> <C-CR> <Esc>0_gi
	" Alt+Enter to send cell
	autocmd FileType julia,python,octave nmap <buffer> <M-CR> 0ic
	" Ctrl+Shift+Enter to send entire buffer
	autocmd FileType julia,python,octave nmap <buffer> <C-S-CR> 0id
	" Shift+Enter to send line and jump to next statement
	autocmd FileType julia,python,octave nmap <silent> <S-CR> :set opfunc=MySendMotion<CR>g@_
augroup END

" My custom operator: sends a motion to the REPL and moves to the next
" statement (skips comments and empty lines) (see :h map-operator)
" See: https://vi.stackexchange.com/questions/5495/mapping-with-motion
function! MySendMotion(type, ...)
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

