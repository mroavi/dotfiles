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
      "arduino_language_server",
      "bashls",
      "clangd",
      "cmake",
      "csharp_ls",
      "cssls",
      "efm",
      "emmet_language_server",
      "html",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "sqlls",
      "tailwindcss",
      "texlab",
      "vimls",
    }
  }
else
  opts = {
    -- For a list of all available packages, see: https://mason-registry.dev/registry/list
    ensure_installed = {
      "arduino_language_server",
      --"bashls",
      "clangd",
      --"cmake",
      "efm",
      "lua_ls",
      --"pyright",
      "rust_analyzer",
      "texlab",
      --"vimls",
    }
  }
end

require("mason-lspconfig").setup(opts)

vim.keymap.set("n", "<Leader>M", ":Mason<CR>")
