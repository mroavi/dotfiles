"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vim philosophy: https://stackoverflow.com/a/1220118/1706778
" See: `:h nvim-configuration`
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap <Leader> key (should be placed on top of this file)
let mapleader = ' '
let maplocalleader = ' '

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" A fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Automatically clears search highlight when cursor is moved
Plug 'junegunn/vim-slash'

" A simple, easy-to-use Vim alignment plugin
Plug 'junegunn/vim-easy-align'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Defines a new text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" See https://github.com/vim-airline/vim-airline/wiki/Screenshots
Plug 'vim-airline/vim-airline-themes'

" Provides support for writing LaTeX documents
Plug 'lervag/vimtex', { 'for': ['tex'] }

" Navigate seamlessly between vim and tmux splits using a set of hotkeys
Plug 'toranb/tmux-navigator'

" Shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Simple tmux statusline generator with support for airline statusline integration
Plug 'edkolev/tmuxline.vim'

" A very fast, multi-syntax context-sensitive color name highlighter
Plug 'ap/vim-css-color'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" Grab some text and send it to a GNU Screen/tmux/NeoVim Terminal/Vim Terminal
Plug 'jpalardy/vim-slime'

" Seamlessly run Python code from Vim in IPython
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Vim support for Julia.
Plug 'JuliaEditorSupport/julia-vim'

" Cell support for Julia in Vim
Plug 'mroavi/vim-julia-cell', { 'for': ['julia'] }

" Vim plugin that shows keybindings in popup (On-demand lazy load)
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Color schemes
Plug 'chriskempson/base16-vim'

" Syntax highlighting for GNU Octave
Plug 'jvirtanen/vim-octave', { 'for': 'octave' }

" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'raimondi/delimitmate'

" Nvim LSP client configurations
Plug 'neovim/nvim-lsp'

" A wrapper for neovim built in LSP diagnosis config
Plug 'nvim-lua/diagnostic-nvim'

" An async completion framework for neovim's built in LSP written in Lua
Plug 'nvim-lua/completion-nvim'

" Highlight group manipulation for Vim
Plug 'wincent/pinnacle'

" UltiSnips is the ultimate solution for snippets in Vim (tracks the engine)
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them
Plug 'honza/vim-snippets'

" Highlight, navigate, and operate on sets of matching text
Plug 'andymass/vim-matchup'

" A fancy start screen for Vim/Neovim
Plug 'mhinz/vim-startify'

" Highlight a unique character in every word on a line when f, t, F or T is pressed
Plug 'unblevable/quick-scope'

" Syntax highlighting, matching rules and mappings for the original Markdown and extensions
Plug 'plasticboy/vim-markdown'

" Preview markdown on your browser with synchronised scrolling and flexible configuration
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Fast and featureful file manager in vim/neovim powered by nnn
Plug 'mcchrish/nnn.vim'

" Super simple vim plugin to show the list of buffers in the command bar
Plug 'bling/vim-bufferline'

" TEMP: Plugin to help you stop repeating the basic movement keys
Plug 'takac/vim-hardtime'

" TEMP: temporary fix for the gitgutter + deoplete-lsp problem
Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://neovim.io/doc/user/options.html#'shada'
set shada=%,<800,'50,/50,:100,h,f1
"         |   |   |   |    |  |  + store file marks 0-9,A-Z
"         |   |   |   |    |  + disable 'hlsearch' while loading viminfo
"         |   |   |   |    + maximum number of items in the command-line history to be saved
"         |   |   |   + maximum number of items in the search pattern history to be saved
"         |   |   + files marks saved for the last XX files edited
"         |   + maximum num of lines saved for each register (old name for <, vi6.2)
"         + save/restore buffer list
set number relativenumber " lines are numbered relative to the line the cursor is on
set noswapfile " they're just annoying. Who likes them?
set wrap linebreak nolist " avoid breaking lines in the middle of words
set noshowmode " don't show mode in status bar (taken care of by airline)
set hidden " allows switching from unwritten buffers and remembers the buffer undo history
set formatoptions-=tc " disable auto-wrap text using textwidth
set grepprg=rg\ --vimgrep " program to used for the :grep command.
set grepformat=%f:%l:%c:%m " format to recognize for the :grep command output
set splitbelow splitright " open a new split at to bottom or to the right of the current one
set signcolumn=yes " always show sign column
set tabstop=2 " number of spaces that a <Tab> in the file counts for
set softtabstop=2 " number of spaces that a <Tab> counts for while performing editing operations
set shiftwidth=2 " number of spaces for indents in normal mode
set expandtab " use spaces instead of tabs.
set shiftround " tab / shifting moves to closest tabstop.
set smartindent " intelligently dedent / indent new lines based on rules.
set updatetime=100 " among others, governs gitgutter's update time
set inccommand=split "shows the effects of a command incrementally, as you type
set listchars=tab:▸\ ,space:_,eol:¬ " define symbols for tabstops, spaces and EOLs
set scrolloff=10 " minimal number of screen lines to keep above and below the cursor

" Disable automatic comment insertion (https://superuser.com/a/271024/1087113)
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Custom mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch to next/previous buffer
nnoremap <silent> <M-h> :bprevious<CR>
nnoremap <silent> <M-l> :bnext<CR>

" Switch to previous visited buffer
nnoremap <silent> <M-p> :b#<CR>

" Unload current buffer
nnoremap <silent><M-d> :bdelete<CR>

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

" Substitute all occurrences of the content of the search register with new text
nnoremap <Leader>sa :%s///g<left><left>

" Unload buffer and switch to last visited buffer (to be used in conjunction with <Ledaer>i)
nnoremap <silent> <Leader>o :bdelete<CR>

" Close all buffers but the current one
map <Leader>bo :%bdelete\|e#<CR>

" Write to disk
nnoremap <Leader>w :write<CR>

" Yank to clipboard
vnoremap <Leader>y "+y

" Paste from clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p

" Clear highlight on pressing ESC
nnoremap <silent> <ESC> :noh<CR><ESC>

" Source .vimrc
map <Leader>sv :w<CR>:source $MYVIMRC<CR>

" Write and source the currently opened file
map <Leader>ss :w<CR>:source %<CR>

" Change to the directory of the current buffer and print it
nnoremap <Leader>cdb :cd %:p:h<CR> :pwd<CR>

" Move selected lines up/down reindenting if necessary
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Chrome-like tab mappings
nnoremap <C-t>     :tabnew<CR>
nnoremap <C-q>     :tabclose<CR>
" Ctrl+Shift+w -> close (hack: see alacritty.yml and .tmux.conf)
nnoremap <C-S-0>   :close<CR>

" Strip trailing whitespace from all lines in a file (https://vi.stackexchange.com/a/456/27039)
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" base16
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
  call Base16hi("Comment", g:base16_gui04, "", g:base16_cterm04,"" , "", "")
  call Base16hi("SpellBad", g:base16_gui00, g:base16_gui08, g:base16_cterm00, g:base16_cterm08, "", "")
  call Base16hi("SpellLocal", g:base16_gui00, "", g:base16_cterm00, "", "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

call s:base16_customize()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-slash
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Blink cursor after search
noremap <expr> <plug>(slash-after) slash#blink(1, 150)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile files into a 'build' dir
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_map_keys = 0
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
nmap <Leader>j  <Plug>(GitGutterNextHunk)
nmap <Leader>k  <Plug>(GitGutterPrevHunk)
nmap ]h         <Plug>(GitGutterNextHunk)
nmap [h         <Plug>(GitGutterPrevHunk)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" FZF
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
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Shift-Tab to select multiple results (-m flag required)
" :Files runs $FZF_DEFAULT_COMMAND defined in .zshrc
nnoremap <Leader>fi :Files<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>rg :MyRg<CR>
nnoremap <Leader>ag :Ag<CR>
nnoremap <M-'>      :Buffers<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-tmux-navigator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-highlightedyank
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 200

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-slime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
autocmd FileType julia,python let g:slime_cell_delimiter = "##"

" Execute current cell TODO this is not working
autocmd FileType octave nmap <buffer> <M-CR> <Plug>SlimeSendCell

" Map to Ctrl-Return
autocmd FileType julia,python,octave xmap <buffer> <C-CR> <Plug>SlimeRegionSend
autocmd FileType julia,python,octave nmap <buffer> <C-CR> <Plug>SlimeLineSend
autocmd FileType julia,python,octave imap <buffer> <C-CR> <C-o><Plug>SlimeLineSend

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add commands similar to those available through the Git plugin in Oh My ZSH
command! -complete=file -nargs=* Gd Git diff <args>
command! -complete=file -nargs=* Gds Git diff --staged <args>

nnoremap <Leader>gst :Git<CR>
nnoremap <Leader>gw  :Gwrite<CR>
nnoremap <Leader>gr  :Gread<CR>
nnoremap <Leader>gc  :Git commit<CR>
nnoremap <Leader>gp  :Git push<CR>
nnoremap <Leader>gl  :Git pull<CR>
nnoremap <Leader>gdi :Gd<CR>
nnoremap <Leader>gds :Gds<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" rooter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_manual_only = 1
nnoremap <Leader>cdr :Rooter<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-easy-align
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-hardtime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_maxcount = 3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-which-key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" tmuxline
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
"" nvim-lsp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
  local nvim_lsp = require'nvim_lsp'
  local on_attach_vim = function()
      require'diagnostic'.on_attach()
  end
  nvim_lsp.clangd.setup{
    on_attach=on_attach_vim,
    cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
  }
  nvim_lsp.julials.setup({on_attach=on_attach_vim})
EOF

" Do not run the following LSPs in SSH connections
if !$SSH_CONNECTION
lua << EOF
  local nvim_lsp = require'nvim_lsp'
  local on_attach_vim = function()
      require'diagnostic'.on_attach()
  end
  nvim_lsp.vimls.setup({on_attach=on_attach_vim})
  nvim_lsp.texlab.setup({on_attach=on_attach_vim})
  nvim_lsp.bashls.setup({on_attach=on_attach_vim})
  nvim_lsp.cmake.setup({on_attach=on_attach_vim})
EOF
endif

" Mappings (See `:h lsp-buf`)
nnoremap          <Leader>i  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap          <Leader>de <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap          <Leader>cw <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>re <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap          <Leader>di <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap                   K <cmd>lua vim.lsp.buf.hover()<CR>

" Signs
sign define LspDiagnosticsErrorSign       text=✖
sign define LspDiagnosticsWarningSign     text=⚠
sign define LspDiagnosticsInformationSign text=ℹ
sign define LspDiagnosticsHintSign        text=➤

" Colors
execute 'highlight LspDiagnosticsError ' . pinnacle#decorate('bold,italic', 'ErrorMsg')
execute 'highlight LspDiagnosticsErrorSign ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsError')
\ })
execute 'highlight LspDiagnosticsWarning ' . pinnacle#decorate('bold,italic', 'Type')
execute 'highlight LspDiagnosticsWarningSign ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsWarning')
\ })
execute 'highlight LspDiagnosticsInformation ' . pinnacle#decorate('bold,italic', 'Type')
execute 'highlight LspDiagnosticsInformationSign ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsInformation')
\ })
execute 'highlight LspDiagnosticsHint ' . pinnacle#decorate('bold,italic', 'Type')
execute 'highlight LspDiagnosticsHintSign ' . pinnacle#highlight({
\   'bg': pinnacle#extract_bg('SignColumn'),
\   'fg': pinnacle#extract_fg('LspDiagnosticsHint')
\ })

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" diagnostic-nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go to next/prev diagnostic message
nmap ]d :NextDiagnosticCycle<CR>
nmap [d :PrevDiagnosticCycle<CR>

let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_enable_underline = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" completion-nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let g:completion_trigger_keyword_length = 2
let g:completion_matching_ignore_case   = 1
let g:completion_enable_auto_hover      = 0
let g:completion_enable_auto_signature  = 0
let g:completion_auto_change_source     = 1
let g:completion_timer_cycle            = 200
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'mode': 'file'},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

" Manually trigger completion with
inoremap <silent><expr> <C-Space> completion#trigger_completion()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger       = "<CR>"
let g:UltiSnipsListSnippets        = "<C-Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" quick-scope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" markdown-preview.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>md :MarkdownPreview<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" nnn
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nnn#set_default_mappings = 0
let g:nnn#replace_netrw = 1
nnoremap <silent><leader>/ :NnnPicker '%:p:h'<CR>
let g:nnn#layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top'} }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
let g:nnn#command = 'nnn -o'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vim-bufferline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
let g:bufferline_pathshorten = 0
