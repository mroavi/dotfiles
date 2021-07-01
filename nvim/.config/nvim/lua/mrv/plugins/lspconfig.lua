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
local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {lua_lsp_dir .. "bin/Linux/lua-language-server", "-E", lua_lsp_dir .. "/main.lua"}
  },
})
lspconfig.sumneko_lua.setup(luadev)

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
local utils = require('mrv.utils')
-- See `:h lsp-buf`
utils.remap("n", "<Leader>gd", "<CMD>vim.lsp.buf.definition")
utils.remap("n", "<Leader>re", "<CMD>vim.lsp.buf.references")
utils.remap("n", "<Leader>cw", "<CMD>vim.lsp.buf.rename")
utils.remap("n", "<Leader>fo", "<CMD>vim.lsp.buf.formatting")
utils.remap("n", "<Leader>ho", "<CMD>vim.lsp.buf.hover")
utils.remap("n", "<Leader>si", "<CMD>vim.lsp.buf.signature_help")
-- See `:h lsp-diagnostic`
utils.remap("n", "]d", "<CMD>M.goto_next")
utils.remap("n", "[d", "<CMD>M.goto_prev")
utils.remap("n", "<Leader>di", "<CMD>vim.lsp.diagnostic.show_line_diagnostics")

return M

