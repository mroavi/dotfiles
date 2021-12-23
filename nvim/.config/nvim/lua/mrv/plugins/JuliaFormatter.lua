local utils = require('mrv.utils')
utils.keymap_buff(0, "n", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>")
utils.keymap_buff(0, "v", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>")

