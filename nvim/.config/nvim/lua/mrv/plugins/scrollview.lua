require('scrollview').setup({
  excluded_filetypes = {'nerdtree'},
  current_only = true,
  winblend = 75,
  -- Position the scrollbar at the 80th character of the buffer
  base = 'buffer',
  column = 80
})

vim.cmd [[ highlight ScrollView ctermbg=159 guibg=LightCyan ]]
