vim.g.vimtex_compiler_latexmk = {
  build_dir = "build",
  continuous = true,
} 

-- Configure Okular
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
vim.g.vimtex_view_general_options_latexmk = "--unique"

--vim.g.vimtex_quickfix_ignore_filters = { "Underfull .*", } -- disable custom warnings based on regexp

