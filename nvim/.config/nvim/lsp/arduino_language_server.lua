-- nvim-lspconfig ships its own `lsp/arduino_language_server.lua` later
-- on the runtimepath, so we override its `cmd` via a
-- `vim.lsp.config()` call (which outranks any `lsp/` file) rather than
-- a plain `return {...}`.
vim.lsp.config('arduino_language_server', {
  cmd = {
    "arduino-language-server",
    "-clangd", vim.fn.expand("~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd"), -- WARNING: this path may change after updating clangd
    "-cli", "/bin/arduino-cli",
    "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
  },
})
return {}
