local vimp = require 'vimp'
local builtin = require 'telescope.builtin'

-- File pickers
vimp.nnoremap('<Leader>fi', require("mrv.telescope").find_files)
vimp.nnoremap('<Leader>fg', require("mrv.telescope").git_files)
vimp.nnoremap('<Leader>gr', builtin.grep_string)
vimp.nnoremap('<Leader>rg', builtin.live_grep)
vimp.nnoremap('<Leader>do', require("mrv.telescope").dotfiles)
-- Vim pickers
vimp.nnoremap('<leader>ls', require("mrv.telescope").buffers)
vimp.nnoremap('<Leader>fh', require("mrv.telescope").file_history)
vimp.nnoremap('<Leader>ch', builtin.command_history)
vimp.nnoremap('<Leader>li', require("mrv.telescope").lines)
-- LSP pickers
vimp.nnoremap('<Leader>ds', builtin.lsp_document_symbols)
vimp.nnoremap('<Leader>sy', builtin.lsp_workspace_symbols)
vimp.nnoremap('<Leader>ca', builtin.lsp_code_actions)
-- Git pickers
vimp.nnoremap('<Leader>co', require("mrv.telescope").git_commits)
vimp.nnoremap('<Leader>bc', require("mrv.telescope").git_bcommits)
vimp.nnoremap('<Leader>st', require("mrv.telescope").git_status)
-- Lists pickers
vimp.nnoremap('<leader>te', builtin.builtin)
