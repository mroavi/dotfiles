local options = {
  marker_padding = false, -- space between after comment char
  comment_empty = false, -- do not comment out empty or whitespace only lines
}

require('nvim_comment').setup(options)

