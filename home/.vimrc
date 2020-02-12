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

syntax enable

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

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'crusoexia/vim-monokai'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Set monokai colorscheme
colorscheme monokai

" Use 'jk' to exit insert mode
inoremap jk <ESC>
