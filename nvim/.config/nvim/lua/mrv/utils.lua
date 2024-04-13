M = {}

-- Source: https://stackoverflow.com/a/70730552/1706778
M.preserve = function(arguments)
  local args = string.format("keepjumps keeppatterns exe %q", arguments)
  -- local original_cursor = vim.fn.winsaveview()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(args)
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

-- Inserts a debug statement below the curosor line using the content of the search register
function M.insert_string(str, insert_text_cmd)
  local search_reg = vim.fn.getreg('/')
  -- If present, remove \< and \> from the beginning and end of the string
  local search_reg_clean, num_subs = string.gsub(search_reg, "^\\<(.*)\\>$", "%1")
  -- Did the substitution fail?
  if num_subs == 0 then -- https://stackoverflow.com/a/3463550/1706778
    -- Yes, then remove \V from the beginning of the string
    search_reg_clean, num_subs = string.gsub(search_reg, "^\\V(.*)", "%1")
  end
  --vim.print(str) -- DEBUG
  --vim.print(string.format(str, search_reg_clean, search_reg_clean)) -- DEBUG
  vim.cmd([[exe "norm! m`]] .. insert_text_cmd .. string.format(str, search_reg_clean, search_reg_clean) .. [[\<Esc>``"]])
end

-- Toggle quickfix window (https://stackoverflow.com/a/63162084/1706778)
function M.toggle_quickfix_window()
  local quickfixwin = vim.tbl_filter(function(val) return val.quickfix == 1 end, vim.fn.getwininfo())
  if next(quickfixwin) == nil then vim.cmd("copen") else vim.cmd("cclose") end
end

-- Insert a heading made of a given character
function M.insert_heading(heading_character)
  -- Save cursor's position
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- Get the comment string for the current buffer
  local comment_template = vim.api.nvim_buf_get_option(0, 'commentstring')
  -- Calculate the number of characters remaining in the line
  local available_cols = 80 - vim.fn.col('.')
  -- Generate the heading line using the given character
  local generated_heading = string.rep(heading_character, available_cols)
  -- Fill in the comment template with the generated heading
  local formatted_comment = string.format(comment_template, generated_heading)
  -- Insert the heading above the current line
  vim.cmd [[norm O]]
  vim.cmd(string.format(":execute 'norm! a%s'", formatted_comment))
  -- Insert the heading below the current line
  vim.cmd [[norm jo]]
  vim.cmd(string.format(":execute 'norm! a%s'", formatted_comment))
  -- Restore cursor's position
  vim.api.nvim_win_set_cursor(0, { line, col })
end

return M
