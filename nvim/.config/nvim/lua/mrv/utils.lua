M = {}

-- Source: https://stackoverflow.com/a/70730552/1706778
M.preserve = function(arguments)
  local arguments = string.format("keepjumps keeppatterns exe %q", arguments)
  -- local original_cursor = vim.fn.winsaveview()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(arguments)
  local lastline = vim.fn.line("$")
  -- vim.fn.winrestview(original_cursor)
  if line > lastline then
    line = lastline
  end
  vim.api.nvim_win_set_cursor({ 0 }, { line, col })
end

-- Source: https://github.com/nvim-telescope/telescope.nvim/issues/1923
M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

-- Go to next delimeter
function M.go_to_next_delim(delim)
  if vim.fn.search(delim, "W") == 0 then vim.cmd('normal! G0') end
end

-- Go to previous delimeter
function M.go_to_prev_delim(delim)
  if vim.fn.search(delim, "bW") == 0 then vim.cmd('normal! gg0') end
end

return M
