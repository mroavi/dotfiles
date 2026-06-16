-- nvim-lspconfig ships its own `lsp/jedi_language_server.lua` later on
-- the runtimepath, so we override its `cmd` via a `vim.lsp.config()`
-- call (which outranks any `lsp/` file) rather than a plain `return
-- {...}`.
vim.lsp.config('jedi_language_server', {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/jedi-language-server" },
})
return {}
