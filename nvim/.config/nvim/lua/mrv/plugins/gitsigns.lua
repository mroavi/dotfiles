require('gitsigns').setup {
  keymaps = {
    noremap = true,
    buffer = true,
    ['n <Leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <Leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <Leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <Leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <Leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <Leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <Leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <Leader>j'] = { expr = true, "&diff ? '<Leader>j' : '<cmd>lua require\"gitsigns.actions\".next_hunk({wrap=false})<CR>'"},
    ['n <Leader>k'] = { expr = true, "&diff ? '<Leader>k' : '<cmd>lua require\"gitsigns.actions\".prev_hunk({wrap=false})<CR>'"},
    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk({wrap=false})<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk({wrap=false})<CR>'"},
    -- Try out these other mappings
    --['n <M-]>'] = { expr = true, "&diff ? '<M-]>' : '<cmd>lua require\"gitsigns.actions\".next_hunk({wrap=false})<CR>'"},
    --['n <M-[>'] = { expr = true, "&diff ? '<M-[>' : '<cmd>lua require\"gitsigns.actions\".prev_hunk({wrap=false})<CR>'"},
  },
}

