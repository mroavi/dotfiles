local vim = vim
local my_utils = require 'mrv.utils'
local M = {}

M.setup = function()

  --------------------------------------------------------------------------------
  --- Options
  --------------------------------------------------------------------------------

  vim.g.mapleader = ' '
  --vim.g.markdown_fenced_languages = {'html', 'python', 'bash=sh', 'cs'}

  vim.opt.shada = { '<10', "'99", '/99', ':99', 'h', 'f1' } -- :help sd
  vim.opt.number = false
  vim.opt.relativenumber = false
  vim.opt.swapfile = false
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = false
  vim.opt.hidden = true
  vim.opt.formatoptions = 'tcqj'
  vim.opt.splitbelow = true
  vim.opt.splitright = true
  vim.opt.signcolumn = 'yes:1'
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.shiftround = true
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.updatetime = 100
  vim.opt.inccommand = 'split'
  vim.opt.listchars = { tab = "»\\ ", space = "_", trail = "·", eol = "¬" }
  vim.opt.scrolloff = 5
  vim.opt.completeopt = { 'menuone', 'noselect' }
  vim.opt.clipboard = 'unnamedplus' -- to be replaced with OSC 52 (https://github.com/neovim/neovim/commit/748bc4d22d35b40f0795015e5d93113b526adf22)
  vim.opt.termguicolors = true
  vim.opt.background = 'dark'
  vim.opt.wildignorecase = true
  vim.opt.cmdheight = 1 -- `0` hides the command-line when not being used
  vim.opt.wildignore:append { 'build/**' }
  vim.opt.diffopt:append { 'linematch:60' } -- improve diff mode
  vim.opt.winborder = "rounded" -- an option to control the default border of all floating windows

  --------------------------------------------------------------------------------
  --- Mappings
  --------------------------------------------------------------------------------

  vim.keymap.set("n", "<Leader>w", ":update<CR>") -- write to disk
  vim.keymap.set("n", "<Leader>l", ":b#<CR>", { silent = true }) -- edit the alternate file
  vim.keymap.set("n", "<Leader>cd", ":cd %:p:h<CR>:pwd<CR>") -- change to the dir of the current buffer
  vim.keymap.set("n", "<Leader>su", [[:%s//<C-r>=substitute(@/, '\\<\|\\>\|\\V', '', 'g')<CR>/g<Left><Left>]]) -- substitute all occurrences of the content of the search register with new text
  vim.keymap.set("x", "<Leader>su", [[:s//<C-r>=substitute(@/, '\\<\|\\>\|\\V', '', 'g')<CR>/g<Left><Left>]]) -- https://stackoverflow.com/a/66440706/1706778
  vim.keymap.set("n", "<Leader>gr", ":vimgrep //gj **/*<left><left><left><left><left><left><left><left>") -- grep recursively in current directory and send results to quickfix list
  vim.keymap.set("n", "<Leader>S", ":cfdo %s/<C-r>///gc<left><left><left>") -- replace the last searched pattern (from the `/` register) with the provided text in each file in the quickfix list
  vim.keymap.set("n", "<F6>", "':setlocal spelllang=' . (&spelllang == 'en' ? 'es' : 'en') . '<CR>'", { expr = true }) -- toggle spelling language
  vim.keymap.set("n", "gp", "'`[' . getregtype()[0] . '`]'", { expr = true }) -- select pasted text
  vim.keymap.set("n", "<C-s>", ":call search('\\w\\>', 'c')<CR>a<C-X><C-S><C-N>") -- spelling completion in normal mode (https://stackoverflow.com/a/25777332/1706778)
  vim.keymap.set("n", "k", "(v:count > 1 ? \"m'\" . v:count : '') . 'k'", { expr = true }) -- add line movements preceded by a count greater than 1 to the jump list
  vim.keymap.set("n", "j", "(v:count > 1 ? \"m'\" . v:count : '') . 'j'", { expr = true }) -- add line movements preceded by a count greater than 1 to the jump list
  vim.keymap.set("n", "<C-d>", "(winheight(0) / 3) . '<C-d>'", { expr = true }) -- make Ctrl-u and Ctrl-d scroll 1/3 of the window height
  vim.keymap.set("n", "<C-u>", "(winheight(0) / 3) . '<C-u>'", { expr = true }) -- https://neovim.discourse.group/t/how-to-make-ctrl-d-and-ctrl-u-scroll-1-3-of-window-height/859
  vim.keymap.set('n', '<M-j>', function() my_utils.go_to_next_delim(vim.b.cell_delimeter) end) -- jump to the next cell delimeter
  vim.keymap.set('n', '<M-k>', function() my_utils.go_to_prev_delim(vim.b.cell_delimeter) end) -- jump to the prev cell delimeter
  vim.keymap.set("n", "<C-w>j", "<C-w>w", { silent = true }) -- go to the next window
  vim.keymap.set("n", "<C-w>k", "<C-w>W", { silent = true }) -- go to the prev window
  vim.keymap.set("n", "<Leader>id", ":r!date '+\\%F'<CR>") -- insert current date
  vim.keymap.set("i", "<C-g>d", function() local date = os.date("%F") vim.api.nvim_put({ date }, "", false, true) end, { noremap = true, silent = true }) -- insert current data in insert mode
  vim.keymap.set("i", "<C-g>n", function() vim.api.nvim_put({ vim.fn.expand("%:t") }, "", false, true) end, { noremap = true, silent = true })  -- insert current buffer name in insert mode
  for i=1,9 do vim.keymap.set("n", "<Leader>" .. i, function() vim.cmd('argu!' .. i) end) end -- edit ith entry in the argument list 
  vim.keymap.set('n', '<Leader>ifn', my_utils.add_filename_to_top)
  --vim.keymap.set("n", "<ESC>", ":noh<CR><ESC>", { silent = true }) -- clear highlight
  --vim.keymap.set("n", "*", [[:let @/ = '\<'.expand('<cword>').'\>' | :set hlsearch | norm wb<Cr>]], { silent = true, noremap = false}) -- make star `*` command stay on current word
  --vim.keymap.set("n", "<Leader>J", ":split<CR>") -- create a horizontal split
  --vim.keymap.set("n", "<Leader><CR>", ":vsplit<CR>") -- create a vertical split
  --vim.keymap.set("n", "<Leader>x", ":close<CR>") -- close the current window
  --vim.keymap.set("n", "<Leader>q", function() my_utils.toggle_quickfix_window() end) -- toggle quickfist window
  --vim.keymap.set("n", "<Leader>z", "<C-z>") -- suspend vim (resume with `fg`)

  ---- Debug-related mappings for vim and lua filetypes
  --vim.api.nvim_create_autocmd("FileType", {
  --  pattern = { "lua", "vim" },
  --  callback = function()
  --    vim.keymap.set("n", '<Leader>m', '<Cmd>messages<CR>')
  --    vim.keymap.set("n", "<Leader>cl", ":messages clear<CR>")
  --  end,
  --  group = vim.api.nvim_create_augroup("lua_vim_debug", { clear = true }),
  --})

  --------------------------------------------------------------------------------
  --- Misc
  --------------------------------------------------------------------------------

  -- Highlight yanked text
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 } end,
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  })

  -- Automatically open quickfix window after running vimgrep
  local quickfix_group = vim.api.nvim_create_augroup("quickfix", { clear = true })
  vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = "vimgrep", command = "cwindow", group = quickfix_group })
  vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = "lvimgrep", command = "lwindow", group = quickfix_group })

  ---- Close vim if the only window left open is a quickfix window
  ---- https://stackoverflow.com/a/7477056/1706778
  --vim.api.nvim_create_autocmd("WinEnter", {
  --  callback = function()
  --    if vim.fn.winnr('$') == 1 and vim.o.buftype == "quickfix" then
  --      vim.cmd('quit')
  --    end
  --  end,
  --  group = vim.api.nvim_create_augroup("quickfix-close", { clear = true }),
  --})

  -- Use ripgrep as grep program 
  -- https://phelipetls.github.io/posts/extending-vim-with-ripgrep/
  if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
    vim.o.grepformat = "%f:%l:%c:%m"
  end

  -- Prevent 'Press ENTER or ...' prompt after executing grep
  -- https://vi.stackexchange.com/a/21010/27039
  vim.api.nvim_create_user_command(
    "Grep",
    "exe 'silent grep! <args>' | redraw! | cwindow",
    { bang = true, nargs = "+", complete = "file" }
  )

  -- Remember cursor position (:h restore-cursor)
  -- https://github.com/neovim/neovim/issues/16339
  vim.cmd([[
  autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
  ]])

  -- Disable highlighting matching parenthesis in insert mode
  -- https://stackoverflow.com/q/43060468/1706778
  local match_paren_group = vim.api.nvim_create_augroup("quickfix", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = "NoMatchParen", group = match_paren_group })
  vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "DoMatchParen", group = match_paren_group })

  --------------------------------------------------------------------------------
  --- Operators
  --------------------------------------------------------------------------------

  -- Source motion/textobject of code (only for lua and vim filetypes)
  function M.source_opfunc(motion_type)
    return my_utils.operator(false, nil, function()
      -- Yank the text covered by the motion/textobject
      local select_commands = { line = "'[V']", char = "`[v`]", block = "`[;<c-v>`]" }
      vim.cmd("silent keepjumps normal! " .. select_commands[motion_type] .. 'y')
      -- Get the start and end rows of the covered motion/textobject
      local buf_sel_start = vim.api.nvim_buf_get_mark(0, '<')[1]
      local buf_sel_end = vim.api.nvim_buf_get_mark(0, '>')[1]
      -- Concat the range of the covered rows with "source" and set it to the unnamed reg
      vim.fn.setreg('"', buf_sel_start .. "," .. buf_sel_end .. "source")
      -- Execute the content of the unnamed register
      vim.cmd('@"')
    end
    )
  end
  vim.cmd [[
    function! __source_opfunc(motion_type) abort
      return v:lua.require('mrv.config').source_opfunc(a:motion_type)
    endfunction
  ]]
  -- Currently, opfunc needs to be set to a lua func (https://github.com/neovim/neovim/issues/17503)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "vim" },
    callback = function() my_utils.new_operator('s', "__source_opfunc") end,
    group = vim.api.nvim_create_augroup("lua_vim_source", { clear = true })
  })

  --------------------------------------------------------------------------------
  --- Text-objects
  --------------------------------------------------------------------------------

  -- Document text-object
  for _, mode in ipairs({ 'x', 'o' }) do
    vim.keymap.set(mode, 'id', ':<C-u>normal! ggVG<CR>', { silent = true })
  end

  -- Cell text-object
  function M.cell_text_object(text_object_type)
    local cell_delimeter = vim.b.cell_delimeter
    -- Do nothing if `cell_delimeter` is not defined
    if not cell_delimeter then return end
    -- Move cursor to the previous cell delimiter if found, otherwise, to top-left of buffer
    if vim.fn.search(cell_delimeter, "bcW") == 0 then vim.cmd [[silent exe "normal! gg0"]] end
    -- Regex that captures lines that are not empty and that do not start with the comment char
    local valid_statement_regex = [[^\(\s*]] .. string.sub(cell_delimeter, 1, 1) .. [[\)\@!\s*\S\+]]
    -- Did we receive 'i' as argument (inner cell)?
    if text_object_type == 'i' then
      -- Yes, then jump to next valid statement (skips empty lines and those starting with comment char)
      vim.fn.search(valid_statement_regex, "cW")
    end
    -- Start visual line mode
    vim.cmd.norm[[V]]
    -- Move cursor to the next cell delimiter if found, otherwise, to bottom of buffer
    if vim.fn.search(cell_delimeter, "W") == 0 then vim.cmd([[exe "normal! G"]]) end
    -- Did we receive 'i' as argument (inner cell)?
    if text_object_type == 'i' then
      -- Yes, then jump to prev valid statement (skips empty lines and those starting with comment char)
      vim.fn.search(valid_statement_regex, "cbW")
    end
  end
  for _, type in ipairs({ 'i', 'a' }) do
    for _, mode in ipairs({ 'o', 'x' }) do
      vim.keymap.set(mode, type .. 'c', ":<C-u>lua require('mrv.config').cell_text_object('" .. type .. "')<Cr>", { silent = true })
    end
  end

end

return M
