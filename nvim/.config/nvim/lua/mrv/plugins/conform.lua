local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    python = { "black" },
  }
})

-- Enable formatting using the gq operator
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
