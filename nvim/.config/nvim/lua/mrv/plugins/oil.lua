require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
  keymaps = {
    ["<Esc>"] = "actions.close", -- TODO: this closes the oil buffer in visual mode
  }
})

vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })
