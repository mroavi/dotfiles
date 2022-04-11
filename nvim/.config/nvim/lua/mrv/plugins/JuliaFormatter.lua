local utils = require('mrv.utils')
utils.keymap_buff(0, "n", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>")
utils.keymap_buff(0, "v", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>")

vim.g["JuliaFormatter_options"] = {
  indent = 2,
  margin = 92,
  always_for_in = false,
  whitespace_typedefs = false,
  whitespace_ops_in_indices = true,
}
