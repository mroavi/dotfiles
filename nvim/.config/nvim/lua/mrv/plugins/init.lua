local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)

  use {'wbthomason/packer.nvim'} -- Packer can manage itself
  use {'tpope/vim-unimpaired'} -- Pairs of handy bracket mappings
  use {'tpope/vim-surround'} -- Provides mappings to easily delete, change and add such surroundings in pairs
  use {'tpope/vim-repeat'} -- Enable repeating supported plugin maps with "."
  use {'JuliaEditorSupport/julia-vim'} -- Vim support for Julia
  use {'sickill/vim-pasta'} -- Auto format pasted code
  use {'svermeulen/vimpeccable'} -- Easily write your .vimrc in lua or any lua based language
  use {'hrsh7th/vim-vsnip'} -- VSCode(LSP)'s snippet feature in vim

  -- Find, Filter, Preview, Pick. All lua, all the time
  use {'nvim-lua/popup.nvim'}
  use {'nvim-lua/plenary.nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
    config = function() require('mrv.plugins.telescope') end,
    after = 'vimpeccable',
  }

  use {'neovim/nvim-lspconfig', config = function() require('mrv.plugins.lspconfig') end} -- Quickstart configurations for the Nvim LSP client
  use {'hrsh7th/nvim-compe', config = function() require('mrv.plugins.compe') end} -- Auto completion plugin for nvim that written in Lua
  use {'lewis6991/gitsigns.nvim', config = function() require('mrv.plugins.gitsigns') end} -- Super fast git decorations implemented purely in lua/teal.

end)

