"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim philosophy: https://stackoverflow.com/a/1220118/1706778
" See: `:h nvim-configuration`
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

"""""""""""""""""""""""" plugins with no configuration """"""""""""""""""""""""

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" Defines a new text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'

" See https://github.com/vim-airline/vim-airline/wiki/Screenshots
Plug 'vim-airline/vim-airline-themes'

" A very fast, multi-syntax context-sensitive color name highlighter
Plug 'ap/vim-css-color'

" Seamlessly run Python code from Vim in IPython
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Cell support for Julia in Vim
Plug 'mroavi/vim-julia-cell', { 'for': ['julia'] }

" Syntax highlighting for GNU Octave
Plug 'jvirtanen/vim-octave', { 'for': 'octave' }

" Highlight group manipulation for Vim
Plug 'wincent/pinnacle'

" Snippets are separated from the engine. Add this if you want them
Plug 'honza/vim-snippets'

" A fancy start screen for Vim/Neovim
Plug 'mhinz/vim-startify'

" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'

" A solid language pack for Vim
Plug 'sheerun/vim-polyglot'

" Auto format pasted code
Plug 'sickill/vim-pasta'

" lua `fork` of vim-web-devicons for neovim
Plug 'kyazdani42/nvim-web-devicons'

" A Neovim plugin that displays (non-interactive) scrollbars.
Plug 'dstein64/nvim-scrollview'

" TEMP: temporary fix for the gitgutter + deoplete-lsp problem
Plug 'antoinemadec/FixCursorHold.nvim'

"""""""""""""""""""""""""" plugins with configuration """"""""""""""""""""""""""

" Color schemes
Plug 'chriskempson/base16-vim'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" Automatically clears search highlight when cursor is moved
Plug 'junegunn/vim-slash'

" Provides support for writing LaTeX documents
Plug 'lervag/vimtex'

" Shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'

" A fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Navigate seamlessly between vim and tmux splits using a set of hotkeys
Plug 'toranb/tmux-navigator'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Grab some text and send it to a GNU Screen/tmux/NeoVim Terminal/Vim Terminal
Plug 'jpalardy/vim-slime'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" A simple, easy-to-use Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" TEMP: Plugin to help you stop repeating the basic movement keys
Plug 'takac/vim-hardtime'

" Vim plugin that shows keybindings in popup (On-demand lazy load)
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Simple tmux statusline generator, integrates with airline statusline
Plug 'edkolev/tmuxline.vim'

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

" Fast and featureful file manager in vim/neovim powered by nnn
Plug 'mcchrish/nnn.vim'

" Highlight, navigate, and operate on sets of matching text
Plug 'andymass/vim-matchup'

" Integrates Arduino's IDE's command line interface
Plug 'stevearc/vim-arduino'

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'

" Hyperfocus-writing in Vim
Plug 'junegunn/limelight.vim'

" Find, Filter, Preview, Pick. All lua, all the time
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'raimondi/delimitmate'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://neovim.io/doc/user/options.html#'shada'
set shada=%,<800,'500,/100,:500,h,f1
"         | |    |    |    |    | + store file marks 0-9,A-Z
"         | |    |    |    |    + disable 'hlsearch' while loading viminfo
"         | |    |    |    + max num of items in the cmd-line hist to be saved
"         | |    |    + max num of items in the search history to be saved
"         | |    + number of old files remembered
"         | + maximum num of lines saved for each register
"         + save/restore buffer list
set number relativenumber " lines are numbered relative to the current line
set noswapfile " they're just annoying. Who likes them?
set wrap linebreak nolist " avoid breaking lines in the middle of words
set noshowmode " don't show mode in status bar (taken care of by airline)
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
set scrolloff=10 " min num of screen lines to keep above and below the cursor

