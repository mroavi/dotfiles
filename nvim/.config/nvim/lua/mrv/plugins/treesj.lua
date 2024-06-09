require'treesj'.setup {
  use_default_keymaps = false,
  max_join_length = 999,
}

-- Fallback to splitjoin.vim on unsupported languages
-- https://github.com/Wansmer/treesj/discussions/19

-- Sets mini.splitjoin as default for all files
require('mini.splitjoin').setup() -- to run manually, use :lua MiniSplitjoin.toggle()

local langs = require'treesj.langs'['presets']

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    local opts = { buffer = true }
    if langs[vim.bo.filetype] then
      -- Set treesj if file type is supported
      vim.keymap.set('n', 'gS', require('treesj').toggle, opts)
    end
  end,
})
