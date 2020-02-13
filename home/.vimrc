"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Based on: 
" - https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118

" We don't need Vi compatibility
set nocompatible

set number " show line numbers
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
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.


" Disable Ctl+z (which kills the process in vim-gnome)
noremap <c-z> <Nop>

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

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'crusoexia/vim-monokai'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END -  vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the color scheme
syntax enable
colorscheme monokai

" Set the airline theme
let g:airline_theme='luna'

" Use 'jk' or 'kj' to return to normal  mode
inoremap jk <ESC>
inoremap kj <ESC>
vnoremap jk <ESC>
vnoremap kj <ESC>

" Toggle NERDTree with with the '\' key
nnoremap <Leader> :NERDTreeToggle<CR>
