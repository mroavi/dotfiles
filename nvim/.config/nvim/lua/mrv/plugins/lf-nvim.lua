local fn = vim.fn
local o = vim.o

-- This feature will not work if the plugin is lazy-loaded
vim.g.lf_netrw = true

require("lf").setup({
  default_action = "edit", -- default action when `Lf` opens a file
  default_actions = {
    ["<C-t>"] = "tabedit",
    ["<C-j>"] = "split",
    ["<C-l>"] = "vsplit",
    ['<C-a>'] = '$arga', -- add to end of arglist
  },
  winblend = 0, -- psuedotransparency level
  border = "rounded", -- border kind: single double shadow curved
  height = fn.float2nr(fn.round(0.90 * o.lines)), -- height of the *floating* window
  width = fn.float2nr(fn.round(0.90 * o.columns)), -- width of the *floating* window
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

vim.keymap.set("n", "<Leader>-", ":Lf<CR>")
