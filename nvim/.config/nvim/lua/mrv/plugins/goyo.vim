" Toggle Goyo mode
nnoremap <silent> <F5> :Goyo<Cr>

let g:alacritty_config_filepath = '/home/mroavi/dotfiles/alacritty/.config/alacritty/alacritty.yml'

" Returns the current date
function StatuslineDate()
  return strftime("%b %d, %Y")
endfunction

" Returns the current argument file in the arglist (which I use as the slide number)
function StatuslineSlideNumber()
  return 'slide ' . string(argidx() + 1) . ' / ' . argc()
endfunction

" Returns the current argument file in the arglist (which is equivalent to the slide number)
function StatuslineRefresh()
  set statusline=
  set statusline+=%#Conceal# " set `Conceal` highlight color
  set statusline+=%{StatuslineDate()} " insert date
  set statusline+=%= " switch to the right side
  set statusline+=%#Conceal# " set `SpecialKey` highlight color
  set statusline+=%{StatuslineSlideNumber()} " insert slide number
endfunction

" TODO: font formatting (bold, italic, etc) gets lost after entering and
" leaving goyo
function! s:goyo_enter()

  " Clear the command line
  echo ''

  " Remove artifacts for NeoVim on true colors transparent background (see https://github.com/junegunn/goyo.vim/issues/71)
  hi! link EndOfBuffer Ignore
  "hi! link VertSplit Ignore
  "hi! link StatusLine Ignore
  hi! link StatusLineNC Ignore

  " Hide gitsigns
  lua require"gitsigns".toggle_signs(false)

  " Increase alacritty's font size
  let g:font_size_new = '  size: 18.0'
  let g:font_size_current = matchstr(readfile(expand(g:alacritty_config_filepath)), '^  size:')
  let sed_cmd = "sed -i 's/" . g:font_size_current . "/" . g:font_size_new . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " Change cursor's background color
  let g:cursor_color_new = '      cursor:   "#282828"'
  let g:cursor_color_current = matchstr(readfile(expand(g:alacritty_config_filepath)), '^      cursor:')
  let sed_cmd = "sed -i 's/" . escape(g:cursor_color_current, '#') . "/" . escape(g:cursor_color_new, '#') . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " Map j/k to next/prev slide
  nnoremap <silent> j :n<Cr>
  nnoremap <silent> k :N<Cr>

  " Enable autocommands
  augroup presentation_mode
    autocmd!
    " Place cursor on the next empty line
    autocmd BufEnter *.sld call search("^$", 'cw')
    " Refresh statusline
    autocmd BufEnter *.sld call StatuslineRefresh()
  augroup END

  setlocal laststatus=2

  " Display the first slide
  argu 1

endfunction

function! s:goyo_leave()

  " Show gitsigns
  lua require"gitsigns".toggle_signs(true)

  " Reset alacritty's font size
  let sed_cmd = "sed -i 's/" . g:font_size_new . "/" . g:font_size_current . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " Reset cursor's color
  let sed_cmd = "sed -i 's/" . escape(g:cursor_color_new, '#') . "/" . escape(g:cursor_color_current, '#') . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " Unmap j/k
  unmap j
  unmap k

  " Clear autocommands 
  augroup presentation_mode
    autocmd!
  augroup END

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
