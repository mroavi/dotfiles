-- Reminder:
-- After installing a formatter using Mason and setting it up with Conform,
-- don't forget to enable the 'gq' operator for formatting. Add the following
-- line inside `ftplugin/<filetype>.lua`:
--  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- Based on: https://youtu.be/6pAG3BHurdM?si=TAoMywJVwhL15c39

-- TODO: Auto-install formatters using mason-tool-installer.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local conform = require("conform")

conform.setup({
  -- I use Mason to install these formatters
  formatters_by_ft = {
    arduino = { "clang-format" },
    java = { "google-java-format" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    python = { "black" },
    tex = { "latexindent" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    yaml = { "prettier" },
  },
  -- Override/add to the default values of formatters
  formatters = {
    latexindent = {
      -- Prepend the ``-m`` (modifylinebreaks) switch
      prepend_args = { "-m" },
    }
  }
})

vim.keymap.set("n", "<Leader>C", ":ConformInfo<CR>")

-------------------------------------------------------------------------------
-- Ensure Conform is used for `gq` even after LSP attaches
-------------------------------------------------------------------------------

local conform_filetypes = {
  arduino = true,
  javascriptreact = true,
  javascript = true,
  java = true,
  json = true,
  python = true,
  tex = true, -- for `latexindent`: pacman -S libxcrypt-compat if libcrypt.so.1 error
  typescriptreact = true,
  typescript = true,
  yaml = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype
    if conform_filetypes[ft] then
      vim.bo[buf].formatexpr = "v:lua.require'conform'.formatexpr()"
    end
  end,
})

-------------------------------------------------------------------------------
-- Autoformat-on-save only for these filetypes
-------------------------------------------------------------------------------

local autoformat_filetypes = {
  javascriptreact = true,
  javascript = true,
  typescriptreact = true,
  typescript = true,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if autoformat_filetypes[ft] then
      conform.format({ bufnr = args.buf })
    end
  end,
})
