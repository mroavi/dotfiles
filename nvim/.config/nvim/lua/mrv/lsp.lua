local M = {}

local my_utils = require 'mrv.utils'

-- nvim-lspconfig ships sensible defaults for a bunch of servers. Our
-- lsp/<name>.lua files build on those defaults and either:
--   * override cmd / filetypes / root_markers -> vim.lsp.config(name, {...}); return {}
--     (lspconfig's defaults load later on the runtimepath, so a plain `return`
--     would lose; a vim.lsp.config() call outranks it)
--   * add nested settings.* that lspconfig doesn't set -> plain `return {...}`
--     (these deep-merge on top of the defaults instead of conflicting)

vim.lsp.enable(
  {
    "clangd",
    "csharp_ls",
    "emmet_language_server",
    "jedi_language_server",
    "lua_ls",
    "texlab",
    "vtsls",
    "jdtls",
  }
)

-- Completion capabilities are provided globally by blink.cmp, which registers
-- them on `vim.lsp.config('*')`, so individual servers don't need to set them.

-- Configure diagnostic options
vim.diagnostic.config({
  --virtual_lines = true, -- alternative to `virtual_text`
  virtual_text = {
    prefix = '■', -- could be '●', '▎', 'x'
  },
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = { border = "rounded" },
})

-- Enable logging. Open the log with:
--   :lua vim.cmd('e' .. vim.lsp.get_log_path())
-- vim.lsp.set_log_level("debug")


-- ==============================================================================
--- Custom format operator
-- ==============================================================================

function M.range_format_opfunc(motion_type)
  return my_utils.operator(false, nil, function()
    local opts = {
      range = {
        ['start'] = vim.api.nvim_buf_get_mark(0, '['),
        ['end'] = vim.api.nvim_buf_get_mark(0, ']'),
      }
    }
    vim.lsp.buf.format(opts)
  end
  )
end

-- Repeat breaks if the opfunc is set to a lua func (https://github.com/neovim/neovim/issues/17503)
vim.cmd [[
  function! __range_format_opfunc(motion_type) abort
    return v:lua.require('mrv.lsp').range_format_opfunc(a:motion_type)
  endfunction
]]

-- ==============================================================================
--- Mappings
-- ==============================================================================

-- GLOBAL DEFAULTS
-- grr gra grn gri i_CTRL-S
-- Some keymaps are created unconditionally when Nvim starts:
-- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
-- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
-- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
-- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
-- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|

-- Override ]d / [d to jump and show the diagnostic float automatically ('float' opens the popup).
-- See :h vim.diagnostic.jump()
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)

-- See `:h lsp-buf`
vim.keymap.set("n", "grd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>=", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<Leader>ho", vim.lsp.buf.hover)
vim.keymap.set('n', 'grs', vim.lsp.buf.signature_help)
vim.keymap.set('n', 'grS', '<cmd>lsp stop<cr>')

local opfunc = "__range_format_opfunc"
vim.keymap.set('x', 'gf', string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })
vim.keymap.set('n', 'gf', string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })

vim.keymap.set("n", "<Leader>L", ":LspInfo<CR>")

return M
