-- In insert mode, <C-g>n inserts the filename of the buffer in the previous
-- window (typically the file being committed). This mapping is only active
-- when editing Git commit messages.
vim.keymap.set("i", "<C-g>n", function()
  local win = vim.fn.win_getid(vim.fn.winnr("#"))
  local buf = vim.api.nvim_win_get_buf(win)
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
  vim.api.nvim_put({ name }, "", false, true)
end, { buffer = true, noremap = true, silent = true })
