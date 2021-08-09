local vim = vim
local utils = require('mrv.utils')
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
  number = false,
  relativenumber = false,
  swapfile = false,
  wrap = true,
  linebreak = true,
  list = false,
  hidden = true,
  formatoptions = 'tcqj',
  splitbelow = true,
  splitright = true,
  signcolumn = 'yes',
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  shiftround = true,
  expandtab = true,
  smartindent = true,
  updatetime = 100,
  inccommand = 'split',
  listchars = "tab:»\\ ,space:_,trail:·,eol:¬",
  scrolloff = 5,
  completeopt = 'menuone,noselect',
  clipboard = 'unnamedplus',
  termguicolors = true,
  background = 'dark',
  wildignorecase = true,
}

M.setup = function()

  apply_options(globals, vim.g)
  apply_options(options, vim.o)

  if vim.env.SSH_CONNECTION then
    vim.o.clipboard = ''
  end

  -- Make Ctrl-u and Ctrl-d scroll 1/3 of the window height
  -- https://neovim.discourse.group/t/how-to-make-ctrl-d-and-ctrl-u-scroll-1-3-of-window-height/859
  utils.remap("n", "<C-d>", "(winheight(0) / 3) . '<C-d>'", {noremap = true, expr = true})
  utils.remap("n", "<C-u>", "(winheight(0) / 3) . '<C-u>'", {noremap = true, expr = true})

end

return M

