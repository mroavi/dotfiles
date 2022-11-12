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

-- Define a new operator
function M.operator(wait_for_motion, opfunc, operate)
  if wait_for_motion == true then
    vim.g.cursor_pos_save = vim.fn.winsaveview()
    vim.opt.opfunc = opfunc
    return 'g@'
  end
  -- Save state
  local selection_opt_save = vim.api.nvim_get_option('selection')
  local unnamed_reg_save = vim.fn.getreginfo('"')
  local clipboard_opt_save = vim.api.nvim_get_option('clipboard')
  local visual_marks_save = { vim.fn.getpos("'<"), vim.fn.getpos("'>") }
  --
  vim.api.nvim_set_option('selection', 'inclusive')
  vim.api.nvim_set_option('clipboard', '')
  operate()
  -- Restore state
  vim.fn.setpos("'<", visual_marks_save[1])
  vim.fn.setpos("'>", visual_marks_save[2])
  vim.fn.setreg('"', unnamed_reg_save)
  vim.api.nvim_set_option('selection', selection_opt_save)
  vim.api.nvim_set_option('clipboard', clipboard_opt_save)
  vim.fn.winrestview(vim.g.cursor_pos_save)
end
function M.new_operator(lhs, opfunc)
  vim.keymap.set('x', lhs, string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })
  vim.keymap.set('n', lhs, string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })
  vim.keymap.set('n', lhs .. lhs, string.format("v:lua.require('mrv.utils').operator(v:true, '%s') . '_'", opfunc), { expr = true })
end

-- Adds/Removes the passed string to the start/end of the cursor line
function M.toggle_string(str, insert_text_cmd)
  local current_line = vim.api.nvim_get_current_line()
  if not string.find(current_line, str) then
    vim.cmd([[exe "normal! m`]] .. insert_text_cmd .. str .. [[\<Esc>``"]])
  else
    vim.api.nvim_set_current_line((current_line:gsub(str, "")))
  end
end

-- Toggle quickfix window (https://stackoverflow.com/a/63162084/1706778)
function M.toggle_quickfix_window()
  local quickfixwin = vim.tbl_filter(function(val) return val.quickfix == 1 end, vim.fn.getwininfo())
  if next(quickfixwin) == nil then vim.cmd("copen") else vim.cmd("cclose") end
end

return M
