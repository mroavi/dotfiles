local vim = vim
local M = {}

local apply_options = function(opts, endpoint)
  for k, v in pairs(opts) do
    endpoint[k] = v
  end
end

local globals = {
	mapleader = ' ',
}

local options = {
	shada = "<10,'99,/20,:99,h,f1",
	number = true,
	relativenumber = true,
	swapfile = false,
	wrap = true,
	linebreak = true,
	list = false,
	hidden = true,
	formatoptions = 'tcqj',
	splitbelow = true,
	splitright = true,
	signcolumn = 'number',
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	shiftround = true,
	smartindent = true,
	updatetime = 100,
	inccommand = 'split',
	listchars = "tab:»\\ ,space:_,trail:·,eol:¬",
	scrolloff = 5,
	completeopt = 'menuone,noselect',
	clipboard = 'unnamedplus',
	termguicolors = true,
	background = 'dark',
}

M.setup = function()
	apply_options(globals, vim.g)
  apply_options(options, vim.o)

  vim.cmd [[ colorscheme marlin ]]

end

return M

