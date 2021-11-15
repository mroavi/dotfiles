local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values
local action_state = require "telescope.actions.state"

local M = {}

require("telescope").setup{
  defaults = {
    layout_config = {height = 0.9, width = 0.9},
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_to_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist,
        -- Custom actions
        ["<C-a>"] = function(_) -- add to arglist
            local selection_path = action_state.get_selected_entry()[1]
            vim.cmd('arga ' .. selection_path)
        end
      },
      n = {
        ["<esc>"] = actions.close
      },
    },
  }
}

---------------------------------------------------------------------------------
-- My themes
---------------------------------------------------------------------------------

function TmuxTheme(opts)
  opts = opts or {}
  local theme_opts = {
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    --scroll_strategy = "limit", -- buggy
    --path_display = {"tail"}, -- TODO: change to "smart" when merged: https://github.com/caojoshua/telescope.nvim/pull/1
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      --map('i', 'l', actions.file_edit)
      return true
    end,
    on_complete = {
      function(picker)
        local buf = vim.api.nvim_win_get_buf(picker.original_win_id)
        local selection_index
        local idx = 1
        for entry in picker.manager:iter() do
          if entry.bufnr == buf then
            selection_index = idx
            break
          end
          idx = idx + 1
        end
        local row = picker:get_row(selection_index)
        picker:set_selection(row)
        picker._completion_callbacks = {}
      end,
    },
  }
  return vim.tbl_deep_extend("force", theme_opts, opts)
end

---------------------------------------------------------------------------------
--- File Pickers
---------------------------------------------------------------------------------

function M.find_files()
  require("telescope.builtin").find_files{
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    cwd = vim.fn.expand("%:p:h"),
  }
end

function M.git_files()
  require("telescope.builtin").git_files{
    cwd = vim.fn.expand("%:p:h"),
  }
end

function M.dotfiles()
  require('telescope.builtin').find_files {
    find_command = {'fd', '--type', 'file', '--hidden', '--no-ignore', '--exclude', '.git',},
    prompt_title = "Dotfiles",
    cwd = "~/dotfiles",
  }
end

