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


if not vim.env.SSH_CONNECTION then
  local opts = {
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
  }
else
  local opts = {
    -- For a list of all available packages, see: https://mason-registry.dev/registry/list
    ensure_installed = {
      "lua_ls",
      --"vimls",
      --"pyright",
      --"bashls",
      --"clangd",
      "texlab",
      "rust_analyzer",
      "efm",
      "arduino_language_server",
      "cmake",
    }
  }
end

require("mason-lspconfig").setup(opts)

vim.keymap.set("n", "<Leader>M", ":Mason<CR>")