" Disable automatic comment insertion (https://superuser.com/a/271024/1087113)
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Scroll by a third of window height (https://stackoverflow.com/a/16574696/1706778)
execute "set scroll=" .&lines / 3
au VimResized * execute "set scroll=" . &lines / 3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Custom mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make Y behave like other capitals
nnoremap Y y$

" Write to disk
nnoremap <Leader>w :write<CR>

" Yank to clipboard
vnoremap <Leader>y "+y

" Paste from clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Toggle last visited buffer
nnoremap <silent> <Leader>; :b#<CR>

" Delete current buffer
nnoremap <silent><Leader>bd :bdelete<CR>

" Unload buffer and switch to last visited buffer (opposite of <Leader>i)
nnoremap <silent> <Leader>o :bdelete<CR>

" Close all buffers but the current one
map <Leader>bo :%bdelete\|e#<CR>

" Resize splits easier
noremap <M-S-j> :resize -3<CR>
noremap <M-S-k> :resize +3<CR>
noremap <M-S-h> :vertical resize +3<CR>
noremap <M-S-l> :vertical resize -3<CR>

" Substitute all occurrences of the content of the search register with new text
nnoremap <Leader>sa :%s///g<left><left>

" Select pasted text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

" Source .vimrc
map <Leader>sv :w<CR>:source $MYVIMRC<CR>

" Write and source the currently opened file
map <Leader>ss :w<CR>:source %<CR>

" Change to the directory of the current buffer and print it
nnoremap <Leader>cdb :cd %:p:h<CR> :pwd<CR>

" Open help in vertical split
cnoreabbrev H vert bo h

" Move selected lines up/down reindenting if necessary
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clear highlight on pressing ESC
nnoremap <silent> <ESC> :noh<CR><ESC>

" Chrome-like tab mappings
nnoremap <C-t>     :tabnew<CR>
" Ctrl+Shift+w -> close (hack: see alacritty.yml and .tmux.conf)
nnoremap <C-S-0>   :close<CR>

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

"" Highlight the yanked text (conflicts with matchup - keeping vim-highlightedyank instead)
"augroup LuaHighlight
"  autocmd!
"  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 200)
"augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" base16-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
  call Base16hi("GitGutterDelete", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("GitGutterChangeDelete", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("Comment", g:base16_gui04, "", g:base16_cterm04,"" , "", "")
  call Base16hi("SpellBad", g:base16_gui00, g:base16_gui08, g:base16_cterm00, g:base16_cterm08, "", "")
  call Base16hi("SpellLocal", g:base16_gui00, "", g:base16_cterm00, "", "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

call s:base16_customize()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_detect_spell = 0
let g:airline_skip_empty_sections = 1
let g:airline_section_x = ''
let g:airline_section_y = '%v'
let g:airline_section_z = ''
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-slash
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Blink cursor after search
noremap <expr> <plug>(slash-after) slash#blink(1, 150)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile files into a 'build' dir
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \}

let g:tex_flavor = 'latex'

" Configure qpdfview
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
  \ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'

" Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull .*',
      \]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_map_keys = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <Leader>j  <Plug>(GitGutterNextHunk)
nmap <Leader>k  <Plug>(GitGutterPrevHunk)
nmap ]h         <Plug>(GitGutterNextHunk)
nmap [h         <Plug>(GitGutterPrevHunk)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" fzf.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default fzf layout
"(see: https://github.com/junegunn/fzf.vim/issues/821#issuecomment-581481211)
"let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top' } }
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border': 'sharp' } }

" This are the default extra key bindings
let g:fzf_action = {
\   'ctrl-t': 'tab split',
\   'ctrl-x': 'split',
\   'ctrl-v': 'vsplit' }

" Do not show preview window by default
let g:fzf_preview_window = ''

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':       ['fg', 'Normal'],
\   'bg':       ['bg', 'Normal'],
\   'hl':       ['fg', 'Comment'],
\   'fg+':      ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\   'bg+':      ['bg', 'CursorLine', 'CursorColumn'],
\   'hl+':      ['fg', 'Statement'],
\   'info':     ['fg', 'PreProc'],
\   'border':   ['fg', 'Normal'],
\   'prompt':   ['fg', 'Conditional'],
\   'pointer':  ['fg', 'Exception'],
\   'marker':   ['fg', 'Keyword'],
\   'spinner':  ['fg', 'Label'],
\   'header':   ['fg', 'Comment'] }

" Enable per-command history
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Shift-Tab to select multiple results (-m flag required)
" :Files runs $FZF_DEFAULT_COMMAND defined in .zshrc
" All commands: https://github.com/junegunn/fzf.vim#commands
nnoremap <Leader>fi :Files<CR>
"nnoremap <Leader>fh :History<CR>
"nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>rg :MyRg<CR>
"nnoremap <Leader>ls  :Buffers<CR>
nnoremap <Leader>aj :MyAj<CR>
"nnoremap <Leader>ch :History:<CR>

" Advanced ripgrep integration (https://bit.ly/2NUtoXO)
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

" Autojump integration
function! Autojump(fullscreen)
  let cmd = 'autojump -s | sort -k1gr | awk ''$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }'''
  call fzf#run(fzf#wrap('j', {'source': cmd, 'sink': 'cd'}))
endfunction
command! -nargs=0 MyAj call Autojump(<bang>0)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" tmux-navigator
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
"" vim-highlightedyank
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 200

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-slime
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1

autocmd FileType julia,python,octave xmap <buffer> <C-CR> <Plug>SlimeRegionSend
autocmd FileType julia,python,octave nmap <buffer> <C-CR> <Plug>SlimeLineSend
autocmd FileType julia,python,octave imap <buffer> <C-CR> <C-o><Plug>SlimeLineSend
autocmd FileType julia,python,octave nmap <buffer> <S-CR> <Plug>SlimeLineSendj

" Motion-based mappings
autocmd FileType julia,python,octave nmap <buffer> s      <Plug>SlimeMotionSend
autocmd FileType julia,python,octave nmap <buffer> ss     <Plug>SlimeLineSend

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add commands similar to those available through the Git plugin in Oh My ZSH
command! -complete=file -nargs=* Gd Git diff <args>
command! -complete=file -nargs=* Gds Git diff --staged <args>

nnoremap <Leader>gst :Git<CR>
nnoremap <Leader>gw  :Gwrite<CR>
nnoremap <Leader>gr  :Gread<CR>
nnoremap <Leader>gc  :Git commit -v<CR>
nnoremap <Leader>gp  :Git push<CR>
nnoremap <Leader>gl  :Git pull<CR>
nnoremap <Leader>glg :Git log<CR>
nnoremap <Leader>gdi :Gd<CR>
nnoremap <Leader>gds :Gds<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,  <Plug>Commentary
nmap ,, <Plug>CommentaryLine
let b:commentary_startofline = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-rooter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_manual_only = 1
nnoremap <Leader>cdr :Rooter<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-hardtime
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-which-key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
autocmd FileType which_key highlight WhichKeySeperator ctermbg=18 ctermfg=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" tmuxline.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" nvim-lspconfig
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
  local lspconfig = require'lspconfig'
  lspconfig.clangd.setup{
    on_attach=on_attach_vim,
    cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
    filetypes = { "c", "cpp", "objc", "objcpp", "arduino" },
  }
  --lspconfig.julials.setup({on_attach=on_attach_vim})
EOF

" Do not run the following LSPs in SSH connections
if !$SSH_CONNECTION
lua << EOF
  local lspconfig = require'lspconfig'
  lspconfig.vimls.setup({on_attach=on_attach_vim})
  lspconfig.texlab.setup({on_attach=on_attach_vim})
  lspconfig.bashls.setup({on_attach=on_attach_vim})
  lspconfig.cmake.setup({on_attach=on_attach_vim})
  --lspconfig.pyls_ms.setup({on_attach=on_attach_vim})
EOF
endif

" Mappings (See `:h lsp-buf`)
nnoremap          <Leader>i  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap          <Leader>cw <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap                   K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap          <Leader>si <cmd>lua vim.lsp.buf.signature_help()<CR>

" Diagnostics
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)
EOF

