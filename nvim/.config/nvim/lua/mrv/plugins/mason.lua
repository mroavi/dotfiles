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

local arch = vim.loop.os_uname().machine
local is_ssh = vim.env.SSH_CONNECTION ~= nil

-- Explicit lists per arch + env
local server_matrix = {
  x86_64 = {
    local_ = {
      "arduino_language_server",
      "bashls",
      "clangd",
      "cmake",
      "csharp_ls",
      "cssls",
      "efm",
      "emmet_language_server",
      "html",
      "jdtls",
      "lemminx",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "sqlls",
      "tailwindcss",
      "texlab",
      "vimls",
      "vtsls",
      "yamlls",
    },
    ssh = {
    },
  },
  aarch64 = {
    local_ = {
      "arduino_language_server",
      "efm",
      "jdtls",
      "lua_ls",
      "rust_analyzer",
      "texlab",
      -- put ARM-only servers here if needed
    },
    ssh = {
    },
  },
}

-- pick the right list
local env_key = is_ssh and "ssh" or "local_"
local ensure_installed = server_matrix[arch]
    and server_matrix[arch][env_key]
    or {}

local opts = {
  ensure_installed = ensure_installed,
}

require("mason-lspconfig").setup(opts)

vim.keymap.set("n", "<Leader>M", ":Mason<CR>")
