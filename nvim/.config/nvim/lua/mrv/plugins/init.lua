local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  ui = { border = 'single' },
  dev = { path = "~/repos" },
  rocks = { enabled = false }, -- TEMP: solves lazy/telescope-zf-native.nvim issue. See: https://github.com/natecraddock/telescope-zf-native.nvim/issues/21
}

local plugins = {

  { 'tpope/vim-commentary' }, -- comment stuff out (builtin nvim gc support comming soon: https://github.com/neovim/neovim/pull/28176)
  { 'stevearc/oil.nvim', config = function() require('mrv.plugins.oil') end, dependencies = { "MagicDuck/grug-far.nvim" } }, -- neovim file explorer: edit your filesystem like a buffer
  { 'lmburns/lf.nvim', config = function() require('mrv.plugins.lf-nvim') end, dependencies = { 'nvim-lua/plenary.nvim', 'akinsho/toggleterm.nvim' } }, -- lf file manager for Neovim (in Lua)
  { 'ibhagwan/fzf-lua', config = function() require('mrv.plugins.fzf-lua') end, dependencies = { "nvim-tree/nvim-web-devicons" } }, -- improved fzf.vim written in lua
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require('mrv.plugins.gitsigns') end }, -- super fast git decorations implemented purely in lua/teal
  { 'L3MON4D3/LuaSnip', event = 'InsertEnter', config = function() require('mrv.plugins.luasnip') end, dependencies = { 'rafamadriz/friendly-snippets' } },
  { 'saghen/blink.cmp', lazy = false, dependencies = { 'rafamadriz/friendly-snippets', { 'L3MON4D3/LuaSnip', version = 'v2.*' } }, version = 'v0.*', config = function() require('mrv.plugins.blink') end }, -- performant, batteries-included completion plugin for Neovim
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = function() require('mrv.plugins.autopairs') end }, -- autopairs for neovim written by lua
  { 'tpope/vim-fugitive', init = function() require('mrv.plugins.fugitive') end, dependencies = { 'tpope/vim-rhubarb' } }, -- a Git wrapper so awesome, it should be illegal
  { 'tpope/vim-unimpaired' }, -- pairs of handy bracket mappings
  { 'kylechui/nvim-surround', version = '^3.0.0', event = 'VeryLazy', config = function() require("nvim-surround").setup() end },
  { 'tpope/vim-repeat' }, -- enable repeating supported plugin maps with "."
  { 'tpope/vim-obsession' }, -- continuously updated session files
  { 'mroavi/vim-pasta' }, -- auto format pasted code
  { 'yegappan/mru', init = function() require('mrv.plugins.mru') end }, -- most recently used (MRU) vim plugin
  { 'mfussenegger/nvim-jdtls' }, -- extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
  { 'mason-org/mason.nvim', config = function() require('mrv.plugins.mason') end, dependencies = { 'mason-org/mason-lspconfig.nvim', version = "^1.0.0" }, version = "^1.0.0" }, -- easily install and manage LSP servers, DAP servers, linters, and formatters
  { 'mroavi/vim-tomux', init = function() vim.cmd("exe 'source ~/.config/nvim/lua/mrv/plugins/tomux.vim'") end }, -- send text to tmux
  { 'lervag/vimtex', init = function() require('mrv.plugins.vimtex') end }, -- a modern Vim and neovim filetype plugin for LaTeX files.
  { 'nvim-treesitter/nvim-treesitter', config = function() require('mrv.plugins.treesitter') end, build = ':TSUpdate', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' } }, -- nvim treesitter configurations and abstraction layer
  { 'skywind3000/asyncrun.vim', init = function() require('mrv.plugins.asyncrun') end }, -- run Async Shell Commands and Output to the Quickfix Window
  { 'mroavi/vim-evanesco' }, -- automatically clears search highlight
  { 'catppuccin/nvim', name = "catppuccin", config = function() require('mrv.plugins.catppuccin') end }, -- soothing pastel theme for (Neo)vim
  { 'junegunn/vim-easy-align', init = function() require('mrv.plugins.easy-align') end }, -- a Vim alignment plugin
  { 'junegunn/gv.vim', cmd = 'GV', init = function() require('mrv.plugins.gv') end }, -- a git commit browser in Vim
  { 'Wansmer/treesj', config = function() require('mrv.plugins.treesj') end, dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.splitjoin' } }, -- Neovim plugin for splitting/joining blocks of code
  { 'stevearc/conform.nvim', config = function() require('mrv.plugins.conform') end }, -- lightweight yet powerful formatter plugin for Neovim
  { 'MagicDuck/grug-far.nvim', config = function() require('mrv.plugins.grug-far') end } -- find and replace plugin for neovim

  -- {{{1

  -- Disabled
  --{ 'NvChad/nvim-colorizer.lua', config = function() require('colorizer').setup() end }, -- the fastest Neovim colorizer
  --{ 'folke/lua-dev.nvim' }, -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
  --{ 'iamcco/markdown-preview.nvim', build = function() vim.fn['mkdp#util#install']() end, ft = { 'markdown' } }, -- preview markdown on your browser with synchronised scrolling
  --{ 'vim-pandoc/vim-pandoc-syntax' }, -- pandoc markdown syntax, to be installed alongside vim-pandoc
  --{ 'quarto-dev/quarto-vim', dependencies = { 'vim-pandoc/vim-pandoc-syntax' } }, -- rmarkdown support for vim
  --{ 'mroavi/lf.vim', config = function() require('mrv.plugins.lf-vim') end }, -- file manager for vim/neovim powered by lf
  --{ 'romainl/vim-cool' }, -- disables search highlighting when you are done searching and re-enables it when you search again
  --{ 'mroavi/goyo.vim', dev = true, config = function() vim.cmd("exe 'source ~/.config/nvim/lua/mrv/plugins/goyo.vim'") end }, -- distraction-free writing in Vim
  --{ 'edluffy/hologram.nvim', config = function() require('mrv.plugins.hologram') end }, -- a cross platform terminal image viewer for Neovim
  --{ 'junegunn/limelight.vim', config = function() require('mrv.plugins.limelight') end }, -- all the world's indeed a stage and we are merely players
  --{ 'folke/zen-mode.nvim' , config = function() require('mrv.plugins.zen-mode') end }, -- distraction-free coding for Neovim
  --{ 'amarakon/nvim-cmp-lua-latex-symbols' }, -- nvim-cmp source for LaTeX symbols (100% Lua)
  --{ 'hrsh7th/cmp-emoji' }, -- nvim-cmp source for emoji
  --{ 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1000, config = function() require('mrv.plugins.rose-pine') end },
  --{ 'nvim-treesitter/playground', config = function() require('mrv.plugins.playground') end, dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- view treesitter information directly in Neovim
  --{ 'lukas-reineke/indent-blankline.nvim', config = function() require('mrv.plugins.indent-blankline') end }, -- indent guides for Neovim
  --{ 'folke/which-key.nvim', config = function() require('mrv.plugins.which-key') end }, -- displays a popup with possible keybindings of the command you started typing
  --{ 'mroavi/slides.vim', dev = true, config = function() require('mrv.plugins.slides') end, dependencies = { 'edluffy/hologram.nvim', 'junegunn/limelight.vim', 'tpope/vim-obsession' } }, -- presentation slides in vim
  --{ 'kaarmu/typst.vim' }, -- Vim plugin for Typst
  --{ 'nvim-telescope/telescope.nvim', config = function() require('mrv.plugins.telescope') end, dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'natecraddock/telescope-zf-native.nvim' } }, -- find, filter, preview, pick
  --{ 'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end }, -- quickstart configurations for the Nvim LSP client

  -- Try these out!
  --{ 'famiu/nvim-reload' }, -- plugin to easily reload your Neovim config
  --{ 'kassio/neoterm' }, -- wrapper of some vim/neovim's :terminal functions
  --{ 'sindrets/diffview.nvim' }, -- single tabpage interface for easily cycling through diffs for all modified files for any git rev
  --{ 'ray-x/lsp_signature.nvim', config = function() require('mrv.plugins.lsp_signature') end }, -- LSP signature hint as you type
  --{ 'glepnir/lspsaga.nvim', config = function() require('mrv.plugins.lspsaga') end, dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } }, -- a light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
  --{ 'terrortylor/nvim-comment', config = function() require('mrv.plugins.nvim-comment') end }, -- a comment toggler for Neovim, written in Lua
  --{ 'chipsenkbeil/distant.nvim', }, -- edit files, run programs, and work with LSP on a remote machine from the comfort of your local environment construction
  --{ 'rcarriga/nvim-notify', }, -- a fancy, configurable, notification manager for NeoVim
  --{ 'sainnhe/everforest', config = function() vim.cmd [[ let g:everforest_background = 'hard' | colorscheme everforest ]] end }, -- comfortable & pleasant color scheme for vim
  --{ 'ldelossa/gh.nvim.git' }, -- Github integration powered by litee.nvim
  --{ 'rbong/vim-flog' }, -- A lightweight and powerful git branch viewer for vim (mrv: potential replacement for gv)
  --{ 'lewis6991/impatient.nvim', config = function() require('impatient') end }, -- improve startup time for Neovim
  --{ 'tpope/vim-rhubarb' }, -- GitHub extension for fugitive.vim
  --{ 'smjonas/live-command.nvim' }, -- the easiest way to create previewable commands in Neovim
  --{ 'xolox/vim-notes' }, -- easy note taking in Vim
  --{ 'tpope/vim-vinegar' }, -- combine with netrw to create a delicious salad dressing
  --{ 'stevearc/dressing.nvim' }, -- Neovim plugin to improve the default vim.ui interfaces
  --{ 'kevinhwang91/nvim-ufo' }, -- not UFO in the sky, but an ultra fold in Neovim
  --{ 'folke/todo-comments.nvim' }, -- highlight, list and search todo comments in your projects
  --{ 'lukas-reineke/headlines.nvim' }, -- adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg
  --{ 'nvim-pack/nvim-spectre', config = function() require('mrv.plugins.spectre') end }, -- global find and replace tool
  --{ 'homerours/jumper.nvim' }, -- a Neovim plugin for jumping to files and folders.
  --{ 'OXY2DEV/markview.nvim' }, -- Experimental markdown preview for neovim
  --{ 'rachartier/tiny-inline-diagnostic.nvim' }, -- A Neovim plugin that display prettier diagnostic messages.
  --{ 'ColinKennedy/cursor-text-objects.nvim' }, -- Use [ and ] to enhance all of your Neovim text-objects and text-operators!
  --{ 'inhesrom/remote-ssh.nvim' } -- support for working with remote files in Neovim via SSH, SCP, or rsync protocols

  -- Abandoned
  --{ 'raimondi/delimitmate', config = function() require('mrv.plugins.delimitmate') end }, -- provides insert mode auto-completion for quotes, parens, brackets, etc.
  --{ 'ap/vim-buftabline', config = function() require('mrv.plugins.vim-buftabline') end }, -- a well-integrated, low-configuration buffer list that lives in the tabline
  --{ 'romgrk/barbar.nvim', config = function() require('mrv.plugins.barbar') end }, -- a neovim tabline plugin
  --{ 'voldikss/vim-floaterm', config = function() require('mrv.plugins.floaterm') end }, -- use (neo)vim terminal in the floating/popup window
  --{ 'b3nj5m1n/kommentary', config = function() require('mrv.plugins.kommentary') end }, -- Neovim commenting plugin, written in lua
  --{ 'qxxxb/vim-searchhi', config = function() require('mrv.plugins.vim-searchhi') end }, -- highlight the current search result differently
  --{ 'junegunn/vim-slash', config = function() require('mrv.plugins.slash') end }, -- automatically clears search highlight when cursor is moved
  --{ 'jose-elias-alvarez/buftabline.nvim', config = function() require('mrv.plugins.buftabline') end }, -- a well-integrated, low-configuration buffer list that lives in the tabline
  --{ 'edkolev/tmuxline.vim', config = function() require('mrv.plugins.tmuxline') end }, -- simple tmux statusline generator with support for powerline symbols
  --{ 'rafamadriz/neon', config = function() vim.cmd [[ colorscheme neon ]] end }, -- the color scheme I used as base for my color scheme
  --{ 'toranb/tmux-navigator', config = function() require('mrv.plugins.tmux-navigator') end }, -- navigate seamlessly between vim and tmux splits using a set of hotkeys
  --{ 'mcchrish/nnn.vim' }, -- file manager for vim/neovim powered by n³
  --{ 'ojroques/vim-oscyank', config = function() require('mrv.plugins.vim-oscyank') end }, -- a Vim plugin to copy text through SSH with OSC52
  --{ 'kdheepak/JuliaFormatter.vim', ft = "julia", config = function() require('mrv.plugins.JuliaFormatter') end }, -- formatter for Julia
  --{ 'akinsho/toggleterm.nvim', config = function() require('mrv.plugins.toggleterm') end }, -- a neovim lua plugin to help easily manage multiple terminal windows
  --{ 'vladdoster/remember.nvim', config = [[ require('remember') ]] }, -- remembers cursor position
  --{ 'JuliaEditorSupport/julia-vim', config = function() require('mrv.plugins.julia-vim') end }, -- vim support for Julia
  --{ 'nvim-lua/plenary.nvim', config = function() require('mrv.plugins.plenary') end }, -- all the lua functions you don't want to write twice (I use it to reload my nvim config)
  --{ 'jackMort/ChatGPT.nvim' , config = function() require('mrv.plugins.chatgpt') end, dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" } }, -- plugin for interacting with OpenAI GPT-3 chatbot
  --{ 'wellle/targets.vim', config = function() require('mrv.plugins.targets') end }, -- vim plugin that provides additional text objects
  --{ 'nvim-neorg/neorg', config = function() require('mrv.plugins.neorg') end, build = ':Neorg sync-parsers', dependencies = { { 'nvim-lua/plenary.nvim' } } }, -- the future of organizing your life in Neovim
  --{ 'echasnovski/mini.splitjoin', keys = 'gS', config = function() require('mrv.plugins.mini-splitjoin') end }, -- Neovim Lua plugin to split and join arguments. Part of 'mini.nvim' library.
  --{ 'bennypowers/splitjoin.nvim', config = function() require('mrv.plugins.splitjoin') end }, -- split or join list-like syntax constructs
  --{ 'preservim/vim-markdown' }, -- syntax highlighting, matching rules and mappings for Markdown and extensions
  --{ 'dstein64/nvim-scrollview', config = function() require('mrv.plugins.scrollview') end }, -- a Neovim plugin that displays (non-interactive) scrollbars
  --{ 'mroavi/tender.nvim', dev =true, config = function() vim.cmd.colorscheme("tender") end }, -- my color scheme
  --{ 'hrsh7th/nvim-cmp', event = 'InsertEnter', config = function() require('mrv.plugins.cmp') end, dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' } }, -- a completion plugin for neovim coded in Lua

  -- }}}

}

M.setup = function()
  require('lazy').setup(plugins, opts)
end

require('lazy.view.config').keys.close = '<Esc>' -- hack (see https://github.com/folke/lazy.nvim/issues/468)
vim.keymap.set("n", "<Leader>pm", ":Lazy<CR>")

return M

-- vim:set foldenable foldmethod=marker nowrap:
