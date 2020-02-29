""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Based on: 
" - https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118

set nocompatible " We don't need Vi compatibility

set number " show line numbers
set relativenumber " each line in your file is numbered relative to the cursor’s current position
set showmode " show mode in status bar (insert/replace/...)
set showcmd " show typed command in status bar
set ruler " show cursor position in status bar
set title " show file in titlebar
set laststatus=2 " use 2 lines for the status bar

set tabstop=4 " number of spaces a tab counts for
set shiftwidth=4 " spaces for autoindents
set expandtab " use spaces instead of tabs. 
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

set noswapfile " They're just annoying. Who likes them?

set incsearch " live incremental searching
set noshowmatch " no live match highlighting (brief jumping)
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

set t_Co=256 " needed so that colorschemes take effect in xterm
"set colorcolumn=80 " highlight column
set wrap linebreak nolist " avoid breaking lines in the middle of words

" Use F5 to toggle the spelling check!
:map <F5> :setlocal spell! spelllang=en_us<CR>

" Refresh changed content of file opened in vi(m)
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |  checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Remap :FZF to Ctrl+o
nnoremap <C-o> :FZF<CR>

" Remap default prefix from Ctrl+w to Ctrl+a 
nnoremap <C-a> <C-w>

" Close tab with Ctrl+w
nnoremap <C-w> :tabclose<CR>

" Disable Ctl+z (which kills the process in vim-gnome)
noremap <C-z> <Nop>

" Toggle NERDTree with with the '\' key
nnoremap <Leader> :NERDTreeToggle<CR>

" Ctrl+t -> new tab
nnoremap <C-t> :tabnew<CR>

" Chorme-like tab commands (conflicts with tmux)
" based on: https://stackoverflow.com/a/31961401/1706778
set timeout timeoutlen=1000 ttimeoutlen=100

" Ctl+tab -> next tab
"set <F13>=[27;5;9~
"nnoremap <F13> gt

" Ctrl+Shift + tab -> previous tab
"set <F14>=[27;6;9~
"nnoremap <F14> gT

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

" Automatically install vim-plug if it is not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.

" Vim support for Julia.
Plug 'JuliaEditorSupport/julia-vim'

" A command-line fuzzy finder 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Automatically clears search highlight when cursor is moved
Plug 'junegunn/vim-slash'

" Shows the contents of " and @ registers in a sidebar when the respective key is pressed
Plug 'junegunn/vim-peekaboo'

" A file system explorer for the Vim editor (load when NerdTreeToggle is
" fired)
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Defines a new text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'
" Plug 'kana/vim-textobj-indent'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" See: https://github.com/vim-airline/vim-airline/wiki/Screenshots
Plug 'vim-airline/vim-airline-themes'

" Provides support for writing LaTeX documents
Plug 'lervag/vimtex'

" Allows you to navigate seamlessly between vim and tmux splits using a
" consistent set of hotkeys 
Plug 'toranb/tmux-navigator'

" FocusGained and FocusLost autocommand events in terminal vim
Plug 'tmux-plugins/vim-tmux-focus-events'

" Automatically saves changes to disk without having to use :w
Plug '907th/vim-auto-save'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Comment functions so powerful—no comment necessary
Plug 'scrooloose/nerdcommenter'

" vim-easyescape makes exiting insert mode easy and distraction free
Plug 'zhou13/vim-easyescape'

" Colorschemes
Plug 'crusoexia/vim-monokai'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme and airline theme settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the color scheme
syntax enable

"colorscheme monokai
"let g:airline_theme='luna'

set background=dark
colorscheme solarized
let g:airline_theme='solarized' 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-auto-save options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not display the auto-save notification
"let g:auto_save_silent = 1 

" Use the autosave feature with the file types specified below
let g:auto_save = 0
augroup ft_tex
    au!
    au FileType tex let b:auto_save = 1
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDComment options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not create default mappings 
let g:NERDCreateDefaultMappings = 0

" NerdCommentToggle will comment all selected lines if there is at least one
" that is not connected
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
