-- Reminder:
-- After installing a formatter using Mason and setting it up with Conform,
-- don't forget to enable the 'gq' operator for formatting. Add the following
-- line inside `ftplugin/<filetype>.lua`:
--  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- Based on: https://youtu.be/6pAG3BHurdM?si=TAoMywJVwhL15c39

local conform = require("conform")

conform.setup({
  -- I use Mason to install these formatters
  formatters_by_ft = {
    python = { "black" },
    tex = { "latexindent" },
    arduino = { "clang-format" },
    java = { "google-java-format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
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
