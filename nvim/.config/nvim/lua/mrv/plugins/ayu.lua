vim.g.ayu_mirage = false

local colors = require('ayu.colors')

vim.g.ayu_overrides = {

  -- Line numbers
  CursorLineNr = {bg = colors.bg},
  LineNr = {fg = colors.ui},

  -- BufTabLine
  BufTabLineCurrent = {fg = colors.fg, bg = colors.bg}, --       'blue2 background'
  BufTabLineActive = {fg = colors.ui, bg = colors.bg},  --       'grey5 background'
  BufTabLineHidden = {fg = colors.ui, bg = colors.bg},  --       'grey4 background'
  TabLineFill = {bg = colors.bg},
  --BufTabLineFill =            'background background'
  --BufTabLineModifiedCurrent = 'yellow2 grey2'
  --BufTabLineModifiedActive =  'yellow2'
  --BufTabLineModifiedHidden =  'yellow2'
}

vim.cmd [[ colorscheme ayu ]]

