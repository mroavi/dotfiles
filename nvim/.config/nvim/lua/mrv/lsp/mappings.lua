local vimp = require 'vimp'

-- See `:h lsp-buf`
vimp.nnoremap('<Leader>gd', vim.lsp.buf.definition)
vimp.nnoremap('<Leader>re', vim.lsp.buf.references)
vimp.nnoremap('<Leader>cw', vim.lsp.buf.rename)
vimp.nnoremap('<Leader>fo', vim.lsp.buf.formatting)
vimp.nnoremap('<Leader>ho', vim.lsp.buf.hover)
vimp.nnoremap('<Leader>si', vim.lsp.buf.signature_help)

-- See `:h lsp-diagnostic`
vimp.nnoremap(']d', require("mrv.lsp").goto_next)
vimp.nnoremap('[d', require("mrv.lsp").goto_prev)
vimp.nnoremap('<Leader>di', vim.lsp.diagnostic.show_line_diagnostics)

