"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Vim philosopy: https://stackoverflow.com/a/1220118/1706778
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '
set nocompatible " No Vi compatibility (`set viminfo=xxx` should come after `set nocompatible`)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'thezeroalpha/vim-lf'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'mroavi/vim-pasta'
Plug 'yegappan/mru'
Plug 'mroavi/vim-tomux'
Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'mroavi/vim-evanesco' 
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://stackoverflow.com/questions/23012391/how-and-where-is-my-viminfo-option-set
set viminfo=%,<800,'50,/50,:100,h,f1
"           | |    |   |   |    | + store file marks 0-9,A-Z
"           | |    |   |   |    + disable 'hlsearch' while loading viminfo
"           | |    |   |   + maximum number of items in the command-line history to be saved
"           | |    |   + maximum number of items in the search pattern history to be saved
"           | |    + files marks saved for the last XX files edited
"           | + maximum num of lines saved for each register (old name for <, vi6.2)
"           + save/restore buffer list

" set number " show line numbers
" set relativenumber " each line is numbered relative to the cursor’s current position
set title " show file in titlebar
set noswapfile " they're just annoying. Who likes them?
"set colorcolumn=80 " highlight column
set wrap linebreak nolist " avoid breaking lines in the middle of words
" set noshowmode " don't show mode in status bar (taken care of by airline)
" set noruler " don't show cursor position in status bar (taken care of by airline)
set laststatus=2 " always display the status line (see :h laststatus)
set noshowcmd " don't show partial typed commands in the right side of the status bar
set cmdheight=1 " limit the cmd line height to one line
set wildmenu " when entering a command, <Tab> shows possible matches above the command line
" set cursorline " highlight the line that the cursor is currently on
set signcolumn=yes " always show sign column
set hidden " allows switching from unwritten buffers and remembers the buffer undo history
set formatoptions-=tc " disable auto-wrap text using textwidth
set clipboard^=unnamed,unnamedplus " sync the unnamed reg with the system and selection clipboards
set shortmess-=S " show search count message when searching
set grepprg=rg\ --vimgrep " program to used for the :grep command.
set grepformat=%f:%l:%c:%m " format to recognize for the :grep command output
set splitbelow splitright " open a new split at to bottom or to the right of the current one
set tabstop=2 " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " number of spaces that a <Tab> counts for while performing editing operations
set shiftwidth=2 " number of spaces for indents in normal mode
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " match indents on new lines.
set smartindent " intelligently dedent / indent new lines based on rules.
set incsearch " live incremental searching
set noshowmatch " no live match highlighting (brief jumping)
set hlsearch " highlight matches
set scrolloff=5 " minimal number of screen lines to keep above and below the cursor
filetype on " enable filetype detection
filetype plugin on " load custom settings based on the filtype. See ~/.vim/ftplugin
filetype indent on " enable file type based indentation

" Disable netrw directory history to prevent the creation of .netrwhist files
let g:netrw_dirhistfile = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Custom mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Write to disk
nnoremap <Leader>w :update<CR>

" Edit the alternate file
nnoremap <silent> <Leader>l :b#<CR>

" Change to the directory of the current buffer and print it
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Toggle spelling language
nnoremap <expr> <F6> ':setlocal spelllang=' . (&spelllang == 'en' ? 'es' : 'en') . '<CR>'

" Select pasted text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

" Spelling completion in normal mode ( https://stackoverflow.com/a/25777332/1706778 )
nnoremap <C-s> :call search('\w\>', 'c')<CR>a<C-X><C-S>

" Add line movements preceded by a count greater than 1 to the jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Grep recursively in current directory and send results to quickfix list
nnoremap <Leader>gr :vimgrep //gj **/*<left><left><left><left><left><left><left><left>
" Substitute last searched pattern with the given text inside every file in the quickfix list
nnoremap <Leader>S :cfdo %s/<C-r>///gc<left><left><left>

" Substitute all occurrences of the content of the search register with new text
" https://stackoverflow.com/a/66440706/1706778
nnoremap <Leader>su :%s//<C-r>=substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>/g<left><left>
vnoremap <Leader>su :s//<C-r>=substitute(@/,'\\<\\|\\>\\|\\V','','g')<CR>/g<left><left>

" Make Y behave like other capitals
nnoremap Y y$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"---------------------------------------------------------------------
" Colorscheme and airline theme settings
"---------------------------------------------------------------------

syntax enable
set termguicolors
colorscheme catppuccin_mocha

"---------------------------------------------------------------------
""" vim-gitgutter
"---------------------------------------------------------------------

set updatetime=100
let g:gitgutter_map_keys = 0
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hr <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <C-j>      <Plug>(GitGutterNextHunk)
nmap <C-k>      <Plug>(GitGutterPrevHunk)

"---------------------------------------------------------------------
"" vim-commentary
"---------------------------------------------------------------------

let b:commentary_startofline = 1

"---------------------------------------------------------------------
""" vim-easy-align
"---------------------------------------------------------------------

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"---------------------------------------------------------------------
""" vim-lf
"---------------------------------------------------------------------

nnoremap <Leader>- <Plug>LfEdit

"---------------------------------------------------------------------
""" MRU
"---------------------------------------------------------------------

nnoremap <Leader>rf :MRU<CR>
let g:MRU_Set_Alternate_File = 1

"---------------------------------------------------------------------
"" vim-highlightedyank
"---------------------------------------------------------------------

let g:highlightedyank_highlight_duration = 200

"---------------------------------------------------------------------
"" vim-highlightedyank
"---------------------------------------------------------------------

cnoreabbrev g    Git
cnoreabbrev git  Git
cnoreabbrev gst  Gedit :
cnoreabbrev gd   Gdiffsplit
cnoreabbrev ga   Gwrite
cnoreabbrev gc   Git commit -v
cnoreabbrev gca  Git commit -v --amend
cnoreabbrev gp   Git push
cnoreabbrev gl   Git pull

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remember cursor position (:h restore-cursor)
autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

" Prevent 'Press ENTER or ...' prompt after external command executes
" https://vi.stackexchange.com/a/21010/27039
command! -nargs=+ -complete=file Grep execute 'silent grep! <args>' | redraw! | cwindow

" Use ripgrep as grep program
" https://phelipetls.github.io/posts/extending-vim-with-ripgrep/
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

" Adds/Removes the passed string to the start/end of the cursor line
function! ToggleString(str, insert_txt_cmd)
  if (search(a:str, 'cn', line('.'))) || (search(a:str, 'cnb', line('.')))
    " Gets the current line, performs the substitution, and replaces it
    call setline(line('.'), substitute(getline('.'), a:str, '', ''))
  else
    silent exe "normal! m`" .. a:insert_txt_cmd .. a:str .. "\<Esc>``"
  endif 
endfunction

" Automatically quit Vim if quickfix window is the last
" https://stackoverflow.com/a/7477056/1706778
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" Automatically open quickfix window after running vimgrep
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost vimgrep cwindow
  autocmd QuickFixCmdPost lvimgrep lwindow
augroup END

" Disable automatic comment insertion
" https://superuser.com/a/271024/1087113
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Change curosr shape in insert mode (https://stackoverflow.com/a/42118416/1706778)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set ttimeout
set ttimeoutlen=1
set ttyfast

" Exit netrw with escape 
au FileType netrw nmap <buffer> <Esc> :Rex<Cr>

"--------------------------------------------------------------------
""" My custom text object for cells
"--------------------------------------------------------------------

" CELL TEXT OBJECT

" Based on: https://vimways.org/2018/transactions-pending/
function! s:cellTextObject(text_object_type)
  " Get the first character of the buffer's 'commentstring'
  let l:comment_char = split(&commentstring, '%s')[0][0]
  " Create a default cell delimeter regex pattern by duplicating the comment character
  let l:cell_delimeter_default = repeat(l:comment_char, 2)
  " Get `b:cell_delimeter` regex pattern if it exists, otherwise get `l:cell_delimeter_default`
  let l:cell_delimeter = get(b:, "cell_delimeter", l:cell_delimeter_default)
  " Move cursor to the previous cell delimiter if found, otherwise, to top-left of buffer
  if (!search(l:cell_delimeter, "bcW")) | silent exe "normal! gg0" | endif 
  " Did we receive 'i' as argument (inner cell)?
  if a:text_object_type ==# 'i'
    " Yes, then jump to next valid statement (skips empty lines and those starting with comment char)
    let l:pattern_statement =  '^\(\s*' . l:comment_char . '\)\@!\s*\S\+'
    call search(l:pattern_statement, "cW")
  endif
  " Start visual line mode
  normal! V
  " Move cursor to the next cell delimiter if found, otherwise, to bottom of buffer
  if (!search(l:cell_delimeter, "W")) | exe "normal! G" | endif
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

" DOCUMENT TEXT OBJECT

" Custom 'in document' text object (from first line to last)
xnoremap <silent> id :<C-u>normal! ggVG<cr>
onoremap <silent> id :<C-u>normal! ggVG<cr>

"-----------------------------------------------------------------------------
""" Execute motion/textobject of code
"-----------------------------------------------------------------------------

"" Works for Lua and Vim (:h map-operator)
"" - https://vi.stackexchange.com/a/5497/27039
"" - https://vi.stackexchange.com/a/25507/27039
"" Interface Lua function that gets the row and col of the '<' and '>' marks
"lua function _G.buf_sel_start() return vim.api.nvim_buf_get_mark(0, '<')[1] end
"lua function _G.buf_sel_end() return vim.api.nvim_buf_get_mark(0, '>')[1] end
"
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

" augroup vim_lua_execute
"   au!
"   " Use either this line which does not support mapping of predefined motions/textobjects
"   au FileType vim,lua nnoremap <buffer> <silent> s :let g:view=winsaveview()<Bar>set opfunc=SourceOperator<CR>g@
"   "" or these lines that do support them
"   "" E.g, here we map Alt+Enter to `sic`, which executes the current cell
"   au FileType vim,lua noremap <buffer> <SID>Operator :let g:view=winsaveview()<Bar>set opfunc=SourceOperator<CR>g@
"   au FileType vim,lua noremap <buffer> <unique> <script> <silent> <Plug>LuaMotionSend <SID>Operator
"   au FileType vim,lua nmap <buffer> s <Plug>LuaMotionSend
"   au FileType vim,lua nmap <buffer> <M-Cr> sic
" augroup END

"=============================================================================
""" DISABLED (enable when necessary)
"=============================================================================

" " Toggle quickfix window (https://stackoverflow.com/a/63162084/1706778)
" function! ToggleQuickFix()
"   if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else | cclose | endif
" endfunction
" nnoremap <silent> <Leader>q :call ToggleQuickFix()<cr>

" " Clear highlight on pressing ESC
" nnoremap <silent> <ESC> :noh<CR><ESC>

" " Debug related mappings for vim and lua files
" augroup vim_lua_debug
"   au!
"   " Clear messages
"   au FileType vim,lua nnoremap <buffer> <Leader>cl :messages clear<CR>
"   " Show messages
"   au FileType vim,lua nnoremap <buffer> <Leader>m :messages<CR>
" augroup END

" " Reset the cursor on start (for older versions of vim, usually not required)
" augroup myCmds
"   au!
"   autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END
" set ttimeout
" set ttimeoutlen=1
" set ttyfast

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
"" WARNING: this clashes with <C-i> (go to next entry in jump list)
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

" " Make star `*` command stay on current word
" " https://superuser.com/questions/299646/vim-make-star-command-stay-on-current-word
" " https://www.reddit.com/r/vim/comments/1xzfjy/go_to_start_of_current_word_if_not_already_there/
" nmap <silent> * :let @/ = '\<'.expand('<cword>').'\>' \| :set hlsearch \| norm wb<Cr>

