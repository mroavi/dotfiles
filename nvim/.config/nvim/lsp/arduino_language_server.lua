return {
  cmd = {
    "arduino-language-server",
    "-clangd", vim.fn.expand("~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd"), -- WARNING: this path may change after updating clangd
    "-cli", "/bin/arduino-cli",
    "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
  }
}
