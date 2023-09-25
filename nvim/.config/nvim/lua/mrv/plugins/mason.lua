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

local opts

if not vim.env.SSH_CONNECTION then
  opts = {
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
      "emmet_language_server",
    }
  }
else
  opts = {
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
