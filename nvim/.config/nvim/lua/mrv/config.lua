local vim = vim
local M = {}

M.setup = function()

  --------------------------------------------------------------------------------
  -- Options
  --------------------------------------------------------------------------------

  vim.g.mapleader = ' '

  vim.o.shada = "<10,'99,/99,:99,h,f1" -- :help sd
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.swapfile = false
  vim.o.wrap = true
  vim.o.linebreak = true
  vim.o.list = false
  vim.o.hidden = true
  vim.o.formatoptions = 'tcqj'
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.signcolumn = 'yes:1'
  vim.o.tabstop = 2
  vim.o.softtabstop = 2
  vim.o.shiftwidth = 2
  vim.o.shiftround = true
  vim.o.expandtab = true
  vim.o.smartindent = true
  vim.o.updatetime = 100
  vim.o.inccommand = 'split'
  vim.o.listchars = "tab:»\\ ,space:_,trail:·,eol:¬"
  vim.o.scrolloff = 5
  vim.o.completeopt = 'menuone,noselect'
  vim.o.clipboard = 'unnamedplus'
  vim.o.termguicolors = true
  vim.o.background = 'dark'
  vim.o.wildignorecase = true

  if vim.env.SSH_CONNECTION then
    vim.o.clipboard = ''
  end

  --------------------------------------------------------------------------------
  -- Mappings
  --------------------------------------------------------------------------------

  vim.keymap.set("n", "<Leader>w", ":update<CR>") -- write to disk
  vim.keymap.set("n", "<Leader>z", "<C-z><CR>") -- suspend vim (resume with `fg`)
  vim.keymap.set("n", "<Leader>x", ":close<CR>") -- close the current window
  vim.keymap.set("n", "<Leader>l", ":b#<CR>", { silent = true }) -- edit the alternate file
  vim.keymap.set("n", "<Leader>;", "<C-w>p", { silent = true }) -- go to the last accessed window
  vim.keymap.set("n", "<Leader>j", "<C-w>w", { silent = true }) -- go to the next window
  vim.keymap.set("n", "<Leader>k", "<C-w>W", { silent = true }) -- go to the prev window
  vim.keymap.set("n", "<Leader>cd", ":cd %:p:h<CR>:pwd<CR>") -- change to the dir of the current buffer
  vim.keymap.set("n", "<Leader>J", ":split<CR>") -- create a horizontal split
  vim.keymap.set("n", "<Leader><CR>", ":vsplit<CR>") -- create a vertical split
  vim.keymap.set("n", "<ESC>", ":noh<CR><ESC>", { silent = true }) -- clear highlight
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

  --------------------------------------------------------------------------------
  -- Misc
  --------------------------------------------------------------------------------

  -- Make Ctrl-u and Ctrl-d scroll 1/3 of the window height
  -- https://neovim.discourse.group/t/how-to-make-ctrl-d-and-ctrl-u-scroll-1-3-of-window-height/859
  vim.keymap.set("n", "<C-d>", "(winheight(0) / 3) . '<C-d>'", { expr = true })
  vim.keymap.set("n", "<C-u>", "(winheight(0) / 3) . '<C-u>'", { expr = true })

  -- Highlight yanked text
  local group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
  local callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 } end
  vim.api.nvim_create_autocmd("TextYankPost", { callback = callback , group = group })

end

return M
