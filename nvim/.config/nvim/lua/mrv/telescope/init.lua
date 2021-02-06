-- local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

local M = {}

require("telescope").setup{
  defaults = {
    shorten_path = true,
    prompt_position = "bottom",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-p>"] = false,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-n>"] = false,
        ["<c-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_to_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist,
      },
      n = {
        ["<esc>"] = actions.close
      },
    },
  }
}

function M.find_files()
  require("telescope.builtin").find_files{
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
  }
end

function M.buffers()
  require("telescope.builtin").buffers{
    shorten_path = true,
  }
end

function M.current_buffer_fuzzy_find()
  require("telescope.builtin").current_buffer_fuzzy_find{
    prompt_position = "top", 
    sorting_strategy = "ascending",
  }
end

mru = function(opts)
  lines = {}
  for line in io.lines(vim.g.MRU_File) do 
    lines[#lines + 1] = line
  end
  local results = vim.tbl_filter(function(val)
    return 0 ~= vim.fn.filereadable(val)
  end, lines)
  pickers.new(opts, {
    prompt_title = 'MRU',
    finder = finders.new_table{
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

function M.mru()
  mru{}
end

return M

