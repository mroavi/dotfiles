require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
  keymaps = {
    ["<Esc>"] = { callback = "actions.close", mode = "n" },
    ["<Leader>:"] = { callback = "actions.open_cmdline", mode = "n" },
    ["<Leader>yy"] = { callback = "actions.copy_entry_path", mode = "n" },
  }
})

vim.keymap.set("n", "<Leader>f", "<Cmd>Oil<CR>", { desc = "Open parent directory" })