" Signs
sign define LspDiagnosticsSignError       text=✖
sign define LspDiagnosticsSignWarning     text=⚠
sign define LspDiagnosticsSignInformation text=ℹ
sign define LspDiagnosticsSignHint        text=➤

" Colors
execute 'highlight LspDiagnosticsVirtualTextError ' . pinnacle#decorate('bold,italic', 'ErrorMsg')
execute 'highlight LspDiagnosticsSignError ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsVirtualTextError')
\ })
execute 'highlight LspDiagnosticsVirtualTextWarning ' . pinnacle#decorate('bold,italic', 'Type')
execute 'highlight LspDiagnosticsSignWarning ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsVirtualTextWarning')
\ })
execute 'highlight LspDiagnosticsVirtualTextInformation ' . pinnacle#decorate('bold,italic', 'Type')
execute 'highlight LspDiagnosticsSignInformation ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsVirtualTextInformation')
\ })
execute 'highlight LspDiagnosticsVirtualTextHint ' . pinnacle#decorate('bold,italic', 'Type')
execute 'highlight LspDiagnosticsSignHint ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsVirtualTextHint')
\ })

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" completion-nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through pop-up menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing verbose messages when using completion
set shortmess+=c

" Toggle auto popup on the fly
nnoremap <Leader>ac :CompletionToggle<CR>