Args = function(opts)
  local results = vim.fn.argv()
  pickers.new(opts, {
    prompt_title = 'Argument List',
    finder = finders.new_table{
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

function M.args()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      --map('i', 'l', actions.file_edit)
      -- Custom actions
      map('i', 'x', function(prompt_bufnr) -- delete from arglist
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          current_picker:delete_selection( function(_)
            local selection_path = action_state.get_selected_entry()[1]
            vim.cmd('argd ' .. selection_path)
          end)
      end)
      return true
    end,
    on_complete = {
      function(picker)
        local selection_buf_nr = vim.api.nvim_win_get_buf(picker.original_win_id)
        local selection_path = vim.api.nvim_buf_get_name(selection_buf_nr)
        local selection_index
        local i = 1
        for entry in picker.manager:iter() do
          local entry_path = vim.fn.fnamemodify(entry[1], ":p")
          if entry_path == selection_path then
            selection_index = i
            break
          end
          i = i + 1
        end
        local row = picker:get_row(selection_index)
        picker:set_selection(row)
        picker._completion_callbacks = {}
      end,
    },
  }
  Args(opts)
end

---------------------------------------------------------------------------------
--- Vim Pickers
---------------------------------------------------------------------------------

function M.buffers()
  require("telescope.builtin").buffers(TmuxTheme())
end

function M.lines()
  local ivy_theme = require("telescope.themes").get_ivy({
    layout_config = {
      height = 40,
    },
  })
  require("telescope.builtin").current_buffer_fuzzy_find(ivy_theme)
end

Marks = function(opts)
  local marks = vim.api.nvim_exec("marks", true)
  local marks_table = vim.fn.split(marks, "\n")
  -- Pop off the header
  table.remove(marks_table, 1)
  -- Filter all non-lower case marks
  local results = vim.tbl_filter(function(val)
    local mark = string.sub(val,2,2) -- get second char in string
    return string.match(mark, "%l") ~= nil -- return false for all non-lower case marks
  end, marks_table)
  -- Sort results by line number
  table.sort(results, function(a,b)
    return vim.fn.split(a)[2] < vim.fn.split(b)[2]
  end)
  -- Create new picker
  pickers.new(opts, {
    prompt_title = "Marks",
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_marks(opts),
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

function M.marks()
  Marks{
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      --map('i', 'l', actions.file_edit)
      -- Custom actions
      map('i', 'x', function(prompt_bufnr) -- delete selected mark
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:delete_selection( function(_)
          local selection_value = action_state.get_selected_entry().value
          local selection_mark = vim.fn.split(selection_value)[1]
          -- TODO: the line below does not work because the mark gets deleted in Telescope's buffer
          vim.cmd('delmarks ' .. selection_mark)
          -- Another issue with local marks: https://github.com/neovim/neovim/issues/4295
          end)
      end)
      return true
    end,
  }
end

-------------------------------------------------------------------------------
--- Git Pickers
-------------------------------------------------------------------------------

function M.git_commits()
  require("telescope.builtin").git_commits{
    cwd = vim.fn.expand("%:p:h"),
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
  }
end

function M.git_bcommits()
  require("telescope.builtin").git_bcommits{
    cwd = vim.fn.expand("%:p:h"),
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
  }
end

function M.git_status()
  require("telescope.builtin").git_status{
    cwd = vim.fn.expand("%:p:h"),
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    --path_display = {"tail"}, -- TODO: change to "smart" when merged: https://github.com/caojoshua/telescope.nvim/pull/1
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      --map('i', 'l', actions.file_edit)
      return true
    end,
  }
end

RecentFiles = function(opts)
  Lines = {}
  for line in io.lines(vim.fn.expand(vim.g.MRU_File)) do
    Lines[#Lines + 1] = line
  end
  local results = vim.tbl_filter(function(val)
    return (vim.fn.filereadable(val) ~= 0 and vim.fn.expand("%:p") ~= val)
  end, Lines)
  pickers.new(opts, {
    prompt_title = 'File History',
    finder = finders.new_table{
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

function M.recent_files()
  RecentFiles{
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      --map('i', 'l', actions.file_edit)
      return true
    end,
  }
end

---------------------------------------------------------------------------------
-- Mappings
---------------------------------------------------------------------------------

local utils = require('mrv.utils')

-- File pickers
utils.remap("n", "<Leader>b", "<Cmd>lua require('mrv.plugins.telescope').buffers()<CR>")
utils.remap("n", "<Leader>f", "<Cmd>lua require('mrv.plugins.telescope').find_files()<CR>")
utils.remap("n", "<Leader>o", "<Cmd>lua require('mrv.plugins.telescope').git_files()<CR>")
--utils.remap("n", "<Leader>rg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
utils.remap("n", "<Leader>.", "<Cmd>lua require('mrv.plugins.telescope').dotfiles()<CR>")
utils.remap("n", "<Leader>a", "<Cmd>lua require('mrv.plugins.telescope').args()<CR>")
-- Vim pickers
utils.remap("n", "<Leader>r", "<Cmd>lua require('mrv.plugins.telescope').recent_files()<CR>")
utils.remap("n", "<Leader>ch", "<Cmd>lua require('telescope.builtin').command_history()<CR>")
--utils.remap("n", "<Leader>bl", "<Cmd>lua require('mrv.plugins.telescope').lines()<CR>")
utils.remap("n", "<Leader>'", "<Cmd>lua require('mrv.plugins.telescope').marks()<CR>")
--utils.remap("n", "<Leader>ma", "<Cmd>lua require('telescope.builtin').keymaps()<CR>")
-- LSP pickers
--utils.remap("n", "<Leader>ds", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
utils.remap("n", "<Leader>sy", "<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>")
utils.remap("n", "<Leader>ca", "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
-- Git pickers
utils.remap("n", "<Leader>co", "<Cmd>lua require('mrv.plugins.telescope').git_commits()<CR>")
utils.remap("n", "<Leader>cb", "<Cmd>lua require('mrv.plugins.telescope').git_bcommits()<CR>")
utils.remap("n", "<Leader>st", "<Cmd>lua require('mrv.plugins.telescope').git_status()<CR>")
-- Lists pickers
--utils.remap("n", "<Leader>tj", "<Cmd>lua require('telescope.builtin').builtin()<CR>")

return M

