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
    python = { "black" },
    tex = { "latexindent" },
    arduino = { "clang-format" },
    java = { "google-java-format" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
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

-- Ensure Conform is used for `gq` even after LSP attaches
local conform_filetypes = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	json = true,
	tex = true, -- for `latexindent`: pacman -S libxcrypt-compat if libcrypt.so.1 error
	python = true,
	java = true,
	arduino = true,
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
