local M = {}

---------------------------------------------------------------------------------
--- General
---------------------------------------------------------------------------------

function M.goto_next()
  vim.lsp.diagnostic.goto_next{ wrap = false,}
end

function M.goto_prev()
  vim.lsp.diagnostic.goto_prev{ wrap = false,}
end

-- Check if this works (can I get rid of the snippets plugin?)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

-- --- Enable logging, open the log with :lua vim.cmd('e'..vim.lsp.get_log_path())
-- vim.lsp.set_log_level("debug")

---------------------------------------------------------------------------------
--- LSP Servers Config
---------------------------------------------------------------------------------

local lspconfig = require'lspconfig'

--- vim ------------------------------------------------------------------------

lspconfig.vimls.setup{}

--- python ---------------------------------------------------------------------

lspconfig.jedi_language_server.setup{}

--- julia ----------------------------------------------------------------------

lspconfig.julials.setup{}

--- bash -----------------------------------------------------------------------

lspconfig.bashls.setup{}

--- c --------------------------------------------------------------------------

lspconfig.clangd.setup{
  cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
  filetypes = { "c", "cpp", "objc", "objcpp"},
}

--- lua ------------------------------------------------------------------------

local lua_lsp_dir = "/home/mroavi/lsp-servers/lua-language-server/"
lspconfig.sumneko_lua.setup{
  cmd = {lua_lsp_dir .. "bin/Linux/lua-language-server", "-E", lua_lsp_dir .. "/main.lua"},
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
      diagnostics = {globals = {"vim"}},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
        }
      }
    }
  }
}

-- <disabled> ------------------------------------------------------------------

-- lspconfig.texlab.setup{}
-- lspconfig.cmake.setup{}

-- -- Example of how to run code depending on a environment variable
-- if not os.getenv("SSH_CONNECTION") then
--   -- <CODE>
-- end

---------------------------------------------------------------------------------
-- Signs
---------------------------------------------------------------------------------
vim.cmd [[ sign define LspDiagnosticsSignHint        text=➤ ]]
vim.cmd [[ sign define LspDiagnosticsSignError       text=✖ ]]
vim.cmd [[ sign define LspDiagnosticsSignWarning     text=⚠ ]]
vim.cmd [[ sign define LspDiagnosticsSignInformation text=ℹ ]]

---------------------------------------------------------------------------------
-- Mappings
---------------------------------------------------------------------------------
local vimp = require 'vimp'
-- See `:h lsp-buf`
vimp.nnoremap('<Leader>gd', vim.lsp.buf.definition)
vimp.nnoremap('<Leader>re', vim.lsp.buf.references)
vimp.nnoremap('<Leader>cw', vim.lsp.buf.rename)
vimp.nnoremap('<Leader>fo', vim.lsp.buf.formatting)
vimp.nnoremap('<Leader>ho', vim.lsp.buf.hover)
vimp.nnoremap('<Leader>si', vim.lsp.buf.signature_help)
-- See `:h lsp-diagnostic`
vimp.nnoremap(']d', M.goto_next)
vimp.nnoremap('[d', M.goto_prev)
vimp.nnoremap('<Leader>di', vim.lsp.diagnostic.show_line_diagnostics)

return M

