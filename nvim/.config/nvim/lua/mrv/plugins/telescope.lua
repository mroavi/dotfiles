local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values
local action_state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"
local utils = require 'telescope.utils'
local Path = require 'plenary.path'
local action_set = require 'telescope.actions.set'
local action_utils = require "telescope.actions.utils"

local M = {}

require("telescope").setup {
  defaults = {
    layout_strategy = "flex",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    --selection_strategy = "row", -- bug: causes some of the results to be hidden after a sort
    layout_config = {
      prompt_position = "top", -- where to place prompt window
      height = 0.9,
      width = 0.9,
      flex = {
        flip_columns = 120, -- num. of columns threshold for choosing between horizontal and vertical layout
      },
      horizontal = {
        mirror = false, -- flip the results/prompt and preview windows
      },
      vertical = {
        mirror = true,
      },
    },
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_to_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist,
        -- Custom actions
        ["<C-a>"] = function(_) -- add to arglist and remove duplicates
          local selection_path = action_state.get_selected_entry()[1]
          vim.cmd('$arga ' .. selection_path .. '| argdedupe')
        end
      },
      n = {
        ["<Esc>"] = actions.close
      },
    },
    file_ignore_patterns = {
      ".git/",
      "bin/",
      "obj/",
      "venv/",
      "__pycache__/",
    },
  },
  pickers = {
    live_grep = {
      additional_args = function()
        return {
          "--hidden",
          "--fixed-strings",
        }
      end
    },
  },
}

--------------------------------------------------------------------------------
--- My themes
--------------------------------------------------------------------------------

local function my_tmux_theme(opts)
  opts = opts or {}
  local theme_opts = {
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      return true
    end,
    on_complete = {
      function(picker)
        local buf = vim.api.nvim_win_get_buf(picker.original_win_id)
        local selection_index = 1
        for entry in picker.manager:iter() do
          if entry.bufnr == buf then
            break
          end
          selection_index = selection_index + 1
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
--- Extensions
--------------------------------------------------------------------------------

require("telescope").load_extension("zf-native")

--------------------------------------------------------------------------------
--- My make entry functions
--------------------------------------------------------------------------------

-- Source:
--  https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#entry-maker
--  https://github.com/TC72/telescope-tele-tabby.nvim/blob/main/lua/telescope/_extensions/tele_tabby.lua
local my_make_entry = {}

do
  local lookup_keys = {
    ordinal = 1,
    value = 1,
    filename = 1,
    cwd = 2,
  }
  function my_make_entry.gen_from_file(opts)
    opts = opts or {}
    local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())
    local disable_devicons = opts.disable_devicons
    local mt_file_entry = {}
    mt_file_entry.cwd = cwd
    mt_file_entry.display = function(entry)
      local hl_group
      local display = utils.transform_path(opts, entry.value)
      -- display: string to display for the current entry
      -- hl_group: highlihgt group for the devicon of the current entry
      display, hl_group = utils.transform_devicons(entry.value, display, disable_devicons)
      -----------------------------------------mrv------------------------------
      local display_path = vim.fn.split(display)[2]
      local pathtofile = vim.fn.fnamemodify(display_path, ":h")
      --local tail = vim.fn.fnamemodify(display_path, ":t")
      -- Format:
      -- display_format = { { { <start>, <end> }, <highlight_group> },
      --                    { { <start>, <end> }, <highlight_group> },
      --                    ... }
      -- where <start> is including while <end> is excluding
      local display_format = {}
      table.insert(display_format, { { 1, 3 }, hl_group })
      if pathtofile == "." then
        -- `display` has no path to file (file is in cwd)
        table.insert(display_format, { { 3 + #pathtofile, #display + 1 }, "Operator" })
      else
        -- `display` does have a path to file
        table.insert(display_format, { { 4 + #pathtofile + 1, #display + 1 }, "Operator" })
      end
      if hl_group then
        return display, display_format
      else
        return display
      end
      -----------------------------------------mrv------------------------------
    end
    mt_file_entry.__index = function(t, k)
      local raw = rawget(mt_file_entry, k)
      if raw then
        return raw
      end
      if k == "path" then
        local retpath = Path:new({ t.cwd, t.value }):absolute()
        if not vim.loop.fs_access(retpath, "R", nil) then
          retpath = t.value
        end
        return retpath
      end
      return rawget(t, rawget(lookup_keys, k))
    end
    return function(line)
      return setmetatable({ line }, mt_file_entry)
    end
  end
end

--------------------------------------------------------------------------------
--- File Pickers
--------------------------------------------------------------------------------

function M.find_files(opts)
  opts = opts or {}
  builtin.find_files {
    file_sorter = require 'telescope.sorters'.get_fzy_sorter,
    --cwd = opts.cwd,
    entry_maker = my_make_entry.gen_from_file(opts),
  }
end

function M.git_files(opts)
  opts = opts or {}
  builtin.git_files {
    cwd = opts.cwd,
    --entry_maker = my_make_entry.gen_from_file(opts), -- TODO: buggy
  }
end

-- If `dir` is inside a git repo, return the git repo's root dir, otherwise, `nil`
-- Based on: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/__git.lua
local function git_dir(dir)
  local git_root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, dir)
  if ret ~= 0 then
    local in_worktree = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" }, dir)
    local in_bare = utils.get_os_command_output({ "git", "rev-parse", "--is-bare-repository" }, dir)
    if in_worktree[1] ~= "true" and in_bare[1] ~= "true" then
      return nil -- not a git repo
    else
      return git_root[1] -- bare git repo
    end
  else
    return git_root[1] -- normal git repo
  end
end

-- Defaults to `find_files` if current buffer is not inside a git repo
function M.my_find_files()
  local opts = { cwd = vim.fn.expand("%:p:h") }
  if git_dir(opts.cwd) then
    M.git_files(opts)
  else
    M.find_files(opts)
  end
end

function M.dotfiles()
  local opts = { cwd = "~/dotfiles" }
  builtin.find_files {
    find_command = { 'fd', '--type', 'file', '--hidden', '--no-ignore', '--exclude', '.git', '--exclude', '.vim' },
    prompt_title = "Dotfiles",
    cwd = opts.cwd,
    entry_maker = my_make_entry.gen_from_file(opts),
  }
end

function M.notes()
  local opts = { cwd = "~/notes" }
  builtin.find_files {
    find_command = { 'fd', '--type', 'file', '--hidden', '--no-ignore', '--exclude', '.git', },
    prompt_title = "Notes",
    cwd = opts.cwd,
    entry_maker = my_make_entry.gen_from_file(opts),
  }
end

-- Live grep from the current buffer's git dir if any, otherwise, from vim's current working dir
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#live-grep-from-project-git-root-with-fallback
function M.live_grep(opts)
  opts = opts or {}
  local git_repo_path = git_dir(vim.fn.expand("%:p:h"))
  local cwd = git_repo_path or vim.fn.getcwd()
  local default_opts = {
    cwd = cwd,
    prompt_title = "Live Grep from " .. cwd,
  }
  builtin.live_grep(vim.tbl_deep_extend("force", default_opts, opts))
end

--------------------------------------------------------------------------------
--- My Custom File Pickers
--------------------------------------------------------------------------------

---------------------------------------- args ----------------------------------

-- NOTES:
-- - use :$arga to add the current buffer to the end of the arglist
-- - use :argu[INDEX] to edit file [INDEX] in the list
-- - Someone else's implementation: https://github.com/sam4llis/telescope-arglist.nvim

local function new_args_finder(opts)
  opts = opts or {}
  return finders.new_table {
    results = vim.fn.argv(),
    entry_maker = my_make_entry.gen_from_file(),
  }
end

local function my_args_picker(opts)
  pickers.new(opts, {
    prompt_title = 'Argument List',
    finder = new_args_finder(opts),
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

-- Delete selected entry
local function delete_selected_entry(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  current_picker:delete_selection(function(_)
    local selection_path = action_state.get_selected_entry()[1]
    vim.cmd('argd ' .. selection_path)
  end)
end

local function get_num_entries(prompt_bufnr)
  local num_entries = 0
  action_utils.map_entries(prompt_bufnr, function(entry, index, row)
    num_entries = num_entries + 1
  end)
  return num_entries
end

local function move_selected_entry(prompt_bufnr, add_at_offset, del_at_offset, sel_at_offset)
  local selection_index = action_state.get_selected_entry().index
  local selection_path = action_state.get_selected_entry()[1]
  vim.cmd((selection_index + add_at_offset) .. 'arga ' .. selection_path)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  current_picker:delete_selection(function(_)
    vim.cmd((selection_index + del_at_offset) .. 'argd ')
  end)
  -- More on refresh: https://github.com/nvim-telescope/telescope.nvim/issues/2016
  current_picker:refresh(new_args_finder(), { reset_prompt = false })
  current_picker:set_selection(selection_index + sel_at_offset)
end

-- Move down current entry
local function move_selected_entry_down(prompt_bufnr)
  local selection_index = action_state.get_selected_entry().index
  local num_entries = get_num_entries(prompt_bufnr)
  if selection_index == num_entries then return end
  move_selected_entry(prompt_bufnr, 1, 0, 0)
end

-- Move up current entry
local function move_selected_entry_up(prompt_bufnr)
  local selection_index = action_state.get_selected_entry().index
  if selection_index == 1 then return end
  move_selected_entry(prompt_bufnr, -2, 1, -2)
end

-- Edit selected entry
local function edit_selected_entry(prompt_bufnr)
  local selection_index = action_state.get_selected_entry().index
  actions.close(prompt_bufnr)
  vim.cmd('argu!' .. selection_index)
end

function M.args()
  local opts = {
    scroll_strategy = "limit",
    entry_maker = my_make_entry.gen_from_file(),
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      -- Custom actions
      map('i', '<Cr>', edit_selected_entry)
      map('i', '<C-x>', delete_selected_entry)
      map('i', '<C-k>', move_selected_entry_up)
      map('i', '<C-j>', move_selected_entry_down)
      return true
    end,
    on_complete = {
      function(picker)
        local original_buf_num = vim.api.nvim_win_get_buf(picker.original_win_id)
        local original_buf_path = vim.api.nvim_buf_get_name(original_buf_num)
        local selected_index = 1
        for entry in picker.manager:iter() do
          local entry_path = vim.fn.fnamemodify(entry.value, ":p")
          if entry_path == original_buf_path then
            break
          end
          selected_index = selected_index + 1
        end
        local row = picker:get_row(selected_index)
        picker:set_selection(row)
        picker._completion_callbacks = {}
      end,
    },
  }
  my_args_picker(opts)
end

--------------------------------------------------------------------------------
--- Vim Pickers
--------------------------------------------------------------------------------

function M.buffers()
  builtin.buffers(my_tmux_theme())
end

function M.buffer_lines()
  builtin.current_buffer_fuzzy_find { prompt_title = 'Buffer Lines' }
end

function M.help_tags(opts)
  opts = opts or {}
  local default_opts = {
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function(_, cmd)
        local selection = action_state.get_selected_entry()
        if selection == nil then
          print "[telescope] Nothing currently selected"
          return
        end
        actions.close(prompt_bufnr)
        if cmd == "default" or cmd == "vertical" then
          vim.cmd("vert bo help " .. selection.value)
        elseif cmd == "horizontal" then
          vim.cmd("help " .. selection.value)
        elseif cmd == "tab" then
          vim.cmd("tab help " .. selection.value)
        end
      end)
      return true
    end,
  }
  builtin.help_tags(vim.tbl_deep_extend("force", default_opts, opts))
end

-- Sort based on line number of the result hits
function M.fuzzy_star_search()
  local opts = {
    default_text = vim.fn.expand("<cword>"),
    scroll_strategy = "limit",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      return true
    end,
  }
  builtin.current_buffer_fuzzy_find(opts)
end

--------------------------------------------------------------------------------
--- My Custom Vim Pickers
--------------------------------------------------------------------------------

--------------------------------------- marks ----------------------------------

local function make_entry_gen_from_marks(_)

  -- `entry` is the table returned by the function that is returned by this function
  -- This means that I can access `entry.value`, `entry.ordinal` and `entry.path`
  local make_display = function(entry)

    local displayer = entry_display.create {
      separator = "",
      items = {
        { width = 4 },
        { width = 8 },
        { remaining = true },
      },
    }

    return displayer {
      { entry.mark, "TelescopeResultsIdentifier" },
      { entry.lnum, "TelescopeResultsNumber" },
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

local function my_marks_picker(opts)

  local marks = vim.api.nvim_exec("marks", true) -- get output from `marks` cmd
  local marks_table = vim.fn.split(marks, "\n") -- split into an array
  table.remove(marks_table, 1) -- pop off the header

  -- Filter all non-lower case marks
  local results = vim.tbl_filter(function(val)
    local mark = string.sub(val, 2, 2) -- get second char in string
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
      entry_maker = opts.entry_maker or make_entry.gen_from_marks(opts),
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

-- Local marks BUG: https://github.com/neovim/neovim/issues/4295
function M.marks()
  my_marks_picker {
    entry_maker = make_entry_gen_from_marks(),
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      -- Custom actions
      map('i', '<C-x>', function(prompt_bufnr) -- delete selected mark
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:delete_selection(function(_)
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

------------------------------------- recent files -----------------------------

local function my_recent_files_picker(opts)

  -- Here the `results` var is an array of tables instead of an array of strings
  --local mru_entries = {}
  --for mru_entry in io.lines(vim.fn.expand(vim.g.MRU_File)) do
  --  mru_entries[#mru_entries + 1] = mru_entry
  --end
  --local mru_entries_filtered = vim.tbl_filter(function(val)
  --  return (vim.fn.filereadable(val) ~= 0 and vim.fn.expand("%:p") ~= val)
  --end, mru_entries)
  --local results = {}
  --for _, mru_entry in pairs(mru_entries_filtered) do
  --  local element = {
  --    ordinal = mru_entry,
  --    path = mru_entry,
  --    --path = Path:new({ opts.cwd, mru_entry }):absolute(),
  --  }
  --  table.insert(results, element)
  --end

  local mru_entries = {}
  for mru_entry in io.lines(vim.fn.expand(vim.g.MRU_File)) do
    mru_entries[#mru_entries + 1] = mru_entry
  end
  local results = vim.tbl_filter(function(val)
    return (vim.fn.filereadable(val) ~= 0 and vim.fn.expand("%:p") ~= val)
  end, mru_entries)

  pickers.new(opts, {
    prompt_title = 'Recent Files',
    finder = finders.new_table {
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

function M.recent_files()
  my_recent_files_picker {
    entry_maker = my_make_entry.gen_from_file(),
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      return true
    end,
  }
end

----------------------------------------Hunks-----------------------------------

-- TODO: implement a displayer that colors the git sign and line number
-- differently than the rest of the line.

local function my_hunks_picker(opts)
  local current_buffer = vim.api.nvim_get_current_buf()
  local ok, gitsigns = pcall(require, 'gitsigns')
  if not ok then
    vim.api.nvim_echo({ { 'gitsigns plugin not found', 'WarningMsg' } }, false, {})
    return
  end
  local hunks = gitsigns.get_hunks(current_buffer)
  local current_buffer_path = vim.api.nvim_buf_get_name(current_buffer)
  local results = {}
  for _, hunk in pairs(hunks) do
    table.insert(results, { hunk.added.start, hunk.lines[1], current_buffer_path })
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
  my_hunks_picker {
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
  builtin.git_commits { cwd = vim.fn.expand("%:p:h") }
end

function M.git_bcommits()
  builtin.git_bcommits { cwd = vim.fn.expand("%:p:h") }
end

function M.git_status()
  builtin.git_status {
    cwd = vim.fn.expand("%:p:h"),
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

-- File pickers
vim.keymap.set("n", "<Leader>o", M.my_find_files)
vim.keymap.set("n", "<Leader>/", M.live_grep)
vim.keymap.set('x', '<Leader>/', function() M.live_grep({ default_text = require('mrv.utils').get_visual_selection() }) end)
vim.keymap.set("n", "<Leader>?", function() M.live_grep({ default_text = vim.fn.expand('<cword>') }) end)
vim.keymap.set("n", "<Leader>.", M.dotfiles)
vim.keymap.set("n", "<Leader>n", M.notes)
vim.keymap.set("n", "<Leader>a", M.args)
--vim.keymap.set("n", "<Leader>*", M.fuzzy_star_search)
-- Vim pickers
vim.keymap.set("n", "<Leader>b", M.buffers)
--vim.keymap.set("n", "<Leader>L", M.buffer_lines)
vim.keymap.set("n", "<Leader>'", M.marks)
vim.keymap.set("n", "<Leader>H", M.hunks)
--vim.keymap.set("n", "<Leader>rf", M.recent_files)
vim.keymap.set("n", "<C-p>",     M.recent_files)
vim.keymap.set("n", "<Leader>ch", builtin.command_history)
vim.keymap.set("n", "<Leader>k", M.help_tags)
vim.keymap.set('x', '<Leader>k', function() M.help_tags({ default_text = require('mrv.utils').get_visual_selection() }) end)
vim.keymap.set("n", "<Leader>K", function() M.help_tags({ default_text = vim.fn.expand('<cword>') }) end)
--vim.keymap.set("n", "<Leader>ma", builtin.keymaps)
vim.keymap.set("n", "<Leader>hi", builtin.highlights)
-- LSP pickers
vim.keymap.set("n", "<Leader>d", builtin.diagnostics)
--vim.keymap.set("n", "<Leader>ds", builtin.lsp_document_symbols)
vim.keymap.set("n", "<Leader>sy", builtin.lsp_workspace_symbols)
-- Git pickers
vim.keymap.set("n", "<Leader>co", M.git_commits)
vim.keymap.set("n", "<Leader>cb", M.git_bcommits)
vim.keymap.set("n", "<Leader>st", M.git_status)
-- Lists pickers
vim.keymap.set("n", "<Leader>T", builtin.builtin)

return M
