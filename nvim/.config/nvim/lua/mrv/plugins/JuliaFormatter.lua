vim.keymap.set(0, "n", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>", { buffer = true })
vim.keymap.set(0, "v", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>", { buffer = true })

vim.g["JuliaFormatter_options"] = {
  indent = 2,
  margin = 92,
  always_for_in = false,
  whitespace_typedefs = false,
  whitespace_ops_in_indices = true,
}
