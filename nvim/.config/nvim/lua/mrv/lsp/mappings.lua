local vimp = require 'vimp'

vimp.nnoremap(']d', require("mrv.lsp").goto_next)
vimp.nnoremap('[d', require("mrv.lsp").goto_prev)

