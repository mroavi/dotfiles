""" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vi(m) philosophy: https://stackoverflow.com/a/1220118/1706778
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('mrv.plugins')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
colorscheme marlin
"set background=light
"colorscheme github

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://neovim.io/doc/user/options.html#'shada'
set shada=<10,'99,/20,:99,h,f1
"         |   |   |   |   | + store file marks 0-9,A-Z
"         |   |   |   |   + disable 'hlsearch' while loading viminfo
"         |   |   |   + max num of items in the cmd-line hist to be saved
"         |   |   + max num of items in the search history to be saved
"         |   + number of old files remembered
"         + maximum num of lines saved for each register
set number relativenumber " lines are numbered relative to the current line
set noswapfile " they're just annoying. Who likes them?
set wrap linebreak nolist " avoid breaking lines in the middle of words
set hidden " allows switching from unwritten buffers, remember the undo history
set formatoptions-=tc " disable auto-wrap text using textwidth
set splitbelow splitright " open split below or to the right of the current one
set signcolumn=yes " always show sign column
set tabstop=2 softtabstop=2 shiftwidth=2 " configure number of spaces per tab
set expandtab " use spaces instead of tab chars
set shiftround " tab / shifting moves to closest tabstop
set smartindent " intelligently dedent / indent new lines based on rules
set updatetime=100 " among others, governs gitgutter's update time
set inccommand=split " shows the effects of a command incrementally as you type
set listchars=tab:▸\ ,space:_,eol:¬ " symbols for tabstops, spaces and EOLs
set scrolloff=5 " min num of screen lines to keep above and below the cursor
set completeopt=menuone,noselect " compe prerequisites
set shortmess+=c " avoid showing verbose messages when using completion
"set noshowmode " don't show mode in status bar (taken care of by lightline)
"set ignorecase smartcase " ignore case if the typed letters are all lowercase
set clipboard=unnamedplus

" Disable automatic comment insertion (https://superuser.com/a/271024/1087113)
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Scroll by a third of window height (https://stackoverflow.com/a/16574696/1706778)
execute "set scroll=" .&lines / 3
au VimResized * execute "set scroll=" . &lines / 3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Custom behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Write to disk
nnoremap <Leader>w :write<CR>

" Close the current window
nnoremap <Leader>x :close<CR>

" Close the quickfix window
nnoremap <Leader>cx :cclose<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Yank/Paste to/from clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Add line movements preceded by a count greater than 1 to the jump list
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Move to next/prev buffer
nnoremap <silent> <M-h> :bprevious<CR>
nnoremap <silent> <M-l> :bnext<CR>

" Open a new unnamed buffer
nnoremap <M-n> :enew<CR>

" Edit the alternate file
nnoremap <silent> <Leader>l :b#<CR>

" Go to previous (last accessed) window
nnoremap <silent> <Leader>; <C-w><C-p>

" Close all buffers but the current one
map <Leader>bo :%bdelete\|e#\|bd#<CR>

" Create horizontal an vertical splits
map <Leader>sp :split<CR>
map <Leader>vs :vsplit<CR>

" Resize splits easier
noremap <M-S-j> :resize -3<CR>
noremap <M-S-k> :resize +3<CR>
noremap <M-S-h> :vertical resize +3<CR>
noremap <M-S-l> :vertical resize -3<CR>

" Substitute all occurrences of the content of the search register with new text
nnoremap <Leader>sa :%s//<C-r>=substitute(@/,'\\<\\|\\>','','g')<CR>/g<left><left>
vnoremap <Leader>sa :s//<C-r>=substitute(@/,'\\<\\|\\>','','g')<CR>/g<left><left>

" Grep recursively in current directory
nnoremap <Leader>gr :vimgrep //gj **/*<left><left><left><left><left><left><left><left>

" Select pasted text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

" Source .vimrc
map <Leader>sv :source $MYVIMRC<CR>

" Write and source the currently opened file
map <Leader>ss :w<CR>:source %<CR>

" Change to the directory of the current buffer and print it
nnoremap <Leader>cd :cd %:p:h<CR> :pwd<CR>

" Open help in vertical split
cnoreabbrev H vert bo h

" Clear highlight on pressing ESC
nnoremap <silent> <ESC> :noh<CR><ESC>

" Chrome-like tab mappings
nnoremap <C-t>     :tabnew<CR>
nnoremap <C-S-W>   :close<CR>

"" Spelling completion in normal mode TODO: clahes with compe
"inoremap <expr> <CR> pumvisible() ? "\<C-y><Esc>" : "\<CR>"
"nnoremap <C-s> :call search('\w\>', 'c')<CR>a<C-X><C-S>

" Avoid a double slash when pressing / when using wildmenu (similar to zsh)
cnoremap <expr> / wildmenumode() ? "\<C-y>" : "/"

" Ignore case in command line
augroup toggle_ignorecase
  autocmd!
  autocmd CmdLineEnter : set ignorecase smartcase
  autocmd CmdlineLeave : set noignorecase nosmartcase
augroup END

"" Move selected lines up/down reindenting if necessary
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

" Strip trailing whitespace from all lines (https://vi.stackexchange.com/a/456/27039)
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
noremap <Leader>rw :call TrimWhitespace()<CR>

" Convert all tabs to 2 space tabs (https://stackoverflow.com/a/16892086/1706778)
fun! ReTab()
  set tabstop=4 softtabstop=4 noexpandtab
  retab!
  set tabstop=2 softtabstop=2 expandtab
  retab!
endfun
nnoremap <Leader>rt :call ReTab()<CR>

" Jump to next delimeter
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

" Print the highlight group used for the word under the cursor
" https://vi.stackexchange.com/q/18454/27039
command ShowHighlightGroup  echo synIDattr(synID(line("."), col("."), 1), "name")

" Highlight the yanked text
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" My custom text object for cells
" Based on: https://vimways.org/2018/transactions-pending/
function! s:inCell(text_object_type)
  " Get the first character of the 'commentstring' and duplicate it
  let l:delim_cell = repeat(split(&commentstring, '%s')[0][0], 2)
  " Create a regex that searches the cell delim
  "let l:pattern_cell = '^' . l:delim_cell
  let l:pattern_cell = l:delim_cell
  " Move cursor to the previous cell delimiter if found, otherwise, to top of buffer
  if (!search(l:pattern_cell, "bcW")) | silent exe "normal! gg" | endif 
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
xnoremap <silent> ic :<c-u>call <sid>inCell('i')<cr>
onoremap <silent> ic :<c-u>call <sid>inCell('i')<cr>
" Custom 'around cell' text object
xnoremap <silent> ac :<c-u>call <sid>inCell('a')<cr>
onoremap <silent> ac :<c-u>call <sid>inCell('a')<cr>

" Custom 'in document' text object (from first line to last)
xnoremap <silent> id :<c-u>normal! ggVG<cr>
onoremap <silent> id :<c-u>normal! ggVG<cr>

" Removed plugins
" {{{1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""Plug 'jvirtanen/vim-octave', { 'for': 'octave' } -- Syntax highlighting for GNU Octave
""Plug 'mhinz/vim-startify' -- A fancy start screen for Vim/Neovim
""Plug 'psliwka/vim-smoothie' -- Smooth scrolling for Vim done right
""Plug 'dstein64/nvim-scrollview' -- A Neovim plugin that displays (non-interactive) scrollbars.
""Plug 'mroavi/vim-julia-cell', { 'for': ['julia'] } -- Cell support for Julia in Vim
""Plug 'benmills/vimux' -- Easily interact with tmux from vim.
""Plug 'rhysd/vim-grammarous' -- A powerful grammar checker for Vim using LanguageTool

""" Lf terminal file manager for vim 
"Plug 'ptzz/lf.vim'
"Plug 'rbgrouleff/bclose.vim'

"" A light and configurable statusline/tabline plugin
"Plug 'itchyny/lightline.vim'

"" Provides support for writing LaTeX documents
"Plug 'lervag/vimtex'

"" Changes Vim working directory to project root
"Plug 'airblade/vim-rooter'

"" A simple, easy-to-use Vim alignment plugin
"Plug 'junegunn/vim-easy-align'

"" Simple tmux statusline generator, integrates with lightline/airline statusline
"Plug 'edkolev/tmuxline.vim'

"" The fastest Neovim colorizer
"Plug 'norcalli/nvim-colorizer.lua'

"" Nvim Treesitter configurations and abstraction layer
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'

"" Integrates Arduino's IDE's command line interface
"Plug 'stevearc/vim-arduino'

"" Grab some text and send it to a GNU Screen/tmux/NeoVim Terminal/Vim Terminal
"Plug 'jpalardy/vim-slime'

"" Smooth scrolling for Vim done right
"Plug 'psliwka/vim-smoothie'

"" A fuzzy finder
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" lf.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:lf_map_keys = 0
"let g:lf_replace_netrw = 1
"nnoremap <silent><Leader>lf :Lf<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" lightline.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:lightline = {
"      \ 'colorscheme': 'marlin',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
"      \   'right': [ [ 'lineinfo' ], ]
"      \ },
"      \ 'mode_map': {
"        \ 'n' : 'N',
"        \ 'i' : 'I',
"        \ 'R' : 'R',
"        \ 'v' : 'V',
"        \ 'V' : 'VL',
"        \ "\<C-v>": 'VB',
"        \ 'c' : 'C',
"        \ 's' : 'S',
"        \ 'S' : 'SL',
"        \ "\<C-s>": 'SB',
"        \ 't': 'T',
"        \ },
"      \ 'separator': { 'left': '', 'right': '' },
"      \ 'subseparator': { 'left': '', 'right': '' }
"      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Compile files into a 'build' dir
"let g:vimtex_compiler_latexmk = {
"      \ 'build_dir' : 'build',
"      \}
"" Set file type
"let g:tex_flavor = 'latex'
"" Configure qpdfview
"let g:vimtex_view_general_viewer = 'qpdfview'
"let g:vimtex_view_general_options
"  \ = '--unique @pdf\#src:@tex:@line:@col'
"let g:vimtex_view_general_options_latexmk = '--unique'
"" Disable custom warnings based on regexp
"let g:vimtex_quickfix_ignore_filters = [
"      \ 'Underfull .*',
"      \]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" vim-rooter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:rooter_manual_only = 1
"nnoremap <Leader>cdr :Rooter<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" vim-easy-align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap ga <Plug>(EasyAlign)
"xmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" tmuxline.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:tmuxline_preset = {
"\   'a'  : '#S',
"\   'win'  : ['#I #W'],
"\   'cwin' : ['#I #W'],
"\   'z'  : '%R',
"\   'options': {
"\     'status-justify': 'left',
"\     'status-position': 'top',}
"\   }
"if $SSH_CONNECTION
"  autocmd VimEnter,ColorScheme * silent! Tmuxline lightline_insert
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" nvim-colorizer.lua
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"lua require'colorizer'.setup()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" vim-easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""nmap ga <Plug>(EasyAlign)
""xmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" tmuxline.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""let g:tmuxline_preset = {
""\   'a'  : '#S',
""\   'win'  : ['#I #W'],
""\   'cwin' : ['#I #W'],
""\   'z'  : '%R',
""\   'options': {
""\     'status-justify': 'left',
""\     'status-position': 'top',}
""\   }
""if $SSH_CONNECTION
""  autocmd VimEnter,ColorScheme * silent! Tmuxline lightline_insert
""endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" nvim-colorizer.lua
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""lua require'colorizer'.setup()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" nvim-treesitter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""nnoremap <Leader>th :TSHighlightCapturesUnderCursor<CR>
""" Use :TSModuleInfo to see the modules supported by each language
""lua <<EOF
""require'nvim-treesitter.configs'.setup {
""  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
""  highlight = {
""    enable = true,              -- false will disable the whole extension
""    disable = { "bash" },       -- list of language that will be disabled
""  },
""}
""EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" playground
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""nnoremap <Leader>tp :TSPlaygroundToggle<CR>
""lua <<EOF
""require "nvim-treesitter.configs".setup {
""  playground = {
""    enable = true,
""    disable = {},
""    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
""    persist_queries = false -- Whether the query persists across vim sessions
""  }
""}
""EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""" vim-smoothie
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""let g:smoothie_update_interval = 20 
""let g:smoothie_base_speed = 25

" vim:set foldenable foldmethod=marker:
