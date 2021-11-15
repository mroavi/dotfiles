" TEMP: fixes gx bug in Neovim (https://github.com/vim/vim/issues/4738#issuecomment-856925080)
nnoremap <silent> gx :execute 'silent! !xdg-open ' . shellescape(expand('<cWORD>'), 1)<cr>

" Write to disk
nnoremap <Leader>w :write<CR>

" Suspend vim
nnoremap <Leader>z <C-z><CR>

" Close the current window
nnoremap <Leader>x :close<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Delete current buffer without losing split windows
" https://stackoverflow.com/a/4468491/1706778
nnoremap <silent> <Leader>dd :bprevious<bar>:bdelete #<CR>

" Edit the alternate file
nnoremap <silent> <Leader>l :b#<CR>

" Go to previous (last accessed) window
nnoremap <silent><Leader>; <C-w>p

" Create horizontal an vertical splits
map <Leader>sj :split<CR>
map <Leader>sl :vsplit<CR>

" Substitute all occurrences of the content of the search register with new text
nnoremap <Leader>su :%s//<C-r>=substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>/g<left><left>
vnoremap <Leader>su :s//<C-r>=substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>/g<left><left>

" Grep recursively in current directory and send results to quickfix list
nnoremap <Leader>gr :vimgrep //gj **/*<left><left><left><left><left><left><left><left>
" Run :substitute inside every entry in the quickfix list
nnoremap <Leader>sc :cfdo %s///gc<left><left><left>

" Select pasted text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

" Change to the directory of the current buffer and print it
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Clear highlight on pressing ESC
nnoremap <silent> <ESC> :noh<CR><ESC>

" Add line movements preceded by a count greater than 1 to the jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Avoid a double slash when pressing / when using wildmenu (like in zsh)
cnoremap <expr> / wildmenumode() ? "\<C-y>" : "/"

" Resize splits easier
noremap <C-M-Down> :resize -3<CR>
noremap <C-M-Up> :resize +3<CR>
noremap <C-M-Left> :vertical resize +3<CR>
noremap <C-M-Right> :vertical resize -3<CR>

" Spelling completion in normal mode ( https://stackoverflow.com/a/25777332/1706778 )
nnoremap <C-s> :call search('\w\>', 'c')<CR>a<C-X><C-S>

" Alternate mappings for go to next/prev mark
nnoremap <Leader>k ['
nnoremap <Leader>j ]'

" Highlight the yanked text
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" https://gist.github.com/romainl/d2ad868afd7520519057475bd8e9db0c
" gq wrapper that:
" - tries its best at keeping the cursor in place
" - tries to handle formatter errors
function! Format(type, ...)
    normal! '[v']gq
    if v:shell_error > 0
        silent undo
        redraw
        echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
    endif
    call winrestview(w:gqview)
    unlet w:gqview
endfunction
nmap <silent> gq :let w:gqview = winsaveview()<CR>:set opfunc=Format<CR>g@

" Jump to next delimiter
function! GoToNextDelim(delim)
  if (!search(a:delim, "W"))
    silent exe "normal! G"
  endif 
endfunction

" Jump to previous delimeter
function! GoToPrevDelim(delim)
  if (!search(a:delim, "bW"))
    silent exe "normal! gg"
  endif 
endfunction

" My custom text object for cells
" Based on: https://vimways.org/2018/transactions-pending/
function! s:cellTextObject(text_object_type)
  " Get the first character of the 'commentstring' and duplicate it
  let l:delim_cell = repeat(split(&commentstring, '%s')[0][0], 2)
  " Create a regex that searches the cell delim
  "let l:pattern_cell = '^' . l:delim_cell
  let l:pattern_cell = l:delim_cell
  " Move cursor to the previous cell delimiter if found, otherwise, to top-left of buffer
  if (!search(l:pattern_cell, "bcW")) | silent exe "normal! gg0" | endif 
  " Did we receive 'i' as argument (inner cell)?
  if a:text_object_type ==# 'i'
    " Yes, then jump to next valid statement (skips empty lines and those starting with comment char)
    let l:pattern_statement =  '^\(\s*' . l:delim_cell[0] . '\)\@!\s*\S\+'
    call search(l:pattern_statement, "cW")
  endif
  " Start visual line mode
  normal! V
  " Move cursor to the next cell delimiter if found, otherwise, to bottom of buffer
  if (!search(l:pattern_cell, "W")) | exe "normal! G" | endif
  " Did we receive 'i' as argument (inner cell)?
  if a:text_object_type ==# 'i'
    " Yes, then jump to prev valid statement (skips empty lines and those starting with comment char)
    call search(l:pattern_statement, "cbW")
  endif
