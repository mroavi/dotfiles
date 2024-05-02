-- Emulates zsh's glg alias in nvim's command line

-- Open commit browser
vim.cmd('cnoreabbrev glg GV')

-- Only list commits that affected the current buffer
vim.cmd('cnoreabbrev glgb GV!')
