"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim philosopy: https://stackoverflow.com/a/1220118/1706778
" See: `:h nvim-configuration`
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" A command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Automatically clears search highlight when cursor is moved
Plug 'junegunn/vim-slash'

" Shows the contents of " and @ registers in a sidebar
Plug 'junegunn/vim-peekaboo'

" A simple, easy-to-use Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" Defines a new text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'
" Plug 'kana/vim-textobj-indent'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" See https://github.com/vim-airline/vim-airline/wiki/Screenshots
Plug 'vim-airline/vim-airline-themes'

" Provides support for writing LaTeX documents
Plug 'lervag/vimtex'

" Navigate seamlessly between vim and tmux splits using a set of hotkeys
Plug 'toranb/tmux-navigator'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Comment functions so powerful—no comment necessary
Plug 'scrooloose/nerdcommenter'

" Takes the <no.> out of <no.>w or <number>f{char} by highlighting all choices
Plug 'easymotion/vim-easymotion'

" Shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'

" Enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'conradirwin/vim-bracketed-paste'

" Vim plugin that allows use of vifm as a file picker
Plug 'vifm/vifm.vim'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Change the cursor shape based on the current mode
Plug 'wincent/terminus'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Simple tmux statusline generator with support for airline statusline integration
Plug 'edkolev/tmuxline.vim'

" A very fast, multi-syntax context-sensitive color name highlighter
Plug 'ap/vim-css-color'

" The undo history visualizer for VIM
Plug 'mbbill/undotree'

" Provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" Vim support for Julia.
Plug 'JuliaEditorSupport/julia-vim'

" Grab some text and send it to a GNU Screen/tmux/NeoVim Terminal/Vim Terminal
Plug 'jpalardy/vim-slime'

" Cell support for Julia in Vim
Plug 'mroavi/vim-julia-cell', { 'for': ['julia'] }

" Plugin to help you stop repeating the basic movement keys
Plug 'takac/vim-hardtime'

" Vim plugin that shows keybindings in popup (On-demand lazy load)
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Seamlessly run Python code from Vim in IPython
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Color schemes
Plug 'chriskempson/base16-vim'

" Syntax highlighting for GNU Octave
Plug 'jvirtanen/vim-octave'

" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'raimondi/delimitmate'

" Nvim LSP client configurations
Plug 'neovim/nvim-lsp'

" Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" LSP Completion source for deoplete
Plug 'Shougo/deoplete-lsp'

" Highlight group manipulation for Vim
Plug 'wincent/pinnacle'

" UltiSnips is the ultimate solution for snippets in Vim (tracks the engine)
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Highlight, navigate, and operate on sets of matching text
Plug 'andymass/vim-matchup'

" Provides a start screen for Vim and Neovim
Plug 'mhinz/vim-startify'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux
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
" https://neovim.io/doc/user/options.html#'shada'
set shada=%,<800,'50,/50,:100,h,f1
"         |   |   |   |    |  |  + store file marks 0-9,A-Z
"         |   |   |   |    |  + disable 'hlsearch' while loading viminfo
"         |   |   |   |    + maximum number of items in the command-line history to be saved
"         |   |   |   + maximum number of items in the search pattern history to be saved
"         |   |   + files marks saved for the last XX files edited
"         |   + maximum num of lines saved for each register (old name for <, vi6.2)
"         + save/restore buffer list

set number " show line numbers
set relativenumber " lines are numbered relative to the line the cursor is on
set noswapfile " they're just annoying. Who likes them?
set wrap linebreak nolist " avoid breaking lines in the middle of words
set noshowcmd " don't show partial typed commands in the right side of the status bar
set noshowmode " don't show mode in status bar (taken care of by airline)
set cmdheight=1 " limit the cmd line height to one line
set hidden " allows switching from unwritten buffers and remembers the buffer undo history
set formatoptions-=tc " disable auto-wrap text using textwidth
set grepprg=rg\ --vimgrep " program to used for the :grep command.
set grepformat=%f:%l:%c:%m " format to recognize for the :grep command output
set splitbelow splitright " open a new split at to bottom or to the right of the current one
set signcolumn=yes " always show sign column
set noshowmatch " no live match highlighting (brief jumping)
set tabstop=2 " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " number of spaces that a <Tab> counts for while performing editing operations
set shiftwidth=2 " number of spaces for indents in normal mode
set expandtab " use spaces instead of tabs.
set shiftround " tab / shifting moves to closest tabstop.
set smartindent " intelligently dedent / indent new lines based on rules.
set updatetime=100 " among others, governs gitgutter's update time
"set colorcolumn=80 " highlight column
"set cursorline " highlight the line that the cursor is currently on
"set clipboard^=unnamed,unnamedplus " sync the unnamed reg with the system and selection clipboards

" Disable automatic comment insertion (https://superuser.com/a/271024/1087113)
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

if !$SSH_CONNECTION
  set listchars=tab:▸\ ,space:_,eol:¬ " Define symbols for tabstops, spaces and EOLs
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace default prefix Ctrl+w with Ctrl+a
nnoremap <C-a> <C-w>

" Resize splits easier
noremap <M-S-j> :resize -3<CR>
noremap <M-S-k> :resize +3<CR>
noremap <M-S-h> :vertical resize +3<CR>
noremap <M-S-l> :vertical resize -3<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Open help in vertical split
cnoreabbrev H vert bo h

" Maximize current window height
nnoremap <Leader>- <C-w>_

" Make all windows equally high and wide
nnoremap <Leader>= <C-w>=

" Substitute all ocurrances of the content of the search register with new text
nnoremap <Leader>sa :%s///g<left><left>

" Switch to next/previous buffer
nnoremap <Leader>, :bprevious<CR>
nnoremap <Leader>. :bnext<CR>

" Switch to last visited buffer
nnoremap <Leader>t :b#<CR>

" Delete current buffer
nnoremap <Leader>bd :bdelete<CR>

" Close all buffers but the current one
map <Leader>bo :%bdelete\|e#<CR>

" Write to disk
nnoremap <Leader>w :write<CR>

" Quit
nnoremap <Leader>q :quit<CR>

" Yank to clipboard
vmap <Leader>y "+y

" Source .vimrc
map <Leader>sv :w<CR>:source $MYVIMRC<CR>

" Write and source the currently opened file
map <Leader>ss :w<CR>:source %<CR>

" Toggle display of invisible chars (http://vimcasts.org/episodes/show-invisibles/`)
nmap <F3> :set list!<CR>

" Use F5 to toggle the spelling check!
map <F5> :setlocal spell! spelllang=en_us<CR>

" Chorme-like tab commands (conflicts with tmux)
" based on: https://stackoverflow.com/a/31961401/1706778

" Close tab with Ctrl+w
nnoremap <C-w> :tabclose<CR>

" Ctrl+t -> new tab
nnoremap <C-t> :tabnew<CR>

" Ctl+tab -> next tab
nnoremap <C-Tab> gt

" Ctrl+Shift + tab -> previous tab
nnoremap <C-S-Tab> gT

