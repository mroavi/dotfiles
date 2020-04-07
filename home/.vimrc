"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim philosopy:
" - https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118

" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '
set nocompatible " We don't need Vi compatibility (`set viminfo=xxx` should come after `set nocompatible`)

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" https://github.com/joshdick/onedark.vim/blob/master/README.md
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

" https://stackoverflow.com/questions/23012391/how-and-where-is-my-viminfo-option-set
set viminfo=%,<800,'50,/50,:100,h,f1
"           | |    |   |   |    | + store file marks 0-9,A-Z
"           | |    |   |   |    + disable 'hlsearch' while loading viminfo
"           | |    |   |   + maximum number of items in the command-line history to be saved
"           | |    |   + maximum number of items in the search pattern history to be saved
"           | |    + files marks saved for the last XX files edited
"           | + maximum num of lines saved for each register (old name for <, vi6.2)
"           + save/restore buffer list

set number " show line numbers
set relativenumber " each line is numbered relative to the cursor’s current position
set title " show file in titlebar
set noswapfile " they're just annoying. Who likes them?
"set colorcolumn=80 " highlight column
set wrap linebreak nolist " avoid breaking lines in the middle of words
set noshowmode " don't show mode in status bar (taken care of by airline)
set noruler " don't show cursor position in status bar (taken care of by airline)
set laststatus=2 " always display the status line (see :h laststatus)
set noshowcmd " don't show partial typed commands in the right side of the status bar
set cmdheight=1 " limit the cmd line height to one line
set wildmenu " when entering a command, <Tab> shows possible matches above the command line
set cursorline " highlight the line that the cursor is currently on
set signcolumn=yes " always show sign column
set hidden " allows switching from unwritten buffers and remembers the buffer undo history
set formatoptions-=tc " disable auto-wrap text using textwidth
set clipboard^=unnamed,unnamedplus " sync the unnamed reg with the system and selection clipboards

filetype on " enable filetype detection
filetype plugin on " load custom settings based on the filtype. See ~/.vim/ftplugin

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4 " number of spaces that a <Tab> in the file counts for
set softtabstop=4 " number of spaces that a <Tab> counts for while performing editing operations
set shiftwidth=4 " number of spaces for indents in normal mode
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " match indents on new lines.
set smartindent " intelligently dedent / indent new lines based on rules.

filetype indent on " enable file type based indentation

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch " live incremental searching
set noshowmatch " no live match highlighting (brief jumping)
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
set backspace=indent,eol,start

" Use F5 to toggle the spelling check!
map <F5> :setlocal spell! spelllang=en_us<CR>

" Refresh changed content of file opened in vi(m)
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |  checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Clear last used search pattern when .vimrc is sourced
let @/ = ""

" Strip trailing whitespace from all lines in a file
" https://vi.stackexchange.com/a/456/27039
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
noremap <Leader>tw :call TrimWhitespace()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Replace default prefix Ctrl+w with Ctrl+a
nnoremap <C-a> <C-w>

" Resize splits easier
set <M-S-j>=J
noremap <M-S-j> <C-w>+
set <M-S-k>=K
noremap <M-S-k> <C-w>-
set <M-S-h>=H
noremap <M-S-h> <C-w><
set <M-S-l>=L
noremap <M-S-l> <C-w>>

" Advance up and down faster with the cursor
set <M-j>=j
noremap <M-j> 5j<CR>
set <M-k>=k
noremap <M-k> 5k<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Define symbols for tabstops, spaces and EOLs
set listchars=tab:▸\ ,space:_,eol:¬

" Open help in vertical split
cnoreabbrev H vert bo h

" Switch to next/previous buffer
nnoremap <Leader>j :bnext<CR>
nnoremap <Leader>k :bprevious<CR>

" Delete current buffer
nnoremap <Leader>bd :bdelete<CR>

" Close all buffers but the current one
map <Leader>bo :%bd\|e#<CR>

" Write to disk
nnoremap <Leader>w :w<CR>

" Quit
nnoremap <Leader>q :q<CR>

" Yank to clipboard
vmap <Leader>y "+y

" Source .vimrc
map <Leader>s :source $MYVIMRC<CR>

" Disable Ctl+z kwhich kills the process in vim-gnome)
noremap <C-z> <Nop>

" Toggle display of invisible chars (http://vimcasts.org/episodes/show-invisibles/`)
nmap <F3> :set list!<CR>

" Chorme-like tab commands (conflicts with tmux)
" based on: https://stackoverflow.com/a/31961401/1706778

" Close tab with Ctrl+w
nnoremap <C-w> :tabclose<CR>

" Ctrl+t -> new tab
nnoremap <C-t> :tabnew<CR>

