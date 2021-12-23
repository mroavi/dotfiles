local utils = require('mrv.utils')
utils.remap_buff(0, "n", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>")
utils.remap_buff(0, "v", "<Leader>f", "<Cmd>JuliaFormatterFormat<CR>")

