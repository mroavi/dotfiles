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
		use {'wbthomason/packer.nvim', config = function() require('mrv.plugins.packer') end} -- packer can manage itself
		use {'~/repos/marlin.vim/', config = function() vim.cmd [[ colorscheme marlin ]] end} -- my dark color scheme (load before gitsigns)
		use {'nvim-lua/plenary.nvim'} -- all the lua functions you don't want to write twice (I use it to reload the nvim configuration)
		use {'b3nj5m1n/kommentary', config = function() require('mrv.plugins.kommentary') end} -- Neovim commenting plugin, written in lua
		use {'mroavi/lf.vim', config = function() require('mrv.plugins.lf') end} -- file manager for vim/neovim powered by nnn
		use {'nvim-lua/popup.nvim'} -- [WIP] an implementation of the Popup API from vim in Neovim
		use {'nvim-telescope/telescope.nvim', config = function() require('mrv.plugins.telescope') end} -- find, Filter, Preview, Pick. All lua, all the time
		use {'toranb/tmux-navigator', config = function() require('mrv.plugins.tmux-navigator') end} -- navigate seamlessly between vim and tmux splits using a set of hotkeys
		use {'lewis6991/gitsigns.nvim', config = function() require('mrv.plugins.gitsigns') end} -- super fast git decorations implemented purely in lua/teal
		use {'hrsh7th/nvim-compe', config = function() require('mrv.plugins.compe') end} -- auto completion plugin for nvim that written in Lua
		use {'jose-elias-alvarez/buftabline.nvim', config = function() require('mrv.plugins.buftabline') end} -- a well-integrated, low-configuration buffer list that lives in the tabline
		use {'voldikss/vim-floaterm', config = function() require('mrv.plugins.floaterm') end} -- use (neo)vim terminal in the floating/popup window
		use {'tpope/vim-fugitive', config = function() require('mrv.plugins.fugitive') end} -- a Git wrapper so awesome, it should be illegal
		use {'tpope/vim-unimpaired'} -- pairs of handy bracket mappings
		use {'tpope/vim-surround'} -- provides mappings to easily delete, change and add such surroundings in pairs
		use {'tpope/vim-repeat'} -- enable repeating supported plugin maps with "."
		use {'junegunn/vim-slash', config = function() require('mrv.plugins.slash') end} -- automatically clears search highlight when cursor is moved
		use {'sickill/vim-pasta'} -- auto format pasted code
		use {'wellle/targets.vim', config = function() require('mrv.plugins.targets') end} -- vim plugin that provides additional text objects
		use {'yegappan/mru', config = function() require('mrv.plugins.mru') end} -- most recently used (MRU) vim plugin
		use {'windwp/nvim-autopairs', config = function() require('mrv.plugins.autopairs') end}
		use {'hrsh7th/vim-vsnip'} -- vSCode(LSP)'s snippet feature in vim
		use {'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end} -- quickstart configurations for the Nvim LSP client
		use {'kyazdani42/nvim-web-devicons'} -- lua `fork` of vim-web-devicons for neovim
		use {'plasticboy/vim-markdown'} -- syntax highlighting, matching rules and mappings for Markdown and extensions
		use {'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end, ft = {'markdown'}} -- preview markdown on your browser with synchronised scrolling
		use {'~/repos/vim-tomux', config = function() vim.cmd("exe 'source /home/mroavi/.config/nvim/lua/mrv/plugins/tomux.vim'") end} -- send text to tmux
		use {"folke/lua-dev.nvim"} -- dev setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API
		use {'JuliaEditorSupport/julia-vim'} -- vim support for Julia
		-- use {'junegunn/vim-easy-align', config = function() require('mrv.plugins.easy-align') end}
		-- use {'AckslD/nvim-whichkey-setup.lua', config = function() require('mrv.plugins.which-key') end, requires = {'liuchengxu/vim-which-key'}}
		-- use {'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end} -- the fastest Neovim colorizer.
		-- use {'Shatur/neovim-ayu', config = function() require('mrv.plugins.ayu') end} -- Ayu theme for Neovim
		-- use {'edkolev/tmuxline.vim', config = function() require('mrv.plugins.tmuxline') end} -- simple tmux statusline generator with support for powerline symbols

		-- TODO TRY THESE OUT!!!
		-- use {'famiu/nvim-reload'} -- plugin to easily reload your Neovim config
		-- use {'kassio/neoterm'} -- wrapper of some vim/neovim's :terminal functions
		-- use {'sindrets/diffview.nvim'} -- single tabpage interface for easily cycling through diffs for all modified files for any git rev
		-- use {"ray-x/lsp_signature.nvim"} -- lsp signature hint when you type

		-- use {'raimondi/delimitmate', config = function() require('mrv.plugins.delimitmate') end} -- provides insert mode auto-completion for quotes, parens, brackets, etc.
		-- use {'ap/vim-buftabline', config = function() require('mrv.plugins.vim-buftabline') end} -- a well-integrated, low-configuration buffer list that lives in the tabline
		-- use {'romgrk/barbar.nvim', config = function() require('mrv.plugins.barbar') end} -- a neovim tabline plugin
		-- use {'tpope/vim-commentary'} -- comment stuff out
	end)
end

return M

