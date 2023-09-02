require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- For a list of all available packages, see: https://mason-registry.dev/registry/list
  ensure_installed = {
    "lua_ls",
    "vim-language-server",
    "pyright",
    "bash-language-server",
    "clangd",
    "texlab",
    "rust-analyzer",
    "efm",
    "arduino-language-server",
    "cmake",
  }
})

vim.keymap.set("n", "<Leader>M", ":Mason<CR>")
