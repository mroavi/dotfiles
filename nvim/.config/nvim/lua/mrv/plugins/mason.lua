require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
    border = "rounded",
  }
})

require("mason-lspconfig").setup({
  -- For a list of all available packages, see: https://mason-registry.dev/registry/list
  ensure_installed = {
    "lua_ls",
    "vimls",
    "pyright",
    "bashls",
    "clangd",
    "texlab",
    "rust_analyzer",
    "efm",
    "arduino_language_server",
    "cmake",
  }
})

vim.keymap.set("n", "<Leader>M", ":Mason<CR>")
