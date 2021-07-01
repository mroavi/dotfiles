local utils = require('mrv.utils')
utils.remap("n", "<Leader>", ":<c-u>WhichKey '<Space>'<CR>", {silent = true})
utils.remap("v", "<Leader>", ":<c-u>WhichKeyVisual '<Space>'<CR>", {silent = true})

