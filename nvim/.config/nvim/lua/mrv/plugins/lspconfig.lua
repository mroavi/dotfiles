local M = {}

---------------------------------------------------------------------------------
--- General
---------------------------------------------------------------------------------

function M.goto_next()
  vim.lsp.diagnostic.goto_next{ wrap = false, }
end

function M.goto_prev()
  vim.lsp.diagnostic.goto_prev{ wrap = false, }
end

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

-- -- based on: https://github.com/fredrikekre/.dotfiles/tree/master/.config/nvim/lsp-julia
-- local cmd = {
-- 	"julia",
-- 	"--startup-file=no",
-- 	"--history-file=no",
-- 	vim.fn.expand("~/.config/nvim/lua/mrv/plugins/lspconfig/run.jl")
-- }
-- require'lspconfig'.julials.setup{
-- 	cmd = cmd,
-- 	-- Why do I need this? Shouldn't it be enough to override cmd on the line above?
-- 	on_new_config = function(new_config, _)
-- 		new_config.cmd = cmd
-- 	end,
-- 	filetypes = {"julia"},
-- }
-- -- vim.lsp.set_log_level("debug")

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
utils.remap("n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
utils.remap("n", "<Leader>us", "<Cmd>lua vim.lsp.buf.references<CR>")
utils.remap("n", "<Leader>cw", "<Cmd>lua vim.lsp.buf.rename()<CR>")
utils.remap("n", "<Leader>fo", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
utils.remap("n", "<Leader>ho", "<Cmd>lua vim.lsp.buf.hover()<CR>")
utils.remap("n", "<Leader>si", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
-- See `:h lsp-diagnostic`
utils.remap("n", "]d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_next()<CR>")
utils.remap("n", "[d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_prev()<CR>")

return M

