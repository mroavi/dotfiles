local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    python = { "black" },
    tex = { "latexindent" },
  },
  -- Override/add to the default values of formatters
  formatters = {
    latexindent = {
      -- Prepend the ``-m`` (modifylinebreaks) switch
      prepend_args = { "-m" },
    }
  }
})
