require("chatgpt").setup({
  chat_input = {
    prompt = "> ",
  },
  keymaps = {
    close = { "<C-c>", "<Esc>" },
    yank_last = "<C-y>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    toggle_settings = "<C-o>",
    new_session = "<C-n>",
    cycle_windows = "<Tab>",
  },
})

vim.keymap.set("n", "<Leader>C", "<Cmd>:ChatGPT<CR>")
vim.keymap.set("x", "<Leader>C", "<Cmd>:ChatGPTEditWithInstructions<CR>")
