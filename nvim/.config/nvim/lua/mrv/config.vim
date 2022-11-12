" Grep recursively in current directory and send results to quickfix list
nnoremap <Leader>gr :vimgrep //gj **/*<left><left><left><left><left><left><left><left>
" Substitute last searched pattern with the given text inside every file in the quickfix list
nnoremap <Leader>S :cfdo %s/<C-r>///gc<left><left><left>

" Remember cursor position (:h restore-cursor)
autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

" Adds/Removes the passed string to the start/end of the cursor line
function! ToggleString(str, insert_txt_cmd)
  if (search(a:str, 'cn', line('.'))) || (search(a:str, 'cnb', line('.')))
    " Gets the current line, performs the substitution, and replaces it
    call setline(line('.'), substitute(getline('.'), a:str, '', ''))
  else
    silent exe "normal! m`" .. a:insert_txt_cmd .. a:str .. "\<Esc>``"
  endif 
endfunction

" Use ripgrep as grep program
" https://phelipetls.github.io/posts/extending-vim-with-ripgrep/
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

" Prevent 'Press ENTER or ...' prompt after external command executes
" https://vi.stackexchange.com/a/21010/27039
command! -nargs=+ -complete=file Grep execute 'silent grep! <args>' | redraw! | cwindow

"" Make star `*` command stay on current word
"" https://superuser.com/questions/299646/vim-make-star-command-stay-on-current-word
"" https://www.reddit.com/r/vim/comments/1xzfjy/go_to_start_of_current_word_if_not_already_there/
nmap <silent> * :let @/ = '\<'.expand('<cword>').'\>' \| :set hlsearch \| norm wb<Cr>

" ============================================================================
""" DISABLED (enable when necessary)
" ============================================================================

" ----------------------------------------------------------------------------
""" My custom text object for cells
" ----------------------------------------------------------------------------

" CELL TEXT OBJECT

"" Based on: https://vimways.org/2018/transactions-pending/
"function! s:cellTextObject(text_object_type)
"  " Get the first character of the buffer's 'commentstring'
"  let l:comment_char = split(&commentstring, '%s')[0][0]
"  " Create a default cell delimeter regex pattern by duplicating the comment character
"  let l:cell_delimeter_default = repeat(l:comment_char, 2)
"  " Get `b:cell_delimeter` regex pattern if it exists, otherwise get `l:cell_delimeter_default`
"  let l:cell_delimeter = get(b:, "cell_delimeter", l:cell_delimeter_default)
"  " Move cursor to the previous cell delimiter if found, otherwise, to top-left of buffer
"  if (!search(l:cell_delimeter, "bcW")) | silent exe "normal! gg0" | endif 
"  " Did we receive 'i' as argument (inner cell)?
"  if a:text_object_type ==# 'i'
"    " Yes, then jump to next valid statement (skips empty lines and those starting with comment char)
"    let l:pattern_statement =  '^\(\s*' . l:comment_char . '\)\@!\s*\S\+'
"    call search(l:pattern_statement, "cW")
"  endif
"  " Start visual line mode
"  normal! V
"  " Move cursor to the next cell delimiter if found, otherwise, to bottom of buffer
"  if (!search(l:cell_delimeter, "W")) | exe "normal! G" | endif
"  " Did we receive 'i' as argument (inner cell)?
"  if a:text_object_type ==# 'i'
"    " Yes, then jump to prev valid statement (skips empty lines and those starting with comment char)
"    call search(l:pattern_statement, "cbW")
"  endif
"endfunction
"" Custom 'in cell' text object
"xnoremap <silent> ic :<C-u>call <sid>cellTextObject('i')<cr>
"onoremap <silent> ic :<C-u>call <sid>cellTextObject('i')<cr>
"" Custom 'around cell' text object
"xnoremap <silent> ac :<C-u>call <sid>cellTextObject('a')<cr>
"onoremap <silent> ac :<C-u>call <sid>cellTextObject('a')<cr>

" DOCUMENT TEXT OBJECT

"" Custom 'in document' text object (from first line to last)
"xnoremap <silent> id :<C-u>normal! ggVG<cr>
"onoremap <silent> id :<C-u>normal! ggVG<cr>

" ----------------------------------------------------------------------------
""" Execute motion/textobject of code
" ----------------------------------------------------------------------------

"" Works for Lua and Vim (:h map-operator)
"" - https://vi.stackexchange.com/a/5497/27039
"" - https://vi.stackexchange.com/a/25507/27039
"" Interface Lua function that gets the row and col of the '<' and '>' marks
"lua function _G.buf_sel_start() return vim.api.nvim_buf_get_mark(0, '<')[1] end
"lua function _G.buf_sel_end() return vim.api.nvim_buf_get_mark(0, '>')[1] end

"" Function that gets executed after the motion is finished
"function! SourceOperator(type)
"  " Yank the text covered by the motion/textobject
"  silent exe 'normal! `[v`]Vy'    
"  " Make a range with the selection start and end row numbers with 'source'
"  let @z = v:lua.buf_sel_start() . "," . v:lua.buf_sel_end() . "source"
"  " Execute content of the z register
"  @z
"  " Restore the view of the current window (mainly to remember the cursor pos)
"  call winrestview(g:view)
"endfunction

"augroup vim_lua_execute
"  au!

"  " Use either this line which does not support mapping of predefined motions/textobjects
"  au FileType vim,lua nnoremap <buffer> <silent> s :let g:view=winsaveview()<Bar>set opfunc=SourceOperator<CR>g@

"  "" or these lines that do support them
"  "" E.g, here we map Alt+Enter to `sic`, which executes the current cell
"  "au FileType vim,lua noremap <buffer> <SID>Operator :let g:view=winsaveview()<Bar>set opfunc=SourceOperator<CR>g@
"  "au FileType vim,lua noremap <buffer> <unique> <script> <silent> <Plug>LuaMotionSend <SID>Operator
"  "au FileType vim,lua nmap <buffer> s <Plug>LuaMotionSend
"  "au FileType vim,lua nmap <buffer> <M-Cr> sic

"augroup END

" ----------------------------------------------------------------------------

"" Substitute all occurrences of the content of the search register with new text
"" https://stackoverflow.com/a/66440706/1706778
"nnoremap <Leader>su :%s//<C-r>=substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>/g<left><left>
"vnoremap <Leader>su :s//<C-r>=substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>/g<left><left>

"" Toggle quickfix window (https://stackoverflow.com/a/63162084/1706778)
"function! ToggleQuickFix()
"  if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else | cclose | endif
"endfunction
"nnoremap <silent> <Leader>q :call ToggleQuickFix()<cr>

"" Automatically quit Vim if quickfix window is the last
"" https://stackoverflow.com/a/7477056/1706778
"aug QFClose
"  au!
"  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
"aug END

"" Debug related mappings for vim and lua files
"augroup vim_lua_debug
"  au!
"  " Clear messages
"  au FileType vim,lua nnoremap <buffer> <Leader>cl :messages clear<CR>
"  " Show messages
"  au FileType vim,lua nnoremap <buffer> <Leader>m :messages<CR>
"augroup END

"" Automatically open quickfix window after running vimgrep
"augroup quickfix
"  autocmd!
"  autocmd QuickFixCmdPost vimgrep cwindow
"  autocmd QuickFixCmdPost lvimgrep lwindow
"augroup END

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

"" Alternate mappings for go to next/prev mark
"nnoremap <Leader>k ['
"nnoremap <Leader>j ]'

"" Delete current buffer without losing split windows
"" https://stackoverflow.com/a/4468491/1706778
"nnoremap <silent> <Leader>dd :bprevious<bar>:bdelete #<CR>

"" https://gist.github.com/romainl/d2ad868afd7520519057475bd8e9db0c
"" gq wrapper that:
"" - tries its best at keeping the cursor in place
"" - tries to handle formatter errors
"function! Format(type, ...)
"    normal! '[v']gq
"    if v:shell_error > 0
"        silent undo
"        redraw
"        echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
"    endif
"    call winrestview(w:gqview)
"    unlet w:gqview
"endfunction
"nmap <silent> gq :let w:gqview = winsaveview()<CR>:set opfunc=Format<CR>g@

"" Open help in vertical split
"cnoreabbrev h vert bo h

"" Run macro on multiple lines
"" https://www.rockyourcode.com/run-macro-on-multiple-lines-in-vim/
"xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
"function! ExecuteMacroOverVisualRange()
"  echo "@".getcmdline()
"  execute ":'<,'>normal @".nr2char(getchar())
"endfunction
"" See: https://youtu.be/RaynmHxUixA for a better alternative

"" Delete marks a-z on the current line (https://vi.stackexchange.com/a/13986)
"function! Delmarks()
"let l:m = join(filter(
"   \ map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)'),
"   \ 'line("''".v:val) == line(".")'))
"if !empty(l:m)
"    exe 'delmarks' l:m
"endif
"endfunction
""nnoremap <silent> <Leader>dm :<C-u>call Delmarks()<CR>
