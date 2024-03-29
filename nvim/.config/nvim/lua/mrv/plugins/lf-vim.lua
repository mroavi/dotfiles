vim.g["lf#set_default_mappings"] = false
vim.g["lf#replace_netrw"] = true
vim.g["lf#layout"] = {
  window = { width = 0.9, height = 0.9, highlight = "Normal" }
}
vim.g["lf#action"] = {
  ['<C-t>'] = 'tab split', -- open in tab
  ['<C-j>'] = 'split', -- open in horizontal split
  ['<C-l>'] = 'vsplit', -- open in vertical split
  ['<C-a>'] = '$arga | argdedupe' -- add to arglist and remove duplicates
}

vim.keymap.set("n", "<Leader>/",
  "expand('%') == '' ? '<Cmd>Lp %:p:h<CR>' : '<Cmd>Lp %<CR>'",
  { noremap = true, expr = true, replace_keycodes = false })
