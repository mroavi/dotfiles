-- Treesitter configuration
require('nvim-treesitter').setup()

-- Install parsers (runs async, safe to call directly)
require('nvim-treesitter').install({
  "arduino",
  "bash",
  "c",
  "comment",
  "cpp",
  "c_sharp",
  "css",
  "html",
  "java",
  "javascript",
  "json",
  "julia",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "rust",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
})

-- Disable treesitter indent for specific languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.bo.indentexpr = ""
  end,
})
