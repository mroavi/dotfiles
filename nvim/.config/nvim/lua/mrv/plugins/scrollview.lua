require('scrollview').setup({

  excluded_filetypes = { 'nerdtree' },
  current_only = false,
  --winblend = 75,
  ---- Position the scrollbar at the 80th character of the buffer
  --base = 'buffer',
  --column = 80

})

vim.cmd [[ highlight link ScrollView PmenuThumb ]]
