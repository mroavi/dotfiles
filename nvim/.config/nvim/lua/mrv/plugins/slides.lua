require('hologram').setup {
  auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}

vim.keymap.set("n", "<F5>", "<Cmd>Present<CR>", { silent = true }) -- blink cursor after next/prev
