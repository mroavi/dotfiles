"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim philosopy: 
" - https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118

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
set viminfo=%,<800,'10,/50,:100,h,f1
"           | |    |   |   |    | + store file marks 0-9,A-Z
"           | |    |   |   |    + disable 'hlsearch' while loading viminfo
"           | |    |   |   + maximum number of items in the command-line history to be saved 
"           | |    |   + maximum number of items in the search pattern history to be saved
"           | |    + files marks saved
"           | + maximum num of lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

set nocompatible " We don't need Vi compatibility
set number " show line numbers
set relativenumber " each line in your file is numbered relative to the cursor’s current position
set title " show file in titlebar
set noswapfile " They're just annoying. Who likes them?
set t_Co=256 " needed so that color scheme displays fine
"set colorcolumn=80 " highlight column
set wrap linebreak nolist " avoid breaking lines in the middle of words

set noshowmode " don't show mode in status bar (taken care of by airline)
set noruler " don't show cursor position in status bar
set laststatus=0 " when to display the status line (see :h laststatus)
set noshowcmd " don't show partial typed commands in the right of the status bar
set cmdheight=1 " limit the cmd line height to one 

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
:map <F5> :setlocal spell! spelllang=en_us<CR>

" Refresh changed content of file opened in vi(m)
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |  checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"" Use enter to create new lines w/o entering insert mode "" https://github.com/colbycheeze/dotfiles/blob/master/vimrc
"nnoremap <CR> o<Esc>
""Below is to fix issues with the ABOVE mappings in quickfix window
"autocmd CmdwinEnter * nnoremap <CR> <CR>
"autocmd BufReadPost quickfix nnoremap <CR> <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap :FZF to Ctrl+p
nnoremap <C-p> :FZF<CR>

" Remap default prefix from Ctrl+w to Ctrl+a 
nnoremap <C-a> <C-w>

" Close tab with Ctrl+w
nnoremap <C-w> :tabclose<CR>

" Disable Ctl+z (which kills the process in vim-gnome)
noremap <C-z> <Nop>

" Ctrl+t -> new tab
nnoremap <C-t> :tabnew<CR>

" Shortcut to rapidly toggle `set list!`
" http://vimcasts.org/episodes/show-invisibles/
nmap <leader>l :set list!<CR>

" Define symbols for tabstops, spaces and EOLs
set listchars=tab:▸\ ,space:_,eol:¬

" Chorme-like tab commands (conflicts with tmux)
" based on: https://stackoverflow.com/a/31961401/1706778

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

" Defines a new text object representing lines of code at the same indent level
Plug 'michaeljsmith/vim-indent-object'
" Plug 'kana/vim-textobj-indent'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" See: https://github.com/vim-airline/vim-airline/wiki/Screenshots
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
Plug 'tpope/vim-unimpaired'

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

" A code-completion engine for Vim
"Plug 'valloric/youcompleteme'

" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" Colorschemes
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'nlknguyen/papercolor-theme'
Plug 'lifepillar/vim-gruvbox8'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jdkanani/vim-material-theme'

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

" Jump forward on the current line 
nmap f <Plug>(easymotion-lineforward)

" Jump backwards on the current line 
nmap F <Plug>(easymotion-linebackward)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The delay is governed by vim's updatetime option
set updatetime=100

" Always show sign column
set signcolumn=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore files specified by .gitignore
" https://github.com/junegunn/fzf.vim/issues/121
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" julia-vim options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable matchit plugin (this plugin is distributed with Vim)
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc will install these extensions if they are missing
let g:coc_global_extensions = [
    \ 'coc-clangd'
    \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" mrv: Also use F2 for symbol renaming
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Increase highlight intensity (type :hi to see all the highlight options)
highlight link CocHighlightText PmenuSel

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vifm.vim options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/vifm/vifm.vim/issues/19
let g:vifm_embed_term=1
let g:vifm_embed_split=1

" Map toggle vifm to Ctrl+\
nnoremap <C-Bslash> :leftabove vertical 40Vifm<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tmux-navigator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-highlightedyank options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 200
