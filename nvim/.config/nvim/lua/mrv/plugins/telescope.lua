local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

local M = {}

require("telescope").setup{
  defaults = {
    sorting_strategy = "descending",
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
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

---------------------------------------------------------------------------------
--- File Pickers
---------------------------------------------------------------------------------

function M.find_files()
  require("telescope.builtin").find_files{
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
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

---------------------------------------------------------------------------------
--- Vim Pickers
---------------------------------------------------------------------------------

function M.buffers()
  require("telescope.builtin").buffers{
    shorten_path = true,
  }
end

function M.lines()
  require("telescope.builtin").current_buffer_fuzzy_find{
    prompt_position = "top",
    sorting_strategy = "ascending",
  }
end

-------------------------------------------------------------------------------
--- Git Pickers
-------------------------------------------------------------------------------

function M.git_commits()
  require("telescope.builtin").git_commits{
    cwd = vim.fn.expand("%:p:h"),
    prompt_position = "top",
    sorting_strategy = "ascending",
  }
end

function M.git_bcommits()
  require("telescope.builtin").git_bcommits{
    cwd = vim.fn.expand("%:p:h"),
    prompt_position = "top",
    sorting_strategy = "ascending",
  }
end

function M.git_status()
  require("telescope.builtin").git_status{
    cwd = vim.fn.expand("%:p:h"),
  }
end

Mru = function(opts)
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

function M.file_history()
  Mru{}
end

---------------------------------------------------------------------------------
-- Mappings
---------------------------------------------------------------------------------

local vimp = require 'vimp'
local builtin = require 'telescope.builtin'

-- File pickers
vimp.nnoremap('<Leader>fi', M.find_files)
vimp.nnoremap('<Leader>fg', M.git_files)
vimp.nnoremap('<Leader>rg', builtin.live_grep)
vimp.nnoremap('<Leader>do', M.dotfiles)
-- Vim pickers
vimp.nnoremap('<leader>bu', M.buffers)
vimp.nnoremap('<Leader>fh', M.file_history)
vimp.nnoremap('<Leader>ch', builtin.command_history)
vimp.nnoremap('<Leader>bl', M.lines)
-- LSP pickers
vimp.nnoremap('<Leader>ds', builtin.lsp_document_symbols)
vimp.nnoremap('<Leader>sy', builtin.lsp_workspace_symbols)
vimp.nnoremap('<Leader>ca', builtin.lsp_code_actions)
-- Git pickers
vimp.nnoremap('<Leader>co', M.git_commits)
vimp.nnoremap('<Leader>bc', M.git_bcommits)
vimp.nnoremap('<Leader>st', M.git_status)
-- Lists pickers
vimp.nnoremap('<leader>te', builtin.builtin)

return M

