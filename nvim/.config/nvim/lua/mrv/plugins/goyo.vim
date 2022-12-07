" Toggle Goyo mode
nnoremap <silent> <F5> :Goyo<Cr>

" Config filepaths
let g:alacritty_config_filepath = expand('~/.config/alacritty/alacritty.yml')
let g:kitty_config_filepath = expand('~/.config/kitty/kitty.conf')

" ---------------------------------------------------------------------------
" statusline
" ---------------------------------------------------------------------------

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
  setlocal statusline=
  setlocal statusline+=%#Conceal# " set `Conceal` highlight color
  setlocal statusline+=%{StatuslineDate()} " insert date
  setlocal statusline+=%= " switch to the right side
  setlocal statusline+=%#Conceal# " set `SpecialKey` highlight color
  setlocal statusline+=%{StatuslineSlideNumber()} " insert slide number
endfunction

" ---------------------------------------------------------------------------
" font size
" ---------------------------------------------------------------------------

function SetFontSize()
  if $TERM ==# 'alacritty'
    let g:font_size_new = '  size: 18.0'
    let g:font_size_current = matchstr(readfile(expand(g:alacritty_config_filepath)), '^  size:')
    let sed_cmd = "sed -i 's/" . g:font_size_current . "/" . g:font_size_new . "/g'"
    silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let g:font_size_new = 'font_size 18.0'
    let g:font_size_current = matchstr(readfile(expand(g:kitty_config_filepath)), '^font_size ')
    let sed_cmd = "sed -i 's/" . g:font_size_current . "/" . g:font_size_new . "/g'"
    silent execute "!" . sed_cmd . " " . g:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

function ResetFontSize()
  if $TERM ==# 'alacritty'
    let sed_cmd = "sed -i 's/" . g:font_size_new . "/" . g:font_size_current . "/g'"
    silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let sed_cmd = "sed -i 's/" . g:font_size_new . "/" . g:font_size_current . "/g'"
    silent execute "!" . sed_cmd . " " . g:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

" ---------------------------------------------------------------------------
" Cursor color
" ---------------------------------------------------------------------------

function SetCursorColor()
  if $TERM ==# 'alacritty'
    let g:cursor_color_new = '      cursor:   "#282828"'
    let g:cursor_color_current = matchstr(readfile(expand(g:alacritty_config_filepath)), '^      cursor:')
    let sed_cmd = "sed -i 's/" . escape(g:cursor_color_current, '#') . "/" . escape(g:cursor_color_new, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let g:cursor_color_new = 'cursor #282828'
    let g:cursor_color_current = matchstr(readfile(expand(g:kitty_config_filepath)), '^cursor ')
    let sed_cmd = "sed -i 's/" . escape(g:cursor_color_current, '#') . "/" . escape(g:cursor_color_new, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . g:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

function ResetCursorColor()
  if $TERM ==# 'alacritty'
    let sed_cmd = "sed -i 's/" . escape(g:cursor_color_new, '#') . "/" . escape(g:cursor_color_current, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let sed_cmd = "sed -i 's/" . escape(g:cursor_color_new, '#') . "/" . escape(g:cursor_color_current, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . g:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

" ---------------------------------------------------------------------------
" Goyo activated
" ---------------------------------------------------------------------------

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

  " Set presentation mode font size
  call SetFontSize()

  " Change cursor's background color
  call SetCursorColor()

  " Map j/k to next/prev slide
  nnoremap <silent> j :n<Cr>
  nnoremap <silent> k :N<Cr>

  " Enable autocommands
  augroup presentation_mode
    autocmd!
    autocmd BufEnter *.sld call search("^$", 'cw') " place cursor on the next empty line
    autocmd BufEnter *.sld call StatuslineRefresh() " refresh statusline
  augroup END

  " Show statusline
  setlocal laststatus=2

  " Display the first slide
  argu 1

endfunction

" ---------------------------------------------------------------------------
" Goyo deactivated
" ---------------------------------------------------------------------------

function! s:goyo_leave()

  " Show gitsigns
  lua require"gitsigns".toggle_signs(true)

  " Reset font size
  call ResetFontSize()

  " Reset cursor's color
  call ResetCursorColor()

  " Unmap j/k
  unmap j
  unmap k

  " Clear autocommands 
  augroup presentation_mode
    autocmd!
  augroup END
  augroup! presentation_mode

  " TODO: restore statusline

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
