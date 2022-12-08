vim.g.asyncrun_open = 10 -- open quickfix window at given height after command starts

-- TODO: use ripgrep instead of grep and factor out the command options

-- Borrowed tricks from: https://learnvimscriptthehardway.stevelosh.com/chapters/32.html
--vim.keymap.set("n", "<Leader>*", [[:exe "AsyncRun! -strip grep -R -n " . shellescape(expand("<cword>")) . " ."<Cr>]], { silent = false }) -- equivalent to the line below
vim.keymap.set("n", "<Leader>*", "':AsyncRun! -strip grep -R -n -F ' . shellescape(expand('<cword>')) . ' .<Cr>'", { silent = false, expr = true })

-- Passes the `-F` flag which makes grep interpret text as fixed strings, not regular expressions
local function visual_star_grep()
  local visual_selection = require('mrv.utils').get_visual_selection()
  vim.cmd("AsyncRun! -strip grep -R -n -F " .. vim.fn.shellescape(visual_selection) .. " .")
end
vim.keymap.set('x', '<Leader>*', function() visual_star_grep() end)
