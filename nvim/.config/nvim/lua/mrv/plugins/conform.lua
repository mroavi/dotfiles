local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    python = { "black" },
    tex = { "latexindent" },
  }
})
