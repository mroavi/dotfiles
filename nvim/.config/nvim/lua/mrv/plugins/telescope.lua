local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

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
-- My themes
---------------------------------------------------------------------------------

function TmuxTheme(opts)
  opts = opts or {}
  local theme_opts = {
    layout_strategy = "vertical",
    layout_config = {mirror = true},
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    -- path_display = {"tail"}, -- TODO: change to "smart" when merged: https://github.com/caojoshua/telescope.nvim/pull/1
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      map('i', 'l', actions.file_edit)
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

function M.marks()
  require("telescope.builtin").marks{
    cwd = vim.fn.expand("%:p:h"),
    layout_strategy = "vertical",
    layout_config = {mirror = true},
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      map('i', 'l', actions.file_edit)
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
			prompt_position = "top",
      mirror = true,
		},
		sorting_strategy = "ascending",
    layout_strategy = "vertical",
	}
end

function M.git_bcommits()
	require("telescope.builtin").git_bcommits{
		cwd = vim.fn.expand("%:p:h"),
		layout_config = {
			prompt_position = "top",
      mirror = true,
		},
		sorting_strategy = "ascending",
    layout_strategy = "vertical",
	}
end

function M.git_status()
  require("telescope.builtin").git_status{
    cwd = vim.fn.expand("%:p:h"),
    layout_strategy = "vertical",
    layout_config = {mirror = true},
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    -- path_display = {"tail"}, -- TODO: change to "smart" when merged: https://github.com/caojoshua/telescope.nvim/pull/1
    attach_mappings = function(_, map)
      map('i', 'k', actions.move_selection_previous)
      map('i', 'j', actions.move_selection_next)
      map('i', 'x', actions.delete_buffer)
      map('i', 'l', actions.file_edit)
      return true
    end,
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

local utils = require('mrv.utils')

-- File pickers
utils.remap("n", "<Leader>,", "<Cmd>lua require('mrv.plugins.telescope').buffers()<CR>")
utils.remap("n", "<Leader>fi", "<Cmd>lua require('mrv.plugins.telescope').find_files()<CR>")
utils.remap("n", "<Leader>fg", "<Cmd>lua require('mrv.plugins.telescope').git_files()<CR>")
utils.remap("n", "<Leader>rg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
utils.remap("n", "<Leader>.", "<Cmd>lua require('mrv.plugins.telescope').dotfiles()<CR>")
-- Vim pickers
utils.remap("n", "<Leader>fh", "<Cmd>lua require('mrv.plugins.telescope').file_history()<CR>")
utils.remap("n", "<Leader>o", "<Cmd>lua require('mrv.plugins.telescope').file_history()<CR>")
utils.remap("n", "<Leader>ch", "<Cmd>lua require('telescope.builtin').command_history()<CR>")
utils.remap("n", "<Leader>bl", "<Cmd>lua require('mrv.plugins.telescope').lines()<CR>")
utils.remap("n", "<Leader>'", "<Cmd>lua require('mrv.plugins.telescope').marks()<CR>")
-- LSP pickers
-- utils.remap("n", "<Leader>ds", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
utils.remap("n", "<Leader>sy", "<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>")
utils.remap("n", "<Leader>ca", "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
-- Git pickers
utils.remap("n", "<Leader>co", "<Cmd>lua require('mrv.plugins.telescope').git_commits()<CR>")
utils.remap("n", "<Leader>bc", "<Cmd>lua require('mrv.plugins.telescope').git_bcommits()<CR>")
utils.remap("n", "<Leader>gs", "<Cmd>lua require('mrv.plugins.telescope').git_status()<CR>")
-- Lists pickers
utils.remap("n", "<Leader>te", "<Cmd>lua require('telescope.builtin').builtin()<CR>")

return M

