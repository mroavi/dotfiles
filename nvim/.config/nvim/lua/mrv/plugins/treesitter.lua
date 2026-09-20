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

--------------------------------------------------------------------------------
--- Per-filetype feature opt-in
--- NOTE: these are FILETYPES, not parser names (e.g. cs, typescriptreact, help).
--- Highlighting for lua/markdown/help/query is already started by Neovim itself.
--------------------------------------------------------------------------------
local enable = {
  highlight = {
    "arduino", "bash", "c", "cpp", "cs", "css", "html", "java", "javascript",
    "json", "julia", "python", "rust", "sql", "typescript", "typescriptreact",
  },
  indent = { "c", "cpp", "python" },
  fold = {},
}

local group = vim.api.nvim_create_augroup("mrv_treesitter", { clear = true })

local function on_ft(filetypes, callback)
  if vim.tbl_isempty(filetypes) then return end
  vim.api.nvim_create_autocmd("FileType", { pattern = filetypes, group = group, callback = callback })
end

-- Highlighting (:h treesitter-highlight)
on_ft(enable.highlight, function(args) pcall(vim.treesitter.start, args.buf) end)

-- Indentation (experimental, provided by nvim-treesitter)
on_ft(enable.indent, function()
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end)

-- Folding (:h treesitter-fold)
on_ft(enable.fold, function()
  vim.wo[0][0].foldmethod = "expr"
  vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
end)


-- Disable treesitter indent for specific languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.bo.indentexpr = ""
  end,
})