" Ctrl+Shift+w -> close
set <F15>=[27;6;48~ | nnoremap <F15> :close<CR>

" Strip trailing whitespace from all lines in a file
" https://vi.stackexchange.com/a/456/27039
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
noremap <Leader>rw :call TrimWhitespace()<CR>

" Convert all tabs to 2 space tabs
" https://stackoverflow.com/a/16892086/1706778
fun!  ReTab()
  set tabstop=4 softtabstop=4 noexpandtab
  retab!
  set tabstop=2 softtabstop=2 expandtab
  retab!
endfun
nnoremap <Leader>rt :call ReTab()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" base16
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source ~/.vimrc_background generated by base16 shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Customization (https://bit.ly/2WZ8n3J)
function! s:base16_customize() abort
  call Base16hi("MatchParen", "", g:base16_gui00, "", g:base16_cterm00, "italic", "")
  call Base16hi("SignColumn", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("LineNr", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("CursorLineNR", "", g:base16_gui00, "", g:base16_cterm00, "none", "")
  call Base16hi("GitGutterAdd", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("GitGutterChange", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("GitGutterDelte", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("GitGutterChangeDelete", "", g:base16_gui00, "", g:base16_cterm00, "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

call s:base16_customize()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile files into a 'build' dir
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do not create default mappings
let g:NERDCreateDefaultMappings = 0

" Make NerdCommentToggle comment all selected lines if there is at least one that is not connected
let g:NERDToggleCheckAllLines = 1

" Delete leftover whitespace when uncommenting empty lines
let g:NERDTrimTrailingWhitespace = 1

let g:NERDDefaultAlign = 'start'

" Remap Ctrl+/ to NERDCommentToggle in normal and visual modes!
" https://stackoverflow.com/questions/9051837/how-to-map-c-to-toggle-comments-in-vim
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Jump anywhere with s
nmap s <Plug>(easymotion-s)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_map_keys = 0
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <Leader>j <Plug>(GitGutterNextHunk)
nmap <Leader>k <Plug>(GitGutterPrevHunk)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default fzf layout
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top' } }

" This are the default extra key bindings
let g:fzf_action = {
\   'ctrl-t': 'tab split',
\   'ctrl-x': 'split',
\   'ctrl-v': 'vsplit' }

" Do not show preview window by default
let g:fzf_preview_window = ''

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':       ['fg', 'Normal'],
\   'bg':       ['bg', 'Normal'],
\   'hl':       ['fg', 'Comment'],
\   'fg+':      ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\   'bg+':      ['bg', 'CursorLine', 'CursorColumn'],
\   'hl+':      ['fg', 'Statement'],
\   'info':     ['fg', 'PreProc'],
\   'border':   ['fg', 'Ignore'],
\   'prompt':   ['fg', 'Conditional'],
\   'pointer':  ['fg', 'Exception'],
\   'marker':   ['fg', 'Keyword'],
\   'spinner':  ['fg', 'Label'],
\   'header':   ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Shift-Tab to select multiple results (-m flag required)
" :Files runs $FZF_DEFAULT_COMMAND defined in .zshrc
nnoremap <Leader>fi :Files<CR>
nnoremap <Leader>gf :GFiles<CR>
nnoremap <Leader>ls :Buffers<CR>
nnoremap <Leader>rg :MyRg<CR>
nnoremap <Leader>li :Lines<CR>
nnoremap <Leader>bl :BLines<CR>
nnoremap <Leader>hi :History<CR>
nnoremap <Leader>ch :History:<CR>
nnoremap <Leader>co :Commits<CR>
nnoremap <Leader>bc :BCommits<CR>
nnoremap <Leader>cm :Commands<CR>
nnoremap <Leader>ma :Maps<CR>
nnoremap <Leader>cs :Colors<CR>

" Advanced ripgrep integration
" See https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --no-ignore --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command,
  \           '--preview-window', 'up:60%', '--no-height'],
  \           'window': { 'width': 1, 'height': 1.0, 'yoffset': 1, 'border': 'top' } }
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -bang -nargs=* MyRg call RipgrepFzf(<q-args>, <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vifm.vim
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
" vim-highlightedyank
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 200

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>u :UndotreeShow<CR>
let g:undotree_SetFocusWhenToggle = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-slime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
autocmd FileType julia,python let g:slime_cell_delimiter = "##"

" Execute current cell
autocmd FileType octave nmap <buffer> <M-CR> <Plug>SlimeSendCell

" Map to Ctrl-Return
autocmd FileType julia,python,octave xmap <buffer> <C-CR> <Plug>SlimeRegionSend
autocmd FileType julia,python,octave nmap <buffer> <C-CR> <Plug>SlimeLineSend

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add commands similar to those available through the Git plugin in Oh My ZSH
command! -complete=file -nargs=* Gd Git diff <args>
command! -complete=file -nargs=* Gds Git diff --staged <args>

nnoremap <Leader>gst :Git<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gdi :Gd<CR>
nnoremap <Leader>gds :Gds<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rooter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_silent_chdir = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easy-align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-hardtime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-which-key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tmuxline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmuxline_preset = {
\   'a'  : '#S',
\   'win'  : ['#I #W'],
\   'cwin' : ['#I #W'],
\   'z'  : '%R',
\   'options': {
\     'status-justify': 'left',
\     'status-position': 'top',}
\   }

if $SSH_CONNECTION
  autocmd VimEnter,ColorScheme * silent! Tmuxline airline_insert
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-lsp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/wincent/wincent/blob/master/aspects/vim/files/.vim/after/plugin/nvim-lsp.vim
lua require'nvim_lsp'.clangd.setup{}
"lua require'nvim_lsp'.julials.setup{} " TODO: causes HIGH cpu load
" TODO: install Python server: rope is one option

" mappings (See `:h lsp-buf`)
nnoremap <buffer> <Leader>gd  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer> <Leader>gt  <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <buffer> <F2>        <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>gr  <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>fo  <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <buffer> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <buffer> <Leader>di  <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>

" Auto-format *.cpp files prior to saving them
autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting_sync(nil, 1000)

" signs
sign define LspDiagnosticsErrorSign text=✖
sign define LspDiagnosticsWarningSign text=⚠
sign define LspDiagnosticsInformationSign text=ℹ
sign define LspDiagnosticsHintSign text=➤

" colors
execute 'highlight LspDiagnosticsError ' . pinnacle#decorate('italic,underline', 'ErrorMsg')
execute 'highlight LspDiagnosticsInformation ' . pinnacle#decorate('italic,underline', 'Type')
execute 'highlight LspDiagnosticsHint ' . pinnacle#decorate('bold,italic,underline', 'Type')
execute 'highlight LspDiagnosticsHintSign ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('Type')
\ })
execute 'highlight LspDiagnosticsErrorSign ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('ErrorMsg')
\ })

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

" Tab completion (https://github.com/Shougo/deoplete.nvim/issues/989)
inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsListSnippets="<C-Tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-peekaboo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CreateCenteredFloatingWindow()
  let width = float2nr(&columns * 0.6)
  let height = float2nr(&lines * 0.6)
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:peekaboo_window="call CreateCenteredFloatingWindow()"