" Ctl+tab -> next tab
set <F13>=[27;5;9~
nnoremap <F13> gt

" Ctrl+Shift + tab -> previous tab
set <F14>=[27;6;9~
nnoremap <F14> gT

" Ctrl+Shift+w -> close tab
set <F15>=[27;6;48~
nnoremap <F15> :close<CR>

" Ctrl+Shift+v -> vertical split
"set <F16>=[27;6;49~
"nnoremap <F16> :split<CR>

" Ctrl+Shift+s -> horizontal split
"set <F17>=[27;6;46~
"nnoremap <F17> :vsplit<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatically install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" A command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Automatically clears search highlight when cursor is moved
Plug 'junegunn/vim-slash'

" Shows the contents of " and @ registers in a sidebar when the respective key is pressed
Plug 'junegunn/vim-peekaboo'

" Defines a new text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'
" Plug 'kana/vim-textobj-indent'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" See https://github.com/vim-airline/vim-airline/wiki/Screenshots
Plug 'vim-airline/vim-airline-themes'

" Provides support for writing LaTeX documents
Plug 'lervag/vimtex'

" Allows you to navigate seamlessly between vim and tmux splits using a consistent set of hotkeys
Plug 'toranb/tmux-navigator'

" FocusGained and FocusLost autocommand events in terminal vim
Plug 'tmux-plugins/vim-tmux-focus-events'

" Automatically saves changes to disk without having to use :w
Plug '907th/vim-auto-save'

" Pairs of handy bracket mappings
"Plug 'tpope/vim-unimpaired'

" Comment functions so powerful—no comment necessary
Plug 'scrooloose/nerdcommenter'

" vim-easyescape makes exiting insert mode easy and distraction free
Plug 'zhou13/vim-easyescape'

" Takes the <no.> out of <no.>w or <number>f{char} by highlighting all possible choices
Plug 'easymotion/vim-easymotion'

" Shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'

" Enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'conradirwin/vim-bracketed-paste'

" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" A file system explorer for the Vim editor (load when NerdTreeToggle is fired)
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Vim plugin that allows use of vifm as a file picker
Plug 'vifm/vifm.vim'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Change the cursor shape based on the current mode
Plug 'wincent/terminus'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Simple tmux statusline generator with support for powerline symbols and vim/airline statusline integration
Plug 'edkolev/tmuxline.vim'

" A very fast, multi-syntax context-sensitive color name highlighter
Plug 'ap/vim-css-color'

" A code-completion engine for Vim
Plug 'ycm-core/YouCompleteMe'

" View and grep man pages in vim
Plug 'vim-utils/vim-man'

" The undo history visualizer for VIM
Plug 'mbbill/undotree'

" Provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" Changes Vim working directory to project root (identified by presence of known directory or file)
Plug 'airblade/vim-rooter'

" Vim support for Julia.
Plug 'JuliaEditorSupport/julia-vim'

" Grab some text and send it to a GNU Screen / tmux / NeoVim Terminal / Vim Terminal
Plug 'jpalardy/vim-slime', { 'for': ['python', 'julia']}

" Seamlessly run Python (or Julia) code from Vim in IPython
Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'julia'] }

" Color schemes
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'nlknguyen/papercolor-theme'
Plug 'lifepillar/vim-gruvbox8'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jacoborus/tender.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme and airline theme settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the color scheme
syntax enable

" Specific color scheme options
let g:gruvbox_contrast_dark='medium'
let g:airline_powerline_fonts = 1
let g:palenight_terminal_italics=1

" WARNING: Do not modify these lines. They are updated by the .zshrc script.
colorscheme solarized8_high
set background=dark
let g:airline_theme='solarized'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile files into a 'build' dir
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-auto-save options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the autosave feature with the file types specified below
let g:auto_save = 0
augroup ft_tex
    au!
    au FileType tex let b:auto_save = 1
augroup END

" Do not display the auto-save notification
"let g:auto_save_silent = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not create default mappings
let g:NERDCreateDefaultMappings = 0

" Make NerdCommentToggle comment all selected lines if there is at least one that is not connected
let g:NERDToggleCheckAllLines = 1

" Delete leftover whitespace when uncommenting empty lines
let g:NERDTrimTrailingWhitespace = 1

let g:NERDDefaultAlign = 'start'

" Remap Ctrl+/ to NERDCommentToggle in normal and visual modes!
set <F18>=
nnoremap <F18> :call NERDComment(0,"toggle")<C-m>
vnoremap <F18> :call NERDComment(0,"toggle")<C-m>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-EASYESCAPE options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable automatic comment insertion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://superuser.com/a/271024/1087113
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Jump anywhere with s
nmap s <Plug>(easymotion-s)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The delay is governed by vim's updatetime option
set updatetime=100

" Remap go to next/previous hunk
nmap <Leader>hj <Plug>(GitGutterNextHunk)
nmap <Leader>hk <Plug>(GitGutterPrevHunk)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shift-Tab to select multiple results (-m flag required)
nnoremap <Leader>rg :MyRg!<CR>
nnoremap <Leader>fi :MyFiles!<CR>
nnoremap <Leader>gf :GFiles<CR>
nnoremap <Leader>gs :GFiles?<CR>
nnoremap <Leader>ls :Buffers<CR>
nnoremap <Leader>li :Lines<CR>
nnoremap <Leader>bl :BLines<CR>
nnoremap <Leader>co :Commits<CR>
nnoremap <Leader>bc :BCommits<CR>
nnoremap <Leader>hi :MyHistory<CR>
nnoremap <Leader>ch :History:<CR>
nnoremap <Leader>cm :Commands<CR>
nnoremap <Leader>ma :Maps<CR>

" -------------------------------------------------------------------
" Files
" command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, s:p(<bang>0), <bang>0)
" -------------------------------------------------------------------
command! -nargs=? -bang -complete=dir MyFiles call fzf#vim#files(
    \ <q-args>,
    \ <bang>0 ? fzf#vim#with_preview({'options': ['--preview-window', 'up:60%', '--no-height']})
    \         : fzf#vim#with_preview({'options': ['--preview-window', 'up:60%'], 'down': '40%'}),
    \ <bang>0)

" -------------------------------------------------------------------
" Rg
" -------------------------------------------------------------------
" Advanced ripgrep integration
" See https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command,
    \                     '--preview-window', 'up:60%', '--no-height'], 'down': '100%'}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang MyRg call RipgrepFzf(<q-args>, <bang>0)

"" WIP
"" Template based on https://www.reddit.com/r/vim/comments/a1g4cp/fzf_with_preview_window_ag_search_on_a_directory/
"" See https://github.com/junegunn/fzf/blob/master/README-VIM.md
"command! -nargs=* MyRg call fzf#run(fzf#wrap(fzf#vim#with_preview({
"        \ 'source': 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
"        \ 'sink':'edit',
"        \ 'down': '100%',
"        \ 'options': ['--no-reverse', '--preview-window', 'up:60%']
"        \ })))

" -------------------------------------------------------------------
" History
" command! -bang -nargs=* History call s:history(<q-args>, s:p(<bang>0), <bang>0)
" -------------------------------------------------------------------
command! -bang -nargs=* MyHistory call s:history(
    \ <q-args>,
    \ <bang>0 ? fzf#vim#with_preview({'options': ['--preview-window', 'up:60%', '--no-height']})
    \         : fzf#vim#with_preview({'options': ['--preview-window', 'up:60%'], 'down': '80%'}),
    \ <bang>0)

function! s:history(arg, extra, bang)
  let bang = a:bang || a:arg[len(a:arg)-1] == '!'
  if a:arg[0] == ':'
    call fzf#vim#command_history(bang)
  elseif a:arg[0] == '/'
    call fzf#vim#search_history(bang)
  else
    call fzf#vim#history(a:extra, bang)
  endif
endfunction

" -------------------------------------------------------------------
" Extra
" -------------------------------------------------------------------
" Default fzf layout
let g:fzf_layout = { 'down': '~50%' }

" This are the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" julia-vim options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable matchit plugin (this plugin is distributed with Vim)
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vifm.vim options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/vifm/vifm.vim/issues/19
let g:vifm_embed_term=1
let g:vifm_embed_split=1

" Toggle vifm
"nnoremap <Leader>/ :leftabove vertical 40Vifm<CR>
nnoremap <Leader>/  :below 30Vifm<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tmux-navigator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-highlightedyank options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 200

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>fx :YcmCompleter FixIt<CR>
noremap <Leader>fo :YcmCompleter Format<CR>
nnoremap <Leader>gt :YcmCompleter GetType<CR>
nnoremap <Leader>gd :YcmCompleter GetDoc<CR>
nnoremap <F2> :YcmCompleter RefactorRename<Space>

":set completeopt=preview,menuone " default
:set completeopt=menuone

" Show the full diagnostic text
"let g:ycm_key_detailed_diagnostics = '<leader>d' " default
let g:ycm_key_detailed_diagnostics = ''

" Auto-close the preview window after the user accepts the offered completion string
"let g:ycm_autoclose_preview_window_after_completion = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" undotree options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>u :UndotreeShow<CR>
let g:undotree_SetFocusWhenToggle = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-slime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
let g:slime_no_mappings = 1

" Map to Ctrl-Return
set <F19>=[27;5;40~
autocmd FileType python,julia xmap <buffer> <F19> <Plug>SlimeRegionSend
autocmd FileType python,julia nmap <buffer> <F19> <Plug>SlimeLineSend
autocmd FileType python,julia nmap <buffer> <C-c>v <Plug>SlimeConfig

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-ipython-cell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'

"" Run whole script (TODO: only works for Python)
set <F20>=[27;6;44~
autocmd FileType python,julia nnoremap <buffer> <F20> :IPythonCellRun<CR>

" Execute the current cell
execute "set <M-CR>=\<esc>\<cr>"
autocmd FileType python,julia nnoremap <buffer> <M-CR> :IPythonCellExecuteCell<CR>

" Jump to the previous/next cell headers
set <M-k>=k
autocmd FileType python,julia nnoremap <buffer> <M-k> :IPythonCellPrevCell<CR>
set <M-j>=j
autocmd FileType python,julia nnoremap <buffer> <M-j> :IPythonCellNextCell<CR>

" TODO
"autocmd FileType python,julia nnoremap <buffer> <Leader>l :IPythonCellClear<CR>
"autocmd FileType python,julia nnoremap <buffer> <Leader>x :IPythonCellClose<CR>

