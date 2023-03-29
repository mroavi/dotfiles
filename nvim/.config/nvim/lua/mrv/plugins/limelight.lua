-- Color name (:help cterm-colors) or ANSI code
vim.g.limelight_conceal_ctermfg = 'gray'
vim.g.limelight_conceal_ctermfg = 240

-- Color name (:help gui-colors) or RGB color
vim.g.limelight_conceal_guifg = 'DarkGray'
vim.g.limelight_conceal_guifg = '#777777'

-- " Custom beginning/end of paragraph (only highlights one paragraph at any given time)
-- `zs` and `ze` are explained in: https://vim.fandom.com/wiki/Regex_lookahead_and_lookbehind
vim.cmd([[
let g:limelight_bop = '^\s*$\n'
let g:limelight_eop = '^\s*$'
]])
