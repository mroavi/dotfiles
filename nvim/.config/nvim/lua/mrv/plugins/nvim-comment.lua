local options = {
  marker_padding = true, -- have a space between comment chars and line
  comment_empty = false, -- do not comment out empty or whitespace only lines
  create_mappings = true, -- create default mappings
}

require('nvim_comment').setup(options)

