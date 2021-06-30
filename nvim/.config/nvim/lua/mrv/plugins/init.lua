local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'} -- Packer can manage itself
  use {'~/repos/marlin.vim/', config = function() vim.cmd [[ colorscheme marlin ]] end} -- My dark color scheme
  use {'cormacrelf/vim-colors-github'} -- My light color scheme
  use {'tpope/vim-unimpaired'} -- Pairs of handy bracket mappings
  use {'tpope/vim-surround'} -- Provides mappings to easily delete, change and add such surroundings in pairs
  use {'tpope/vim-repeat'} -- Enable repeating supported plugin maps with "."
  use {'JuliaEditorSupport/julia-vim'} -- Vim support for Julia
  use {'sickill/vim-pasta'} -- Auto format pasted code
  use {'plasticboy/vim-markdown'} -- Syntax highlighting, matching rules and mappings for Markdown and extensions
  use {'svermeulen/vimpeccable'} -- Easily write your .vimrc in lua or any lua based language
  use {'hrsh7th/vim-vsnip'} -- VSCode(LSP)'s snippet feature in vim
  use {'nvim-lua/popup.nvim'} -- [WIP] An implementation of the Popup API from vim in Neovim
  use {'nvim-lua/plenary.nvim'} -- All the lua functions I don't want to write twice
  use {'nvim-telescope/telescope.nvim', config = function() require('mrv.plugins.telescope') end} -- Find, Filter, Preview, Pick. All lua, all the time
  use {'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end} -- Quickstart configurations for the Nvim LSP client
  use {'hrsh7th/nvim-compe', config = function() require('mrv.plugins.compe') end} -- Auto completion plugin for nvim that written in Lua
  use {'lewis6991/gitsigns.nvim', config = function() require('mrv.plugins.gitsigns') end} -- Super fast git decorations implemented purely in lua/teal.
  use {'voldikss/vim-floaterm', config = function() require('mrv.plugins.floaterm') end,} -- Use (neo)vim terminal in the floating/popup window
  use {'junegunn/vim-slash', config = function() require('mrv.plugins.slash') end,} -- Automatically clears search highlight when cursor is moved
  use {'toranb/tmux-navigator', config = function() require('mrv.plugins.tmux-navigator') end,} -- Navigate seamlessly between vim and tmux splits using a set of hotkeys
  use {'tpope/vim-fugitive', config = function() require('mrv.plugins.fugitive') end,} -- A Git wrapper so awesome, it should be illegal
  use {'tpope/vim-commentary', config = function() require('mrv.plugins.commentary') end,} -- Comment stuff out
  use {'raimondi/delimitmate', config = function() require('mrv.plugins.delimitmate') end,} -- Provides insert mode auto-completion for quotes, parens, brackets, etc.
  use {'kyazdani42/nvim-web-devicons',} -- Lua `fork` of vim-web-devicons for neovim
  use {'romgrk/barbar.nvim', config = function() require('mrv.plugins.barbar') end,} -- A neovim tabline plugin
  use {'wellle/targets.vim', config = function() require('mrv.plugins.targets') end,} -- Vim plugin that provides additional text objects
  use {'yegappan/mru', config = function() require('mrv.plugins.mru') end,} -- Most Recently Used (MRU) Vim Plugin
  use {'mroavi/lf.vim', config = function() require('mrv.plugins.lf') end,} -- File manager for vim/neovim powered by nnn
  use { 'AckslD/nvim-whichkey-setup.lua', config = function() require('mrv.plugins.which-key') end, requires = {'liuchengxu/vim-which-key'}, }
  use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end, ft = {'markdown'} } -- Preview markdown on your browser with synchronised scrolling
  use {'mroavi/vim-tomux', config = function() vim.cmd("exe 'source /home/mroavi/.config/nvim/lua/mrv/plugins/tomux.vim'") end,} -- Send text to tmux
end)

