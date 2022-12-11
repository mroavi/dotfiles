" TODO: replace with https://github.com/folke/zen-mode.nvim

" Toggle Goyo mode
nnoremap <silent> <F5> :Goyo<Cr>

" Terminal config filepaths
let s:alacritty_config_filepath = expand('~/.config/alacritty/alacritty.yml')
let s:kitty_config_filepath = expand('~/.config/kitty/kitty.conf')

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

" Sets the date and slide number in the status line
function s:statusline_refresh()
  setlocal statusline=
  setlocal statusline+=%#Conceal# " set `Conceal` highlight color
  setlocal statusline+=%{StatuslineDate()} " insert date
  setlocal statusline+=%= " switch to the right side
  setlocal statusline+=%{StatuslineSlideNumber()} " insert slide number
endfunction

" ---------------------------------------------------------------------------
" font size
" ---------------------------------------------------------------------------

function s:set_font_size()
  if $TERM ==# 'alacritty'
    let s:font_size_new = '  size: 18.0'
    let s:font_size_current = matchstr(readfile(expand(s:alacritty_config_filepath)), '^  size:')
    let sed_cmd = "sed -i 's/" . s:font_size_current . "/" . s:font_size_new . "/g'"
    silent execute "!" . sed_cmd . " " . s:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let s:font_size_new = 'font_size 18.0'
    let s:font_size_current = matchstr(readfile(expand(s:kitty_config_filepath)), '^font_size ')
    let sed_cmd = "sed -i 's/" . s:font_size_current . "/" . s:font_size_new . "/g'"
    silent execute "!" . sed_cmd . " " . s:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

function s:reset_font_size()
  if $TERM ==# 'alacritty'
    let sed_cmd = "sed -i 's/" . s:font_size_new . "/" . s:font_size_current . "/g'"
    silent execute "!" . sed_cmd . " " . s:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let sed_cmd = "sed -i 's/" . s:font_size_new . "/" . s:font_size_current . "/g'"
    silent execute "!" . sed_cmd . " " . s:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

" ---------------------------------------------------------------------------
" Cursor color
" ---------------------------------------------------------------------------

function s:set_cursor_color()
  if $TERM ==# 'alacritty'
    let s:cursor_color_new = '      cursor:   "#282828"'
    let s:cursor_color_current = matchstr(readfile(expand(s:alacritty_config_filepath)), '^      cursor:')
    let sed_cmd = "sed -i 's/" . escape(s:cursor_color_current, '#') . "/" . escape(s:cursor_color_new, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . s:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let s:cursor_color_new = 'cursor #282828'
    let s:cursor_color_current = matchstr(readfile(expand(s:kitty_config_filepath)), '^cursor ')
    let sed_cmd = "sed -i 's/" . escape(s:cursor_color_current, '#') . "/" . escape(s:cursor_color_new, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . s:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

function s:reset_cursor_color()
  if $TERM ==# 'alacritty'
    let sed_cmd = "sed -i 's/" . escape(s:cursor_color_new, '#') . "/" . escape(s:cursor_color_current, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . s:alacritty_config_filepath
  elseif $TERM ==# 'xterm-kitty'
    let sed_cmd = "sed -i 's/" . escape(s:cursor_color_new, '#') . "/" . escape(s:cursor_color_current, '#') . "/g'"
    silent execute "!" . sed_cmd . " " . s:kitty_config_filepath
    silent exec "!kill -s USR1 `pgrep -f kitty`"
  endif
endfunction

" ---------------------------------------------------------------------------
" Goyo activated
" ---------------------------------------------------------------------------

function! s:goyo_enter()
  echo ''
  lua require"gitsigns".toggle_signs(false)
  call s:set_font_size() " set presentation mode font size
  call s:set_cursor_color() " change cursor's background color

  " Slide navigation mappings 
  nnoremap <silent> j :n<Cr>
  nnoremap <silent> k :N<Cr>
  nnoremap <silent> gg :first<Cr>
  nnoremap <silent> G :last<Cr>

  " Create autocommands
  augroup presentation_mode
    autocmd!
    autocmd BufEnter *.sld call search("^$", 'cw') " place cursor on the next empty line
    autocmd BufEnter *.sld call s:statusline_refresh() " refresh statusline
  augroup END

  "setlocal laststatus=2 " show statusline " mrv: not needed
  argu " open the current entry in the arglist

  let g:argidx = argidx() " initialize global var used to set last visited slide at Goyo leave

endfunction

" ---------------------------------------------------------------------------
" Goyo deactivated
" ---------------------------------------------------------------------------

function! s:goyo_leave()
  lua require"gitsigns".toggle_signs(true)
  call s:reset_font_size() " reset font size
  call s:reset_cursor_color() " reset cursor's color

  " Unmap slide navigation mappings
  nunmap j
  nunmap k
  nunmap gg
  nunmap G

  " Remove autocommands 
  augroup presentation_mode
    autocmd!
  augroup END
  augroup! presentation_mode

  " Open the last visited slide
  exe 'argu ' . (g:argidx + 1) 

  setfiletype sld " reapply sld syntax (which gets reset after reapplying the color scheme)

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
