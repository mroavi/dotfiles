-- This feature will not work if the plugin is lazy-loaded
vim.g.lf_netrw = true

require("lf").setup({
  default_actions = {
    ["<C-t>"] = "tabedit",
    ["<C-j>"] = "split",
    ["<C-l>"] = "vsplit",
    ['<C-a>'] = '$arga', -- add to end of arglist
  },
  winblend = 0, -- psuedotransparency level
  border = "rounded", -- border kind: single double shadow curved
  escape_quit = false, -- map escape to the quit command (so it doesn't go into a meta normal mode)
  highlights = { -- highlights passed to toggleterm
    Normal = { link = 'Normal' },
    NormalFloat = { link = 'Normal' },
    FloatBorder = { link = 'FloatBorder' },
    SignColumn = { link = 'SignColumn' },
    StatusLine = { link = 'StatusLine' },
    StatusLineNC = { link = 'StatusLineNC' },
  },
})

vim.keymap.set("n", "<Leader>/", ":Lf<CR>")
