vim.g.vimtex_compiler_latexmk = {
  aux_dir = "aux",
  out_dir = "out",
  continuous = true,
}

-- Configure Okular
vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

-- Disable custom warnings based on regexp
vim.g.vimtex_quickfix_ignore_filters = {
  --"\\vspace should",
  --"Missing",
  --"Unknown document class",
  --"LaTeX Font Warning:",
  -- Ignored warnings for PhD thesis
  "Underfull",
  "Overfull",
  "LaTeX Font Warning: Font shape `U/wasy/b/n'",
  "LaTeX Font Warning: Font shape `T1/ppl/m/scsl' undefined",
}
