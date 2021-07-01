local execute = vim.api.nvim_command
local fn = vim.fn
local M = {}
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

M.setup = function()

	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
		execute 'packadd packer.nvim'
	end

	require('packer').startup(function(use)
		use {'wbthomason/packer.nvim'} -- packer can manage itself
		use {'~/repos/marlin.vim/', config = function() vim.cmd [[ colorscheme marlin ]] end} -- My dark color scheme
		use {'cormacrelf/vim-colors-github'} -- my light color scheme
		use {'tpope/vim-unimpaired'} -- pairs of handy bracket mappings
		use {'tpope/vim-surround'} -- provides mappings to easily delete, change and add such surroundings in pairs
		use {'tpope/vim-repeat'} -- enable repeating supported plugin maps with "."
		use {'JuliaEditorSupport/julia-vim'} -- vim support for Julia
		use {'sickill/vim-pasta'} -- auto format pasted code
		use {'plasticboy/vim-markdown'} -- syntax highlighting, matching rules and mappings for Markdown and extensions
		use {'hrsh7th/vim-vsnip'} -- vSCode(LSP)'s snippet feature in vim
		use {'nvim-lua/popup.nvim'} -- [WIP] An implementation of the Popup API from vim in Neovim
		use {'nvim-lua/plenary.nvim'} -- all the lua functions I don't want to write twice
		use {"folke/lua-dev.nvim"} -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
		use {'nvim-telescope/telescope.nvim', config = function() require('mrv.plugins.telescope') end} -- find, Filter, Preview, Pick. All lua, all the time
		use {'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end} -- quickstart configurations for the Nvim LSP client
		use {'hrsh7th/nvim-compe', config = function() require('mrv.plugins.compe') end} -- auto completion plugin for nvim that written in Lua
		use {'lewis6991/gitsigns.nvim', config = function() require('mrv.plugins.gitsigns') end} -- super fast git decorations implemented purely in lua/teal
		use {'voldikss/vim-floaterm', config = function() require('mrv.plugins.floaterm') end} -- use (neo)vim terminal in the floating/popup window
		use {'junegunn/vim-slash', config = function() require('mrv.plugins.slash') end} -- automatically clears search highlight when cursor is moved
		use {'toranb/tmux-navigator', config = function() require('mrv.plugins.tmux-navigator') end} -- navigate seamlessly between vim and tmux splits using a set of hotkeys
		use {'tpope/vim-fugitive', config = function() require('mrv.plugins.fugitive') end} -- a Git wrapper so awesome, it should be illegal
		use {'tpope/vim-commentary', config = function() require('mrv.plugins.commentary') end} -- comment stuff out
		use {'raimondi/delimitmate', config = function() require('mrv.plugins.delimitmate') end} -- provides insert mode auto-completion for quotes, parens, brackets, etc.
		use {'kyazdani42/nvim-web-devicons',} -- lua `fork` of vim-web-devicons for neovim
		use {'romgrk/barbar.nvim', config = function() require('mrv.plugins.barbar') end} -- a neovim tabline plugin
		use {'wellle/targets.vim', config = function() require('mrv.plugins.targets') end} -- vim plugin that provides additional text objects
		use {'yegappan/mru', config = function() require('mrv.plugins.mru') end} -- most Recently Used (MRU) Vim Plugin
		use {'mroavi/lf.vim', config = function() require('mrv.plugins.lf') end} -- file manager for vim/neovim powered by nnn
		use {'AckslD/nvim-whichkey-setup.lua', config = function() require('mrv.plugins.which-key') end, requires = {'liuchengxu/vim-which-key'}}
		use {'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end, ft = {'markdown'}} -- preview markdown on your browser with synchronised scrolling
		use {'mroavi/vim-tomux', config = function() vim.cmd("exe 'source /home/mroavi/.config/nvim/lua/mrv/plugins/tomux.vim'") end} -- send text to tmux
	end)
end

return M
