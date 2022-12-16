local M = {}
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.api.nvim_command 'packadd packer.nvim'
end

M.setup = function()
  require('packer').startup(function(use)

    use { 'wbthomason/packer.nvim', config = function() require('mrv.plugins.packer') end } -- packer can manage itself
    use { 'nvim-lua/plenary.nvim', config = function() require('mrv.plugins.plenary') end } -- all the lua functions you don't want to write twice (I use it to reload my nvim config)
    use { 'tpope/vim-commentary', config = function() require('mrv.plugins.vim-commentary') end } -- comment stuff out
    use { 'lmburns/lf.nvim', config = function() require('mrv.plugins.lf-nvim') end, requires = { 'nvim-lua/plenary.nvim', 'akinsho/toggleterm.nvim' } } -- lf file manager for Neovim (in Lua)
    use { 'nvim-telescope/telescope.nvim', config = function() require('mrv.plugins.telescope') end, requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' } } -- find, filter, preview, pick
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('mrv.plugins.gitsigns') end } -- super fast git decorations implemented purely in lua/teal
    use { 'hrsh7th/nvim-cmp', config = function() require('mrv.plugins.cmp') end, requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' } } -- a completion plugin for neovim coded in Lua
    use { 'L3MON4D3/LuaSnip', config = function() require('mrv.plugins.luasnip') end, requires = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' } }
    use { '~/repos/tender.nvim', config = function() vim.cmd [[ colorscheme tender ]] end } -- my color scheme
    use { 'windwp/nvim-autopairs', config = function() require('mrv.plugins.autopairs') end } -- autopairs for neovim written by lua
    use { 'tpope/vim-fugitive', config = function() require('mrv.plugins.fugitive') end } -- a Git wrapper so awesome, it should be illegal
    use { 'tpope/vim-unimpaired' } -- pairs of handy bracket mappings
    use { 'tpope/vim-surround' } -- provides mappings to easily delete, change and add such surroundings in pairs
    use { 'tpope/vim-repeat' } -- enable repeating supported plugin maps with "."
    use { 'tpope/vim-obsession' } -- continuously updated session files
    use { 'mroavi/vim-pasta' } -- auto format pasted code
    use { 'wellle/targets.vim', config = function() require('mrv.plugins.targets') end } -- vim plugin that provides additional text objects
    use { 'yegappan/mru', config = function() require('mrv.plugins.mru') end } -- most recently used (MRU) vim plugin
    use { 'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end } -- quickstart configurations for the Nvim LSP client
    use { 'mroavi/vim-tomux', config = function() vim.cmd("exe 'source ~/.config/nvim/lua/mrv/plugins/tomux.vim'") end } -- send text to tmux
    use { 'JuliaEditorSupport/julia-vim', config = function() require('mrv.plugins.julia-vim') end } -- vim support for Julia
    use { 'folke/which-key.nvim', config = function() require('mrv.plugins.which-key') end } -- displays a popup with possible keybindings of the command you started typing
    use { 'lervag/vimtex', config = function() require('mrv.plugins.vimtex') end } -- a modern Vim and neovim filetype plugin for LaTeX files.
    use { 'junegunn/vim-easy-align', config = function() require('mrv.plugins.easy-align') end } -- a Vim alignment plugin
    use { 'junegunn/gv.vim', config = function() require('mrv.plugins.gv') end } -- a git commit browser in Vim
    use { 'nvim-treesitter/nvim-treesitter', config = function() require('mrv.plugins.treesitter') end, run = ':TSUpdate' } -- nvim treesitter configurations and abstraction layer
    use { 'nvim-treesitter/playground', config = function() require('mrv.plugins.playground') end } -- view treesitter information directly in Neovim
    use { 'skywind3000/asyncrun.vim', config = function() require('mrv.plugins.asyncrun') end } -- run Async Shell Commands and Output to the Quickfix Window
    use { 'mroavi/vim-evanesco' } -- automatically clears search highlight
    use { '~/repos/slides.vim', config = function() require('mrv.plugins.slides') end, requires = { 'edluffy/hologram.nvim', 'junegunn/limelight.vim', 'tpope/vim-obsession' } } -- presentation slides in vim

    -- {{{1

    -- Disabled
    --use { 'preservim/vim-markdown' } -- syntax highlighting, matching rules and mappings for Markdown and extensions
    --use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end } -- the fastest Neovim colorizer.
    --use { 'dstein64/nvim-scrollview', config = function() require('mrv.plugins.scrollview') end } -- a Neovim plugin that displays (non-interactive) scrollbars
    --use { 'kdheepak/JuliaFormatter.vim', ft = "julia", config = function() require('mrv.plugins.JuliaFormatter') end } -- formatter for Julia
    --use { 'folke/lua-dev.nvim' } -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
    --use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end, ft = { 'markdown' } } -- preview markdown on your browser with synchronised scrolling
    --use { 'vim-pandoc/vim-pandoc-syntax' } -- pandoc markdown syntax, to be installed alongside vim-pandoc
    --use { 'quarto-dev/quarto-vim', requires = { 'vim-pandoc/vim-pandoc-syntax' } } -- rmarkdown support for vim
    --use { 'akinsho/toggleterm.nvim', config = function() require('mrv.plugins.toggleterm') end } -- a neovim lua plugin to help easily manage multiple terminal windows
    --use { 'jose-elias-alvarez/null-ls.nvim', config = function() require('mrv.plugins.null-ls') end } -- use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    --use { 'mroavi/lf.vim', config = function() require('mrv.plugins.lf-vim') end } -- file manager for vim/neovim powered by lf
    --use { 'vladdoster/remember.nvim', config = [[ require('remember') ]] } -- remembers cursor position
    --use { 'romainl/vim-cool' } -- disables search highlighting when you are done searching and re-enables it when you search again
    --use { '~/repos/goyo.vim', config = function() vim.cmd("exe 'source ~/.config/nvim/lua/mrv/plugins/goyo.vim'") end } -- distraction-free writing in Vim
    --use { 'edluffy/hologram.nvim', config = function() require('mrv.plugins.hologram') end } -- a cross platform terminal image viewer for Neovim
    --use { 'junegunn/limelight.vim', config = function() require('mrv.plugins.limelight') end } -- all the world's indeed a stage and we are merely players

    -- TODO: Try these out!
    --use { 'famiu/nvim-reload' } -- plugin to easily reload your Neovim config
    --use { 'kassio/neoterm' } -- wrapper of some vim/neovim's :terminal functions
    --use { 'sindrets/diffview.nvim' } -- single tabpage interface for easily cycling through diffs for all modified files for any git rev
    --use { "ray-x/lsp_signature.nvim" } -- lsp signature hint when you type
    --use { "glepnir/lspsaga.nvim" } -- a light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
    --use { 'terrortylor/nvim-comment', config = function() require('mrv.plugins.nvim-comment') end } -- a comment toggler for Neovim, written in Lua
    --use { 'chipsenkbeil/distant.nvim', } -- edit files, run programs, and work with LSP on a remote machine from the comfort of your local environment construction
    --use { 'rcarriga/nvim-notify', } -- a fancy, configurable, notification manager for NeoVim
    --use { 'sainnhe/everforest', config = function() vim.cmd [[ let g:everforest_background = 'hard' | colorscheme everforest ]] end } -- comfortable & pleasant color scheme for vim
    --use { 'lukas-reineke/indent-blankline.nvim' } -- indent guides for Neovim
    --use { 'ldelossa/gh.nvim.git' } -- Github integration powered by litee.nvim
    --use { 'rbong/vim-flog' } -- A lightweight and powerful git branch viewer for vim (mrv: potential replacement for gv)
    --use { 'lewis6991/impatient.nvim', config = function() require('impatient') end } -- improve startup time for Neovim
    --use { 'tpope/vim-rhubarb' } -- GitHub extension for fugitive.vim
    --use { 'smjonas/live-command.nvim' } -- the easiest way to create previewable commands in Neovim
    --use { 'xolox/vim-notes' } -- easy note taking in Vim

    -- Abandoned
    --use { 'raimondi/delimitmate', config = function() require('mrv.plugins.delimitmate') end } -- provides insert mode auto-completion for quotes, parens, brackets, etc.
    --use { 'ap/vim-buftabline', config = function() require('mrv.plugins.vim-buftabline') end } -- a well-integrated, low-configuration buffer list that lives in the tabline
    --use { 'romgrk/barbar.nvim', config = function() require('mrv.plugins.barbar') end } -- a neovim tabline plugin
    --use { 'voldikss/vim-floaterm', config = function() require('mrv.plugins.floaterm') end } -- use (neo)vim terminal in the floating/popup window
    --use { 'b3nj5m1n/kommentary', config = function() require('mrv.plugins.kommentary') end } -- Neovim commenting plugin, written in lua
    --use { 'qxxxb/vim-searchhi', config = function() require('mrv.plugins.vim-searchhi') end } -- highlight the current search result differently
    --use { 'junegunn/vim-slash', config = function() require('mrv.plugins.slash') end } -- automatically clears search highlight when cursor is moved
    --use { 'jose-elias-alvarez/buftabline.nvim', config = function() require('mrv.plugins.buftabline') end } -- a well-integrated, low-configuration buffer list that lives in the tabline
    --use { 'edkolev/tmuxline.vim', config = function() require('mrv.plugins.tmuxline') end } -- simple tmux statusline generator with support for powerline symbols
    --use { 'rafamadriz/neon', config = function() vim.cmd [[ colorscheme neon ]] end } -- the color scheme I used as base for my color scheme
    --use { 'toranb/tmux-navigator', config = function() require('mrv.plugins.tmux-navigator') end } -- navigate seamlessly between vim and tmux splits using a set of hotkeys
    --use { 'mcchrish/nnn.vim' } -- file manager for vim/neovim powered by n³
    --use { 'ojroques/vim-oscyank', config = function() require('mrv.plugins.vim-oscyank') end } -- a Vim plugin to copy text through SSH with OSC52

    -- }}}

  end)
end

return M

-- vim:set foldenable foldmethod=marker nowrap:
