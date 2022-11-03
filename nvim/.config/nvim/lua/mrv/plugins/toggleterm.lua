require("toggleterm").setup {
  open_mapping = [[<Leader>>]],
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  terminal_mappings = false, -- whether or not the open mapping applies in the opened terminals
  direction = 'float',
  --on_open = function(term)
  --  vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<C-d>", { noremap = true, silent = true })
  --end,
}
