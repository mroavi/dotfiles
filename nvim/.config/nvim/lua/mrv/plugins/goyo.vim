" Toggle Goyo mode
nnoremap <silent> <F5> :Goyo<Cr>

let g:alacritty_config_filepath = '/home/mroavi/dotfiles/alacritty/.config/alacritty/alacritty.yml'

function! s:goyo_enter()
  " Clear the command line
  echo ''
  " Remove artifacts for NeoVim on true colors transparent background (see https://github.com/junegunn/goyo.vim/issues/71)
  hi! EndOfBuffer gui=NONE guifg=#282828 guibg=NONE
  "hi! VertSplit gui=NONE guifg=#1b202a guibg=NONE
  "hi! StatusLine gui=NONE guifg=#1b202a guibg=NONE
  hi! StatusLineNC gui=NONE guifg=#1b202a guibg=NONE
  lua require"gitsigns".toggle_signs(false)

  " Increase alacritty's font size
  let g:font_size_new = '  size: 18.0'
  let g:font_size_current = matchstr(readfile(expand(g:alacritty_config_filepath)), '^  size:')
  let sed_cmd = "sed -i 's/" . g:font_size_current . "/" . g:font_size_new . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " Change cursor's color
  let g:cursor_color_new = '      cursor:   "#282828"'
  let g:cursor_color_current = matchstr(readfile(expand(g:alacritty_config_filepath)), '^      cursor:')
  let sed_cmd = "sed -i 's/" . escape(g:cursor_color_current, '#') . "/" . escape(g:cursor_color_new, '#') . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " TODO: draw slide number on the bottom right
  " TODO: draw guides to know the slide size

endfunction

function! s:goyo_leave()
  lua require"gitsigns".toggle_signs(true)

  " Reset alacritty's font size
  let sed_cmd = "sed -i 's/" . g:font_size_new . "/" . g:font_size_current . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

  " Reset cursor's color
  let sed_cmd = "sed -i 's/" . escape(g:cursor_color_new, '#') . "/" . escape(g:cursor_color_current, '#') . "/g'"
  silent execute "!" . sed_cmd . " " . g:alacritty_config_filepath

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
