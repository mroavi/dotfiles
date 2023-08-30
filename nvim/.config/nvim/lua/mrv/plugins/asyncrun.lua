vim.g.asyncrun_open = 10 -- open quickfix window at given height after command starts

local ripgrep_cmd = "rg --vimgrep --smart-case --hidden --line-number --fixed-strings "

---- Borrowed tricks from: https://learnvimscriptthehardway.stevelosh.com/chapters/32.html
local function star_grep(rg_cmd)
  local word_under_cursor = vim.fn.expand('<cword>')
  vim.cmd("AsyncRun! -strip " .. rg_cmd .. vim.fn.shellescape(word_under_cursor) .. " .")
end
vim.keymap.set('n', '<Leader>*', function() star_grep(ripgrep_cmd) end)

local function visual_star_grep(rg_cmd)
  local visual_selection = require('mrv.utils').get_visual_selection()
  vim.cmd("AsyncRun! -strip " .. rg_cmd .. vim.fn.shellescape(visual_selection) .. " .")
end
vim.keymap.set('x', '<Leader>*', function() visual_star_grep(ripgrep_cmd) end)

---- Old
--vim.keymap.set("n", "<Leader>*", [[:exe "AsyncRun! -strip grep -R -n " . shellescape(expand("<cword>")) . " ."<Cr>]], { silent = false }) -- equivalent to the line below
--vim.keymap.set("n", "<Leader>*", "':AsyncRun! -strip rg --vimgrep --smart-case --hidden --line-number --fixed-strings ' . shellescape(expand('<cword>')) . ' .<Cr>'", { silent = false, expr = true })

-- Example of how I use this plugin to compile and open a pdf:
--    :AsyncRun -silent ./compile.sh; xdg-open ./paper.pdf
