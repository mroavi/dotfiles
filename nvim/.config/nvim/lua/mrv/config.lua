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
  shada = "<10,'99,/99,:99,h,f1", -- :help sd
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
  signcolumn = 'yes:1',
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
  vim.keymap.set("n", "<C-d>", "(winheight(0) / 3) . '<C-d>'", { expr = true })
  vim.keymap.set("n", "<C-u>", "(winheight(0) / 3) . '<C-u>'", { expr = true })

  -- Highlight yanked text
  local group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
  local callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 } end
  vim.api.nvim_create_autocmd("TextYankPost", { callback = callback , group = group })

  --------------------------------------------------------------------------------
  -- Mappings
  --------------------------------------------------------------------------------

  vim.keymap.set("n", "<Leader>w", ":update<CR>") -- write to disk
  vim.keymap.set("n", "<Leader>z", "<C-z><CR>") -- suspend vim
  vim.keymap.set("n", "<Leader>x", ":close<CR>") -- close the current window
  vim.keymap.set("n", "<Leader>l", ":b#<CR>", { silent = true }) -- edit the alternate file
  vim.keymap.set("n", "<Leader>;", "<C-w>p", { silent = true }) -- go to the last accessed window
  vim.keymap.set("n", "<Leader>j", "<C-w>w", { silent = true }) -- go to the next window
  vim.keymap.set("n", "<Leader>k", "<C-w>W", { silent = true }) -- go to the prev window
  vim.keymap.set("n", "<Leader>J", ":split<CR>") -- create a horizontal split
  vim.keymap.set("n", "<Leader><CR>", ":vsplit<CR>") -- create a vertical split
  vim.keymap.set("n", "<ESC>", ":noh<CR><ESC>", { silent = true }) -- clear highlight
  vim.keymap.set("n", "<Leader>cd", ":cd %:p:h<CR>:pwd<CR>") -- change to the dir of the current buffer
  vim.keymap.set("n", "<C-M-Down>", ":resize -3<CR>") -- resize split horizontally
  vim.keymap.set("n", "<C-M-Up>", ":resize +3<CR>") -- resize split horizontally
  vim.keymap.set("n", "<C-M-Left>", ":vertical resize -3<CR>") -- resize split vertically
  vim.keymap.set("n", "<C-M-Right>", ":vertical resize +3<CR>") -- resize split vertically
  vim.keymap.set("n", "<F6>", "':setlocal spelllang=' . (&spelllang == 'en' ? 'es' : 'en') . '<CR>'", { expr = true }) -- toggle spelling language
  vim.keymap.set("n", "gp", "'`[' . getregtype()[0] . '`]'", { expr = true }) -- select pasted text
  vim.keymap.set("n", "<C-s>", ":call search('\\w\\>', 'c')<CR>a<C-X><C-S>") -- spelling completion in normal mode (https://stackoverflow.com/a/25777332/1706778)
  vim.keymap.set("n", "k", "(v:count > 1 ? \"m'\" . v:count : '') . 'k'", { expr = true }) -- add line movements preceded by a count greater than 1 to the jump list
  vim.keymap.set("n", "j", "(v:count > 1 ? \"m'\" . v:count : '') . 'j'", { expr = true }) -- add line movements preceded by a count greater than 1 to the jump list
  vim.keymap.set("c", "/", "wildmenumode() ? \"\\<C-y>\" : \"/\"", { expr = true }) -- avoid a double slash when pressing / when using wildmenu (like in zsh)

end

return M
