" Maximum width of text that is being inserted
setlocal textwidth=78
setlocal colorcolumn=79

" Ascii border
nmap <Leader>b :.!toilet -w 200 -f term -F border<Cr>

" Enable fenced code block syntax highlighting in sld files
let g:markdown_fenced_languages = ['julia', 'html', 'python', 'bash=sh']

"let g:slides_font_size = 20

" tender color scheme
"let g:slides_cursor_color = '#282828'
"let g:slides_cursor_text_color = '#ffc24b'

" rose-pine color scheme
let g:slides_cursor_color = '#191724'
let g:slides_cursor_text_color = '#e0def4'

" ---------------------------------------------------------------------------
" Limelight
" ---------------------------------------------------------------------------

nnoremap <silent> <Leader><Leader> :Limelight!!<Cr>

"" TODO: errors if presentation ends while limelight is activated
"function! s:next_silent()
"  execute 'try | n | catch | try | silent exe "norm \<C-l>" | catch | | endtry | endtry'
"endfunction
"function! s:prev_silent()
"  execute 'try | N | catch | try | silent exe "norm \<C-l>" | catch | | endtry | endtry'
"endfunction
"let s:limelight_enabled = 0
"function s:limelight()
"  if !(s:limelight_enabled)
"    let s:limelight_enabled = 1
"    " Unmap slide navigation mappings
"    nunmap j
"    nunmap k
"  else
"    let s:limelight_enabled = 0
"    " Map slide navigation mappings 
"    nnoremap <silent> j :call <SID>next_silent()<CR>
"    nnoremap <silent> k :call <SID>prev_silent()<CR>
"  endif
"  " Toggle limelight
"  Limelight!!
"endfunction
"nnoremap <silent> <Leader><Leader> :call <SID>limelight()<Cr>

" ---------------------------------------------------------------------------
" Misc
" ---------------------------------------------------------------------------

" Fills a grid of nlines x textwidth of spaces
function NewSlide()
  let nlines = 30
  " Insert `nlines` lines
  exe "norm " .. string(nlines-1) .. "] " 
  " Insert `ncols` spaces
  exe "1," .. string(nlines) .."norm " ..  string(&textwidth) .. "i " 
endfunction
noremap <Leader>n :call NewSlide()<Cr>