endfunction

" Custom 'in cell' text object
xnoremap <silent> ic :<C-u>call <sid>cellTextObject('i')<cr>
onoremap <silent> ic :<C-u>call <sid>cellTextObject('i')<cr>
" Custom 'around cell' text object
xnoremap <silent> ac :<C-u>call <sid>cellTextObject('a')<cr>
onoremap <silent> ac :<C-u>call <sid>cellTextObject('a')<cr>

" Custom 'in document' text object (from first line to last)
xnoremap <silent> id :<C-u>normal! ggVG<cr>
onoremap <silent> id :<C-u>normal! ggVG<cr>

 " Open help in vertical split
 cnoreabbrev H vert bo h

" Toggle quickfix window (https://stackoverflow.com/a/63162084/1706778)
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction
nnoremap <silent> <Leader>q :call ToggleQuickFix()<cr>

" Automatically open quickfix window after running vimgrep
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost vimgrep cwindow
  autocmd QuickFixCmdPost lvimgrep lwindow
augroup END

" Delete marks a-z on the current line (https://vi.stackexchange.com/a/13986)
function! Delmarks()
let l:m = join(filter(
   \ map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'),
   \ 'line("''".v:val) == line(".")'))
if !empty(l:m)
    exe 'delmarks' l:m
endif
endfunction
nnoremap <silent> <Leader>dm :<c-u>call Delmarks()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DISABLED (enable when necessary)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Redirect the output of a Vim or external command into a scratch buffer
"" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
"function! Redir(cmd, rng, start, end)
"for win in range(1, winnr('$'))
"  if getwinvar(win, 'scratch')
"    execute win . 'windo close'
"  endif
"endfor
"if a:cmd =~ '^!'
"  let cmd = a:cmd =~' %'
"    \ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
"    \ : matchstr(a:cmd, '^!\zs.*')
"  if a:rng == 0
"    let output = systemlist(cmd)
"  else
"    let joined_lines = join(getline(a:start, a:end), '\n')
"    let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
"    let output = systemlist(cmd . " <<< $" . cleaned_lines)
"  endif
"else
"  redir => output
"  execute a:cmd
"  redir END
"  let output = split(output, "\n")
"endif
"vnew
"let w:scratch = 1
"setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
"call setline(1, output)
"endfunction
"command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

"" Convert all tabs to 2 space tabs (https://stackoverflow.com/a/16892086/1706778)
"fun! ReTab()
"  set tabstop=4 softtabstop=4 noexpandtab
"  retab!
"  set tabstop=2 softtabstop=2 expandtab
"  retab!
"endfun
"nnoremap <Leader>rt :call ReTab()<CR>

"" Strip trailing whitespace from all lines (https://vi.stackexchange.com/a/456/27039)
"fun! TrimWhitespace()
"  let l:save = winsaveview()
"  keeppatterns %s/\s\+$//e
"  call winrestview(l:save)
"endfun
"command! TrimWhitespace call TrimWhitespace()
"noremap <Leader>rw :call TrimWhitespace()<CR>

"" Open a new unnamed buffer
"nnoremap <M-n> :enew<CR>

"" Ignore case in command line
"augroup toggle_ignorecase
"  autocmd!
"  autocmd CmdLineEnter : set ignorecase smartcase
"  autocmd CmdlineLeave : set noignorecase nosmartcase
"augroup END

"" Chrome-like tab mappings
"nnoremap <C-t>     :tabnew<CR>
"nnoremap <C-S-W>   :close<CR>

"" Source .vimrc
"map <Leader>sv :source $MYVIMRC<CR>

"" Write and source the currently opened file
"map <Leader>ss :w<CR>:source %<CR>

"" Close the quickfix window
"nnoremap <Leader>cx :cclose<CR>

"" Go to previous (last accessed) window
"nnoremap <silent> <Leader>; <C-w><C-p>

"" Move selected lines up/down reindenting if necessary
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

"" Print the highlight group used for the word under the cursor
"" https://vi.stackexchange.com/q/18454/27039
"command ShowHighlightGroup  echo synIDattr(synID(line("."), col("."), 1), "name")

"" Move to next/prev buffer
"nnoremap <silent> <S-h> :bprevious<CR>
"nnoremap <silent> <S-l> :bnext<CR>

"" Open buffer wildmenu (https://noahfrederick.com/log/vim-wildcharm)
"" TODO: this clashes with <C-i> (go to next entry in jump list)
"set wildcharm=<C-z>
"nnoremap <Tab> :b <C-z><S-Tab>

"" Close all buffers but the current one
"map <Leader>bo :%bdelete\|e#\|bd#<CR>