let g:completion_enable_auto_popup      = 1
let g:completion_enable_snippet         = 'UltiSnips'
let g:completion_trigger_keyword_length = 1
let g:completion_matching_ignore_case   = 1
let g:completion_enable_auto_hover      = 0
let g:completion_enable_auto_signature  = 1
let g:completion_auto_change_source     = 1
let g:completion_timer_cycle            = 50
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'mode': 'file'},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

" Fixes delimitmate's 'delimitMate_expand_cr' option
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
      \ "\<Plug>(completion_confirm_completion)" : "\<c-e>\<CR>" : "\<Plug>delimitMateCR"

" Manually trigger completion with
inoremap <silent><expr> <C-Space> completion#trigger_completion()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" Assign dummy keys (expand trigger and list snippets are taken care by completion-nvim)
let g:UltiSnipsExpandTrigger       = "<\>"
let g:UltiSnipsListSnippets        = "<\>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" markdown-preview.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>md :MarkdownPreview<CR>

let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {},
      \ 'flowchart_diagrams': {},
      \ 'content_editable': v:false,
      \ 'disable_filename': 1
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" nnn.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nnn#set_default_mappings = 0
let g:nnn#replace_netrw = 1
nnoremap <silent><Leader>/ :NnnPicker %:p:h<CR>
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Normal' } }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
let g:nnn#command = 'nnn -o -C'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-matchup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable offscreen matches
let g:matchup_matchparen_offscreen = {}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-arduino
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:arduino_use_slime = 1
let g:arduino_serial_baud = 9600

nnoremap <buffer> <Leader>am :ArduinoVerify<CR>
nnoremap <buffer> <Leader>au :ArduinoUpload<CR>
nnoremap <buffer> <Leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <Leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <Leader>ap :ArduinoChooseProgrammer<CR>
nnoremap <buffer> <Leader>as :ArduinoChoosePort<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" goyo.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>go :Goyo 100%x100%<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" limelight.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" telescope.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    shorten_path = true,
    prompt_position = "bottom",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-p>"] = false,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-n>"] = false,
        ["<c-j>"] = actions.move_selection_next,
      },
      n = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

nnoremap <Leader>te <cmd>lua require('telescope.builtin').builtin()<CR>
"nnoremap <Leader>fi <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ls <cmd>lua require('telescope.builtin').buffers({shorten_path = true})<CR>
nnoremap <Leader>fh <cmd>lua require('telescope.builtin').oldfiles({shorten_path = true})<CR>
nnoremap <Leader>re <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <Leader>sy <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <Leader>lg <cmd>lua require('telescope.builtin').git_commits()<CR>
nnoremap <Leader>li <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <Leader>he <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>ma <cmd>lua require('telescope.builtin').keymaps()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" delimitmate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

