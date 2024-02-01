local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    python = { "black" },
  }
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
