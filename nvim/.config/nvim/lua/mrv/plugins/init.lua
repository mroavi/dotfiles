local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  ui = { border = 'single' },
  dev = { path = "~/repos" },
}

local plugins = {

  { 'tpope/vim-commentary', config = function() require('mrv.plugins.vim-commentary') end }, -- comment stuff out
  { 'lmburns/lf.nvim', config = function() require('mrv.plugins.lf-nvim') end, dependencies = { 'nvim-lua/plenary.nvim', 'akinsho/toggleterm.nvim' } }, -- lf file manager for Neovim (in Lua)
  { 'nvim-telescope/telescope.nvim', config = function() require('mrv.plugins.telescope') end, dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' } }, -- find, filter, preview, pick
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require('mrv.plugins.gitsigns') end }, -- super fast git decorations implemented purely in lua/teal
  { 'hrsh7th/nvim-cmp', config = function() require('mrv.plugins.cmp') end, dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' } }, -- a completion plugin for neovim coded in Lua
  { 'L3MON4D3/LuaSnip', config = function() require('mrv.plugins.luasnip') end },
  { 'windwp/nvim-autopairs', config = function() require('mrv.plugins.autopairs') end }, -- autopairs for neovim written by lua
  { 'tpope/vim-fugitive', config = function() require('mrv.plugins.fugitive') end }, -- a Git wrapper so awesome, it should be illegal
  { 'tpope/vim-unimpaired' }, -- pairs of handy bracket mappings
  { 'tpope/vim-surround' }, -- provides mappings to easily delete, change and add such surroundings in pairs
  { 'tpope/vim-repeat' }, -- enable repeating supported plugin maps with "."
  { 'tpope/vim-obsession' }, -- continuously updated session files
  { 'mroavi/vim-pasta' }, -- auto format pasted code
  { 'wellle/targets.vim', config = function() require('mrv.plugins.targets') end }, -- vim plugin that provides additional text objects
  { 'yegappan/mru', init = function() require('mrv.plugins.mru') end }, -- most recently used (MRU) vim plugin
  { 'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end }, -- quickstart configurations for the Nvim LSP client
  { 'mroavi/vim-tomux', config = function() vim.cmd("exe 'source ~/.config/nvim/lua/mrv/plugins/tomux.vim'") end }, -- send text to tmux
  { 'folke/which-key.nvim', config = function() require('mrv.plugins.which-key') end }, -- displays a popup with possible keybindings of the command you started typing
  { 'lervag/vimtex', config = function() require('mrv.plugins.vimtex') end }, -- a modern Vim and neovim filetype plugin for LaTeX files.
  { 'junegunn/vim-easy-align', config = function() require('mrv.plugins.easy-align') end }, -- a Vim alignment plugin
  { 'junegunn/gv.vim', config = function() require('mrv.plugins.gv') end }, -- a git commit browser in Vim
  { 'nvim-treesitter/nvim-treesitter', config = function() require('mrv.plugins.treesitter') end, build = ':TSUpdate', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' } }, -- nvim treesitter configurations and abstraction layer
  { 'nvim-treesitter/playground', config = function() require('mrv.plugins.playground') end, dependencies = { 'nvim-treesitter/nvim-treesitter' } }, -- view treesitter information directly in Neovim
  { 'skywind3000/asyncrun.vim', config = function() require('mrv.plugins.asyncrun') end }, -- run Async Shell Commands and Output to the Quickfix Window
  { 'mroavi/vim-evanesco' }, -- automatically clears search highlight
  { 'nvim-neorg/neorg', config = function() require('mrv.plugins.neorg') end, build = ':Neorg sync-parsers', dependencies = { { 'nvim-lua/plenary.nvim' } } }, -- the future of organizing your life in Neovim
  { "lukas-reineke/indent-blankline.nvim", config = function() require('mrv.plugins.indent-blankline') end }, -- indent guides for Neovim
  { "catppuccin/nvim", name = "catppuccin", config = function() require('mrv.plugins.catppuccin') end }, -- soothing pastel theme for (Neo)vim

  -- {{{1

  -- Disabled
  --{ '~/repos/slides.vim', config = function() require('mrv.plugins.slides') end, dependencies = { 'edluffy/hologram.nvim', 'junegunn/limelight.vim', 'tpope/vim-obsession' } }, -- presentation slides in vim
  --{ 'preservim/vim-markdown' }, -- syntax highlighting, matching rules and mappings for Markdown and extensions
  --{ 'NvChad/nvim-colorizer.lua', config = function() require('colorizer').setup() end }, -- the fastest Neovim colorizer.
  --{ 'dstein64/nvim-scrollview', config = function() require('mrv.plugins.scrollview') end }, -- a Neovim plugin that displays (non-interactive) scrollbars
  --{ 'kdheepak/JuliaFormatter.vim', ft = "julia", config = function() require('mrv.plugins.JuliaFormatter') end }, -- formatter for Julia
  --{ 'folke/lua-dev.nvim' }, -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
  --{ 'iamcco/markdown-preview.nvim', build = function() vim.fn['mkdp#util#install']() end, ft = { 'markdown' } }, -- preview markdown on your browser with synchronised scrolling
  --{ 'vim-pandoc/vim-pandoc-syntax' }, -- pandoc markdown syntax, to be installed alongside vim-pandoc
  --{ 'quarto-dev/quarto-vim', dependencies = { 'vim-pandoc/vim-pandoc-syntax' } }, -- rmarkdown support for vim
  --{ 'akinsho/toggleterm.nvim', config = function() require('mrv.plugins.toggleterm') end }, -- a neovim lua plugin to help easily manage multiple terminal windows
  --{ 'jose-elias-alvarez/null-ls.nvim', config = function() require('mrv.plugins.null-ls') end }, -- use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  --{ 'mroavi/lf.vim', config = function() require('mrv.plugins.lf-vim') end }, -- file manager for vim/neovim powered by lf
  --{ 'vladdoster/remember.nvim', config = [[ require('remember') ]] }, -- remembers cursor position
  --{ 'romainl/vim-cool' }, -- disables search highlighting when you are done searching and re-enables it when you search again
  --{ '~/repos/goyo.vim', config = function() vim.cmd("exe 'source ~/.config/nvim/lua/mrv/plugins/goyo.vim'") end }, -- distraction-free writing in Vim
  --{ 'edluffy/hologram.nvim', config = function() require('mrv.plugins.hologram') end }, -- a cross platform terminal image viewer for Neovim
  --{ 'junegunn/limelight.vim', config = function() require('mrv.plugins.limelight') end }, -- all the world's indeed a stage and we are merely players
  --{ 'folke/zen-mode.nvim' , config = function() require('mrv.plugins.zen-mode') end }, -- distraction-free coding for Neovim
  --{ 'JuliaEditorSupport/julia-vim', config = function() require('mrv.plugins.julia-vim') end }, -- vim support for Julia
  --{ 'L3MON4D3/LuaSnip', config = function() require('mrv.plugins.luasnip') end, dependencies = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' } },
  --{ 'williamboman/mason.nvim', config = function() require('mrv.plugins.mason') end, dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' } }, -- easily install and manage LSP servers, DAP servers, linters, and formatters
  --{ 'amarakon/nvim-cmp-lua-latex-symbols' }, -- nvim-cmp source for LaTeX symbols (100% Lua)
  --{ 'hrsh7th/cmp-emoji' }, -- nvim-cmp source for emoji
  --{ 'nvim-lua/plenary.nvim', config = function() require('mrv.plugins.plenary') end }, -- all the lua functions you don't want to write twice (I use it to reload my nvim config)
  --{ 'jackMort/ChatGPT.nvim' , config = function() require('mrv.plugins.chatgpt') end, dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" } }, -- plugin for interacting with OpenAI GPT-3 chatbot
  --{ 'stevearc/oil.nvim' }, -- Neovim file explorer: edit your filesystem like a buffer
  --{ dir = '~/repos/tender.nvim', config = function() vim.cmd.colorscheme("tender") end }, -- my color scheme
  --{ 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1000, config = function() require('mrv.plugins.rose-pine') end },

  -- TODO: Try these out!
  --{ 'famiu/nvim-reload' }, -- plugin to easily reload your Neovim config
  --{ 'kassio/neoterm' }, -- wrapper of some vim/neovim's :terminal functions
  --{ 'sindrets/diffview.nvim' }, -- single tabpage interface for easily cycling through diffs for all modified files for any git rev
  --{ "ray-x/lsp_signature.nvim" }, -- lsp signature hint when you type
  --{ "glepnir/lspsaga.nvim" }, -- a light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
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

  -- }}}

}

M.setup = function()
  require('lazy').setup(plugins, opts)
end

require('lazy.view.config').keys.close = '<Esc>' -- hack (see https://github.com/folke/lazy.nvim/issues/468)
vim.keymap.set("n", "<Leader>L", ":Lazy<CR>")

return M

-- vim:set foldenable foldmethod=marker nowrap:
