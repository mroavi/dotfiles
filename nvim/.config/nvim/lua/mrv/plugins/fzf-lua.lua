require("fzf-lua").setup({
  winopts = {
    height = 0.96,
    width  = 0.96,
  },
})

vim.keymap.set("n", "<Leader>o", require("fzf-lua").files)
vim.keymap.set("n", "<Leader>.", function() require("fzf-lua").files({ cwd = "~/dotfiles" }) end)
vim.keymap.set("n", "<Leader>n", function() require("fzf-lua").files({ cwd = "~/notes" }) end)
vim.keymap.set("n", "<C-p>", require("fzf-lua").oldfiles)
vim.keymap.set("n", "<Leader>a", require("fzf-lua").args)
vim.keymap.set("n", "<Leader>/", require("fzf-lua").live_grep)
vim.keymap.set("n", "<Leader>k", require("fzf-lua").help_tags)
vim.keymap.set("n", "grr", require("fzf-lua").lsp_references	)

