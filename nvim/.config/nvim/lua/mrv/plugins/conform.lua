-- Reminder:
-- After installing a formatter using Mason and setting it up with Conform, you
-- need to add the filetype to the `conform_filetypes` table below to enable
-- the 'gq' operator for that filetype. The FileType autocmd will then
-- automatically set:
--   vim.bo[buf].formatexpr = "v:lua.require'conform'.formatexpr()"
-- for those filetypes.
-- Based on: https://youtu.be/6pAG3BHurdM?si=TAoMywJVwhL15c39

-- TODO: Auto-install formatters using mason-tool-installer.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local conform = require("conform")

conform.setup({
  -- I use Mason to install these formatters
  formatters_by_ft = {
    arduino = { "clang-format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    css = { "prettier" },
    bib = { "bibtex-tidy" },
    html = { "prettier" },
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
    ["clang-format"] = {
      prepend_args = { "--style=LLVM" },
    },
    latexindent = {
      -- Prepend the ``-m`` (modifylinebreaks) switch
      prepend_args = { "-m" },
    },
    ["bibtex-tidy"] = {
      prepend_args = {
        "--no-modify",
        "--curly",
        "--numeric",
        "--months",
        "--space=2",
        "--no-align",
        "--no-blank-lines",
        "--no-sort",
        "--duplicates",
        "--no-merge",
        "--escape",
        "--sort-fields",
        "--no-strip-comments",
        "--trailing-commas",
        "--encode-urls",
        "--no-tidy-comments",
        "--remove-empty-fields",
        "--remove-dupe-fields",
        "--wrap=80",
      },
    },
  },
})

vim.keymap.set("n", "<Leader>C", ":ConformInfo<CR>")

-------------------------------------------------------------------------------
-- Ensure Conform is used for `gq` even after LSP attaches
-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf = args.buf
    if #conform.list_formatters(buf) > 0 then
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
  java = true,
  c = true,
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
