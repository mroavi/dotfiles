require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set('n', '<C-j>', function()
      if vim.wo.diff then return '<C-j>' end
      vim.schedule(function() gs.next_hunk({wrap = false}) end)
      return '<Ignore>'
    end, { expr = true })

    vim.keymap.set('n', '<C-k>', function()
      if vim.wo.diff then return '<C-k>' end
      vim.schedule(function() gs.prev_hunk({wrap = false}) end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk)
    vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
    vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end)
    vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
    vim.keymap.set('n', '<leader>hd', gs.diffthis)
    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)
    vim.keymap.set('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- Command version of 'git blame'
vim.cmd('cnoreabbrev gb lua require"gitsigns".blame_line{full=true}')
