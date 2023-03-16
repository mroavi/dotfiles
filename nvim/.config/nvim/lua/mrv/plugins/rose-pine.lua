require('rose-pine').setup({
  --- @usage 'auto'|'main'|'moon'|'dawn'
  variant = 'auto',
  --- @usage 'main'|'moon'|'dawn'
  dark_variant = 'main',
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = false,
  disable_float_background = true,
  disable_italics = true,

  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = 'base',
    panel = 'surface',
    border = 'highlight_high',
    comment = 'muted',
    link = 'iris',
    punctuation = 'subtle',

    error = 'love',
    hint = 'iris',
    info = 'foam',
    warn = 'gold',

    git_add = 'foam',
    git_change = 'gold',
    git_delete = 'love',

    headings = {
      h1 = 'iris',
      h2 = 'foam',
      h3 = 'rose',
      h4 = 'gold',
      h5 = 'pine',
      h6 = 'foam',
    }
    -- or set all headings at once
    -- headings = 'subtle'
  },

  -- Change specific vim highlight groups
  -- https://github.com/rose-pine/neovim/wiki/Recipes
  highlight_groups = {
    ColorColumn = { bg = 'rose' },

    -- Blend colours against the "base" background
    StatusLine = { fg = 'text', bg = 'text', blend = 10 },

    -- mrv
    Normal                = { fg = 'none', bg = 'none' },
    SignColumn            = { fg = 'none', bg = 'none' },
    StatusLineNC          = { fg = 'subtle', bg   = 'surface' },
    gitcommitSummary      = { fg = 'foam', bg = 'none' },
    markdownBlockquote    = { fg = 'subtle' },
    markdownBold          = { fg = 'gold', bg = 'none', bold = true },
    markdownCode          = { fg = 'iris', bg = 'surface' },
    markdownCodeBlock     = { fg = 'foam' },
    markdownCodeDelimiter = { fg = 'foam' },
  }
})

-- set colorscheme after options
vim.cmd('colorscheme rose-pine')
