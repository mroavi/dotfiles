" Turn spell checking on
setlocal spell spelllang=en_us

" Suggest words from the active spell checking in the completion menu
set complete+=kspell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" compe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require('compe').setup({ 
  autocomplete = true,
  source = { path = true,
             buffer = true,
             calc = true,
             nvim_lsp = true,
             nvim_lua = true,
             vsnip = true,
             spell = true,
           } }, 0) -- set up for current buffer
EOF

