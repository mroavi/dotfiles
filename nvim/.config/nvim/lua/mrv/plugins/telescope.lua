local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values
local action_state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"
local utils = require('telescope.utils')
local strings = require('plenary.strings')
local Path = require('plenary.path')

local M = {}

require("telescope").setup{
  defaults = {
    layout_config = {height = 0.9, width = 0.9},
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    path_display = {"smart"},
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_to_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist,
        ["<C-l>"] = actions.file_vsplit,
        ["<C-j>"] = actions.file_split,
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

--------------------------------------------------------------------------------
--- My themes
--------------------------------------------------------------------------------

function TmuxTheme(opts)
  opts = opts or {}
  local theme_opts = {
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    --scroll_strategy = "limit",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      return true
    end,
    on_complete = {
      function(picker)
        local buf = vim.api.nvim_win_get_buf(picker.original_win_id)
        local selection_index
        local i = 1
        for entry in picker.manager:iter() do
          if entry.bufnr == buf then
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
  return vim.tbl_deep_extend("force", theme_opts, opts)
end

--------------------------------------------------------------------------------
--- File Pickers
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
--- My Custom File Pickers
--------------------------------------------------------------------------------

-- ------------------------------------- Args ----------------------------------

Args = function(opts)
  -- TODO: store a field that can be used to sort the entries based on how old they are
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
        local original_bufnr = vim.api.nvim_win_get_buf(picker.original_win_id)
        local original_buf_path = vim.api.nvim_buf_get_name(original_bufnr)
        local selected_index
        local i = 1
        for entry in picker.manager:iter() do
          local entry_path = vim.fn.fnamemodify(entry[1], ":p")
          if entry_path == original_buf_path then
            selected_index = i
            break
          end
          i = i + 1
        end
        local row = picker:get_row(selected_index)
        picker:set_selection(row)
        picker._completion_callbacks = {}
      end,
    },
  }
  Args(opts)
end

--------------------------------------------------------------------------------
--- Vim Pickers
--------------------------------------------------------------------------------

function M.buffers()
  require("telescope.builtin").buffers(TmuxTheme())
end

function M.buffer_lines()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require('telescope.builtin').help_tags({
    attach_mappings = function(_,map)
      actions.select_default:replace(actions.file_vsplit)
      return true
    end,
  })
end

-- Sort based on line number of the result hits
function M.fuzzy_star_search()
  local opts = {
    default_text=vim.fn.expand("<cword>"),
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      return true
    end,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

--------------------------------------------------------------------------------
--- My Custom Vim Pickers
--------------------------------------------------------------------------------

--- ----------------------------------- Marks ----------------------------------

local function make_entry_gen_from_marks(_)

  -- `entry` is the table returned by the function that is returned by this function
  -- This means that I can access `entry.value`, `entry.ordinal` and `entry.path`
  local make_display = function(entry)

    local displayer = entry_display.create {
      separator = "",
      items = {
        { width = 5 },
        { width = 5 },
        { width = 5 },
        { remaining = true },
      },
    }

    return displayer {
      { entry.mark, "TelescopeResultsIdentifier" },
      { entry.lnum, "TelescopePreviewGroup" },
      { entry.col, "TelescopeResultsSpecialComment" },
      entry.text,
    }
  end

  -- This function is assigned to the finder's `entry_maker` field
  -- It allows us set the fields we need. mrv: in the displayer
  -- `result` takes the value of each table inside the finder's `results` field
  return function(result)
    local split_value = utils.max_split(result, "%s+", 4)

    local mark_value = split_value[1]
    local cursor_position = vim.fn.getpos("'" .. mark_value)

    -- parts taken from: lua/telescope/make_entry.lua
    return {
      value = result,
      ordinal = result,
      display = make_display,
      mark = split_value[1],
      lnum = cursor_position[2],
      col = cursor_position[3],
      start = cursor_position[2],
      filename = vim.api.nvim_buf_get_name(cursor_position[1]),
      text = string.sub(result, 16, #result),
    }
  end
end

Marks = function(opts)

  local marks = vim.api.nvim_exec("marks", true)  -- get output from `marks` cmd
  local marks_table = vim.fn.split(marks, "\n")   -- split into an array
  table.remove(marks_table, 1) -- pop off the header

  -- Filter all non-lower case marks
  local results = vim.tbl_filter(function(val)
    local mark = string.sub(val,2,2) -- get second char in string
    return string.match(mark, "%l") ~= nil -- return false for all non-lower case marks
  end, marks_table)

  -- Sort results by line number
  table.sort(results, function(a, b)
    local a_row_num = tonumber(vim.fn.split(a)[2])
    local b_row_num = tonumber(vim.fn.split(b)[2])
    return a_row_num < b_row_num
  end)

  -- Create new picker
  pickers.new(opts, {
    prompt_title = "Marks",
    finder = finders.new_table {
      results = results,
      --entry_maker = opts.entry_maker or make_entry.gen_from_marks(opts),
      entry_maker = make_entry_gen_from_marks(opts),
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

-- Local marks BUG: https://github.com/neovim/neovim/issues/4295
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
      -- Custom actions
      map('i', 'x', function(prompt_bufnr) -- delete selected mark
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:delete_selection( function(_)
          local selection_value = action_state.get_selected_entry().value
          local selection_mark = vim.fn.split(selection_value)[1]
          local original_bufnr = vim.api.nvim_win_get_buf(current_picker.original_win_id)
          vim.api.nvim_buf_del_mark(original_bufnr, selection_mark)
          end)
      end)
      return true
    end,
  }
end

--- -------------------------------- Recent Files ------------------------------

-- Source:
--  https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#entry-maker
--  https://github.com/TC72/telescope-tele-tabby.nvim/blob/main/lua/telescope/_extensions/tele_tabby.lua

local function make_entry_gen_from_recent_files(opts)

  opts = opts or {}

  local disable_devicons = opts.disable_devicons

  local icon_width = 0
  if not disable_devicons then
    local icon, _ = utils.get_devicons('fname', disable_devicons)
    icon_width = strings.strdisplaywidth(icon)
  end

  -- `entry` is the table returned by the function that is returned by this function
  -- This means that I can access `entry.value`, `entry.ordinal` and `entry.path`
  local make_display = function(entry)

    local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())
    local display_path = Path:new(entry.path):normalize(cwd)

    local pathtofile = vim.fn.fnamemodify(display_path, ":h")
    local filename = vim.fn.fnamemodify(display_path, ":t")

    local icon, hl_group = utils.get_devicons(filename, disable_devicons)

    local displayer = entry_display.create {
      separator = "",
      items = {
        { width = (icon_width + 3) },
        { width = string.len(pathtofile)},
        { width = 1 },
        { remaining = true },
      },
    }

    return displayer {
      { icon, hl_group },
      pathtofile,
      '/',
      { filename, "TelescopePreviewExecute" },
    }
  end

  -- This function is assigned to the finder's `entry_maker` field
  -- It allows us set the fields we need. mrv: in the displayer
  -- `result` takes the value of each table inside the finder's `results` field
  return function(result)

    return {
      valid = true,
      value = result,
      display = make_display,
      ordinal = result.path,
      path = result.path,
    }

  end
end

RecentFiles = function(opts)

  local mru_entries = {}

  for mru_entry in io.lines(vim.fn.expand(vim.g.MRU_File)) do
    mru_entries[#mru_entries + 1] = mru_entry
  end

  local mru_entries_filtered = vim.tbl_filter(function(val)
    return (vim.fn.filereadable(val) ~= 0 and vim.fn.expand("%:p") ~= val)
  end, mru_entries)

  local results = {}

  for _, mru_entry in pairs(mru_entries_filtered) do

    local element = {
      ordinal = mru_entry,
      path = mru_entry,
      --path = Path:new({ opts.cwd, mru_entry }):absolute(),
    }

    table.insert(results, element)

  end

  ---- This works with: entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
  --local mru_entries = {}
  --for mru_entry in io.lines(vim.fn.expand(vim.g.MRU_File)) do
  --  mru_entries[#mru_entries + 1] = mru_entry
  --end
  --local results = vim.tbl_filter(function(val)
  --  return (vim.fn.filereadable(val) ~= 0 and vim.fn.expand("%:p") ~= val)
  --end, mru_entries)

  pickers.new(opts, {
    prompt_title = 'Recent Files',
    finder = finders.new_table{
      results = results,
      --entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
      entry_maker = make_entry_gen_from_recent_files(opts),
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
      --map('i', 'l', actions.file_edit)
      return true
    end,
  }
end

--- ----------------------------------- Hunks ----------------------------------

Hunks = function(opts)
  local current_buffer = vim.api.nvim_get_current_buf()
  local ok, gitsigns = pcall(require, 'gitsigns')
  if not ok then
    vim.api.nvim_echo({{'gitsigns plugin not found', 'WarningMsg'}}, false, {})
    return
  end
  local hunks = gitsigns.get_hunks(current_buffer)
  local current_buffer_path = vim.api.nvim_buf_get_name(current_buffer)
  local results = {}
  for _, hunk in pairs(hunks) do
    table.insert(results, {hunk.added.start, hunk.lines[1], current_buffer_path})
  end
  -- Create new picker
  pickers.new(opts, {
    prompt_title = "Hunks",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = string.format("%-6d", entry[1]) .. entry[2],
          ordinal = entry[1],
          lnum = entry[1],
          path = entry[3],
        }
      end
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

function M.hunks()
  Hunks{
    layout_strategy = "vertical",
    layout_config = {
      mirror = true,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    attach_mappings = function(prompt_bufnr, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      -- Custom actions
      actions.select_default:replace(function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local original_bufnr = vim.api.nvim_win_get_buf(current_picker.original_win_id)
        vim.api.nvim_buf_call(original_bufnr, function(_)
          local entry = action_state.get_selected_entry()
          vim.cmd(string.format("%d", entry.lnum))
        end)
        actions.close(prompt_bufnr)
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
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      return true
    end,
  }
end

---------------------------------------------------------------------------------
-- Mappings
---------------------------------------------------------------------------------

local my_utils = require('mrv.utils')
-- File pickers
my_utils.remap("n", "<Leader>f", "<Cmd>lua require('mrv.plugins.telescope').find_files()<CR>")
my_utils.remap("n", "<Leader>o", "<Cmd>lua require('mrv.plugins.telescope').git_files()<CR>")
--my_utils.remap("n", "<Leader>rg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
my_utils.remap("n", "<Leader>.", "<Cmd>lua require('mrv.plugins.telescope').dotfiles()<CR>")
my_utils.remap("n", "<Leader>a", "<Cmd>lua require('mrv.plugins.telescope').args()<CR>")
my_utils.remap("n", "<Leader>*", "<Cmd>lua require('mrv.plugins.telescope').fuzzy_star_search()<CR>")
-- Vim pickers
my_utils.remap("n", "<Leader>b", "<Cmd>lua require('mrv.plugins.telescope').buffers()<CR>")
my_utils.remap("n", "<Leader>/", "<Cmd>lua require('mrv.plugins.telescope').buffer_lines()<CR>")
my_utils.remap("n", "<Leader>'", "<Cmd>lua require('mrv.plugins.telescope').marks()<CR>")
my_utils.remap("n", "<Leader>H", "<Cmd>lua require('mrv.plugins.telescope').hunks()<CR>")
my_utils.remap("n", "<Leader>r", "<Cmd>lua require('mrv.plugins.telescope').recent_files()<CR>")
my_utils.remap("n", "<Leader>ch", "<Cmd>lua require('telescope.builtin').command_history()<CR>")
my_utils.remap("n", "<Leader>he", "<Cmd>lua require('mrv.plugins.telescope').help_tags()<CR>")
--my_utils.remap("n", "<Leader>ma", "<Cmd>lua require('telescope.builtin').keymaps()<CR>")
my_utils.remap("n", "<Leader>hi", "<Cmd>lua require('telescope.builtin').highlights()<CR>")
-- LSP pickers
--my_utils.remap("n", "<Leader>ds", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
my_utils.remap("n", "<Leader>sy", "<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>")
my_utils.remap("n", "<Leader>ca", "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
-- Git pickers
my_utils.remap("n", "<Leader>co", "<Cmd>lua require('mrv.plugins.telescope').git_commits()<CR>")
my_utils.remap("n", "<Leader>cb", "<Cmd>lua require('mrv.plugins.telescope').git_bcommits()<CR>")
my_utils.remap("n", "<Leader>st", "<Cmd>lua require('mrv.plugins.telescope').git_status()<CR>")
-- Lists pickers
--my_utils.remap("n", "<Leader>tj", "<Cmd>lua require('telescope.builtin').builtin()<CR>")

return M

