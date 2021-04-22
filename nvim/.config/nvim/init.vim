""" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vi(m) philosophy: https://stackoverflow.com/a/1220118/1706778
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

"""""""""""""""""""""""" plugins with no configuration """"""""""""""""""""""""

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Vim support for Julia
Plug 'JuliaEditorSupport/julia-vim'

" Snippets are separated from the engine. Add this if you want them
Plug 'honza/vim-snippets'

" Auto format pasted code
Plug 'sickill/vim-pasta'

" TEMP: temporary fix for the gitgutter + deoplete-lsp problem
Plug 'antoinemadec/FixCursorHold.nvim'

" Easily write your .vimrc in lua or any lua based language
Plug 'svermeulen/vimpeccable'

" {{{1

"" Syntax highlighting for GNU Octave
"Plug 'jvirtanen/vim-octave', { 'for': 'octave' }

"" A fancy start screen for Vim/Neovim
"Plug 'mhinz/vim-startify'

"" Smooth scrolling for Vim done right
"Plug 'psliwka/vim-smoothie'

"" A Neovim plugin that displays (non-interactive) scrollbars.
"Plug 'dstein64/nvim-scrollview'

"" Cell support for Julia in Vim
"Plug 'mroavi/vim-julia-cell', { 'for': ['julia'] }

""" Easily interact with tmux from vim.
"Plug 'benmills/vimux'

"" A powerful grammar checker for Vim using LanguageTool
"Plug 'rhysd/vim-grammarous'

" }}}

"""""""""""""""""""""""""" plugins with configuration """"""""""""""""""""""""""

" Automatically clears search highlight when cursor is moved
Plug 'junegunn/vim-slash'

" Shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'

" Navigate seamlessly between vim and tmux splits using a set of hotkeys
Plug 'toranb/tmux-navigator'

" Send text to tmux
Plug '~/repos/vim-tomux'
"Plug 'mroavi/vim-tomux'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Vim plugin that shows keybindings in popup (On-demand lazy load)
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" An async completion framework for neovim's built in LSP written in Lua
Plug 'nvim-lua/completion-nvim'

" UltiSnips is the ultimate solution for snippets in Vim (tracks the engine)
Plug 'SirVer/ultisnips'

" Syntax highlighting, matching rules and mappings for Markdown and extensions
Plug 'plasticboy/vim-markdown'

" Preview markdown on your browser with synchronised scrolling
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'raimondi/delimitmate'

" Color scheme
Plug '~/repos/marlin.vim/'

" A well-integrated, low-configuration buffer list that lives in the tabline
Plug 'ap/vim-buftabline'

" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'

" Find, Filter, Preview, Pick. All lua, all the time
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Most Recently Used (MRU) Vim Plugin
Plug 'yegappan/mru'

" File manager for vim/neovim powered by nnn
"Plug 'mroavi/lf.vim'
Plug '~/repos/lf.vim'

" {{{1

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

" }}}

call plug#end()

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
set completeopt=menuone,noinsert,noselect " better completion experience
set shortmess+=c " avoid showing verbose messages when using completion
"set noshowmode " don't show mode in status bar (taken care of by lightline)
"set ignorecase smartcase " ignore case if the typed letters are all lowercase

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

" Delete current buffer without losing split windows
" https://stackoverflow.com/a/4468491/1706778
nnoremap <silent> <Leader>bd :b#<bar>:bdelete #<CR>

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

" Spelling completion in normal mode
inoremap <expr> <CR> pumvisible() ? "\<C-y><Esc>" : "\<CR>"
nnoremap <C-s> :call search('\w\>', 'c')<CR>a<C-X><C-S>

" Avoid a double slash when pressing / when using wildmenu (similar to zsh)
cnoremap <expr> / wildmenumode() ? "\<C-y>" : "/"

" Open terminal
nnoremap <Leader>> :terminal<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" marlin.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
colorscheme marlin

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-slash
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Blink cursor after go to next/prev search
noremap <expr> <plug>(slash-after) slash#blink(1, 150)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_map_keys = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <M-]> <Plug>(GitGutterNextHunk)
nmap <M-[> <Plug>(GitGutterPrevHunk)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" tmux-navigator
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
inoremap <silent> <C-h> <C-o>:TmuxNavigateLeft<CR>
inoremap <silent> <C-j> <C-o>:TmuxNavigateDown<CR>
inoremap <silent> <C-k> <C-o>:TmuxNavigateUp<CR>
inoremap <silent> <C-l> <C-o>:TmuxNavigateRight<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-tomux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tomux_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:tomux_paste_file = expand("$HOME/.tomux_paste")
nnoremap <silent> yot :TomuxUseClipboardToggle<CR>

augroup tomux_send
  autocmd!
  "autocmd FileType julia,python,octave nmap <buffer> s <Plug>TomuxMotionSend
  autocmd FileType julia,python,octave nmap <silent> s :set opfunc=MySendMotion<CR>g@
  autocmd FileType julia,python,octave xmap <buffer> s <Plug>TomuxVisualSend
  autocmd FileType julia,python,octave omap <buffer> s _

  " Ctrl+Enter to send text in visual, normal and insert modes
  autocmd FileType julia,python,octave xmap <buffer> <C-CR> <Plug>TomuxVisualSend
  autocmd FileType julia,python,octave nmap <buffer> <C-CR> s_
  autocmd FileType julia,python,octave imap <buffer> <C-CR> <Esc>s_gi

  " Shift+Enter to send line and jump to next statement
  autocmd FileType julia,python,octave nmap <silent> <S-CR> :set opfunc=MySendMotion<CR>g@_

  " Alt+Enter to send cell 
  autocmd FileType julia,python,octave nmap <buffer> <M-CR> sic

  " Ctrl+Shift+Enter to run entire buffer
  autocmd FileType julia,python,octave nmap <buffer> <C-S-CR> sid
augroup END

" My custom operator: sends a motion to the REPL and moves to the next
" statement (skips comments and empty lines) (see :h map-operator)
" See: https://vi.stackexchange.com/questions/5495/mapping-with-motion
function! MySendMotion(type, ...)
  " Select lines involved in the motion
  silent exe "normal! `[V`]"
  " Send the selected region
  silent exe "normal \<Plug>TomuxVisualSend"
  " Go to the last char of the selection
  silent exe "normal! `>"
  " Get the first character of the 'commentstring'
  let l:commentchar = split(&commentstring, '%s')[0][0]
  " Jump to next statement (skips empty lines or lines that start with comment char)
  let l:pattern =  '^\(\s*' . l:commentchar . '\)\@!\s*\S\+'
  call search(l:pattern, "W")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add commands similar to those available through the Git plugin in Oh My ZSH
command! -complete=file -nargs=* Gdiff Git diff <args>
command! -complete=file -nargs=* Gdstaged Git diff --staged <args>
nnoremap <Leader>gst :Ge:<CR>
nnoremap <Leader>gw  :Gwrite<CR>
nnoremap <Leader>gc  :Git commit -v<CR>
nnoremap <Leader>gp  :Git push<CR>
nnoremap <Leader>gl  :Git pull<CR>
nnoremap <Leader>glg :Git log<CR>
" The LHS of the mappings below are being used elsewhere
"nnoremap <Leader>gr  :Gread<CR>
"nnoremap <Leader>gdi :Gdiff<CR>
"nnoremap <Leader>gds :Gdstaged<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:commentary_startofline = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-which-key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :<c-u>WhichKeyVisual '<Space>'<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" nvim-lspconfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('mrv.lsp')
lua require('mrv.lsp.mappings')

" Signs
sign define LspDiagnosticsSignHint        text=➤
sign define LspDiagnosticsSignError       text=✖
sign define LspDiagnosticsSignWarning     text=⚠
sign define LspDiagnosticsSignInformation text=ℹ

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" completion-nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through pop-up menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Toggle auto popup on the fly
nnoremap <Leader>ct :CompletionToggle<CR>

let g:completion_enable_auto_popup      = 1
let g:completion_enable_snippet         = 'UltiSnips'
let g:completion_trigger_keyword_length = 2
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case   = 1
let g:completion_enable_auto_hover      = 0
let g:completion_enable_auto_signature  = 1
let g:completion_timer_cycle            = 100

" Fixes delimitmate's 'delimitMate_expand_cr' option
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
      \ "\<Plug>(completion_confirm_completion)" : "\<c-e>\<CR>" : "\<Plug>delimitMateCR"

" Manually trigger completion with
inoremap <silent><expr> <C-Space> completion#trigger_completion()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" Assign dummy keys (expand trigger and list snippets are taken care of by completion-nvim)
let g:UltiSnipsExpandTrigger       = "<\>"
let g:UltiSnipsListSnippets        = "<\>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" delimitmate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-buftabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:buftabline_numbers = 2
nmap <Leader>1 <Plug>BufTabLine.Go(1)
nmap <Leader>2 <Plug>BufTabLine.Go(2)
nmap <Leader>3 <Plug>BufTabLine.Go(3)
nmap <Leader>4 <Plug>BufTabLine.Go(4)
nmap <Leader>5 <Plug>BufTabLine.Go(5)
nmap <Leader>6 <Plug>BufTabLine.Go(6)
nmap <Leader>7 <Plug>BufTabLine.Go(7)
nmap <Leader>8 <Plug>BufTabLine.Go(8)
nmap <Leader>9 <Plug>BufTabLine.Go(9)
nmap <Leader>0 <Plug>BufTabLine.Go(10)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" targets.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap 'i' with 'I' operator modes
let g:targets_aiAI = ['a', 'I', 'A', 'i']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" telescope.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('mrv.telescope')
lua require('mrv.telescope.mappings')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" mru
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:MRU_File = '$HOME/.vim_mru_files'
let g:MRU_Max_Entries = 500
let g:MRU_Exclude_Files = '\.git'
nnoremap <silent><Leader>mr :MRU<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" lf.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lf#set_default_mappings = 0
nnoremap <Leader>/ :LfPicker %:p:h<CR>
let g:lf#replace_netrw = 1
let g:lf#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Normal' } }
let g:lf#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

" {{{1

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" nvim-treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <Leader>th :TSHighlightCapturesUnderCursor<CR>
"" Use :TSModuleInfo to see the modules supported by each language
"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"  highlight = {
"    enable = true,              -- false will disable the whole extension
"    disable = { "bash" },       -- list of language that will be disabled
"  },
"}
"EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" playground
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <Leader>tp :TSPlaygroundToggle<CR>
"lua <<EOF
"require "nvim-treesitter.configs".setup {
"  playground = {
"    enable = true,
"    disable = {},
"    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
"    persist_queries = false -- Whether the query persists across vim sessions
"  }
"}
"EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" vim-smoothie
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:smoothie_update_interval = 20 
"let g:smoothie_base_speed = 25

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" fzf.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Default fzf layout
""(see: https://github.com/junegunn/fzf.vim/issues/821#issuecomment-581481211)
""(see: https://github.com/junegunn/fzf.vim/issues/1033)
""let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top' } }
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'border': 'sharp' } }

"" Do not show preview window by default
"let g:fzf_preview_window = ''

"" Customize fzf colors to match your color scheme
"let g:fzf_colors =
"\ { 'fg':       ['fg', 'Normal'],
"\   'bg':       ['bg', 'Normal'],
"\   'hl':       ['fg', 'Comment'],
"\   'fg+':      ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"\   'bg+':      ['bg', 'CursorLine', 'CursorColumn'],
"\   'hl+':      ['fg', 'Statement'],
"\   'info':     ['fg', 'PreProc'],
"\   'border':   ['fg', 'Normal'],
"\   'prompt':   ['fg', 'Conditional'],
"\   'pointer':  ['fg', 'Exception'],
"\   'marker':   ['fg', 'Keyword'],
"\   'spinner':  ['fg', 'Label'],
"\   'header':   ['fg', 'Comment'],
"\   'gutter':   ['bg', 'Normal'] }

"" Enable per-command history
"let g:fzf_history_dir = '~/.local/share/fzf-history'

"" Shift-Tab to select multiple results (-m flag required)
"" :Files runs $FZF_DEFAULT_COMMAND defined in .zshrc
"" All commands: https://github.com/junegunn/fzf.vim#commands
"nnoremap <Leader>fi :Files<CR>
"nnoremap <Leader>fh :History<CR>
"nnoremap <Leader>fg :GFiles<CR>
"nnoremap <Leader>rg :MyRg<CR>
"nnoremap <Leader>ls :Buffers<CR>
"nnoremap <Leader>z  :MyFasd<CR>
"nnoremap <Leader>ch :History:<CR>

"" Advanced ripgrep integration (https://bit.ly/2NUtoXO)
"function! RipgrepFzf(query, fullscreen)
"  let command_fmt = 'rg --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case %s || true'
"  let initial_command = printf(command_fmt, shellescape(a:query))
"  let reload_command = printf(command_fmt, '{q}')
"  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command,
"  \           '--preview-window', 'up:60%', '--no-height'],
"  \           'window': { 'width': 1, 'height': 1.0, 'yoffset': 1, 'border': 'top' } }
"  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
"endfunction
"command! -bang -nargs=* MyRg call RipgrepFzf(<q-args>, <bang>0)

"" Fasd integration
"function! Fasd(fullscreen)
"  let cmd = "fasd -dl | grep -iv cache"
"  call fzf#run(fzf#wrap('j', {'source': cmd, 'sink': 'cd'}))
"endfunction
"command! -nargs=0 MyFasd call Fasd(<bang>0)

" }}}

" vim:set foldenable foldmethod=marker:
