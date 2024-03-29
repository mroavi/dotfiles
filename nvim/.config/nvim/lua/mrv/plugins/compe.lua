-- Using nvim-cmp in favor of this plugin

local M = {}

M.setup = function()
  require 'compe'.setup {
    documentation = {
      border = "rounded",
    },
    source = {
      path = true,
      buffer = true,
      calc = true,
      nvim_lsp = true,
      nvim_lua = true,
      vsnip = true,
      ultisnips = false,
      luasnip = false,
      latex_symbols = true,
      spell = { filetypes = { "gitcommit", "markdown" }, }
    },
  }
end

M.setup()

vim.keymap.set("i", "<C-Space>", "compe#complete()", { expr = true, noremap = true }) -- trigger completion menu
vim.keymap.set("i", "<C-e>", "compe#close('<C-e>')", { expr = true, noremap = true }) -- close completion menu

-- Select option from completion menu
--vim.keymap.set("i", "<CR>", "compe#confirm('<CR>')", {expr = true, noremap = true})
--vim.keymap.set("i", "<CR>", "compe#confirm({ 'keys': \"\\<Plug>delimitMateCR\", 'mode': '' })", {expr = true}) -- compatitbility with DelimitMate
vim.cmd [[ inoremap <silent><expr> <CR> compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()")) ]] -- compatitbility with nvim-autopairs

return M
