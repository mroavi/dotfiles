local M = {}

--==============================================================================
--- General
--==============================================================================

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
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = false,
  }
)

-- Enable logging, open the log with :lua vim.cmd('e'..vim.lsp.get_log_path())
--vim.lsp.set_log_level("debug")

--==============================================================================
--- LSP Servers Config
--==============================================================================

local lspconfig = require'lspconfig'

--------------------------------------------------------------------------------
--- vim
--------------------------------------------------------------------------------

-- Installation: npm install -g vim-language-server
lspconfig.vimls.setup{}

--------------------------------------------------------------------------------
--- python
--------------------------------------------------------------------------------

-- Installation: sudo pacman -S pyright
lspconfig.pyright.setup{}

--------------------------------------------------------------------------------
--- julia
--------------------------------------------------------------------------------

-- Installation:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/63?u=mroavi
--  $ julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- Instant startup with PackageCompiler:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/72?u=mroavi
require'lspconfig'.julials.setup{
  capabilities = capabilities,
}

---- vim.lsp.set_log_level("debug")

--------------------------------------------------------------------------------
--- bash
--------------------------------------------------------------------------------

-- Installation: npm i -g bash-language-server
lspconfig.bashls.setup{}

--------------------------------------------------------------------------------
--- c
--------------------------------------------------------------------------------

-- Installation: see bootstrap in dotfiles
lspconfig.clangd.setup{
  cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
  filetypes = { "c", "cpp", "objc", "objcpp"},
}

--------------------------------------------------------------------------------
--- lua
--------------------------------------------------------------------------------

-- Installation: sudo pacman -S lua-language-server
local lua_lsp_dir = "/home/mroavi/lsp-servers/lua-language-server/"
local luadev = require("lua-dev").setup({
  lspconfig = {
  cmd = {lua_lsp_dir .. "bin/Linux/lua-language-server", "-E", lua_lsp_dir .. "/main.lua"}
  },
})
lspconfig.sumneko_lua.setup(luadev)

--------------------------------------------------------------------------------
--- texlab
--------------------------------------------------------------------------------

-- Installation: sudo pacman -S texlab
lspconfig.texlab.setup{}

--------------------------------------------------------------------------------
--- arduino
--------------------------------------------------------------------------------

---- Installation: yay -S arduino-language-server-git
--lspconfig.arduino_language_server.setup({
--  cmd =  {
--    -- Required
--    "arduino-language-server",
--    "-cli-config", "/home/mroavi/.arduino15/arduino-cli.yaml",
--    -- Optional
--    "-cli", "/bin/arduino-cli",
--    "-clangd", "/bin/clangd"
--  }
--})

--------------------------------------------------------------------------------
--- cmake
--------------------------------------------------------------------------------

-- Installation: pip install cmake-language-server
--lspconfig.cmake.setup{}

---- Example of how to run code depending on a environment variable
--if not os.getenv("SSH_CONNECTION") then
--  -- <CODE>
--end

--------------------------------------------------------------------------------
-- Signs
--------------------------------------------------------------------------------

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--------------------------------------------------------------------------------
-- Virtual text prefix
--------------------------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = {
    prefix = '■', -- Could be '●', '▎', 'x'
  }
})

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------

local utils = require('mrv.utils')
-- See `:h lsp-buf`
utils.keymap("n", "<Leader>de", "<Cmd>lua vim.lsp.buf.definition()<CR>")
utils.keymap("n", "<Leader>us", "<Cmd>lua vim.lsp.buf.references<CR>")
utils.keymap("n", "<Leader>cw", "<Cmd>lua vim.lsp.buf.rename()<CR>")
--utils.keymap("n", "<Leader>fo", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
utils.keymap("n", "<Leader>ho", "<Cmd>lua vim.lsp.buf.hover()<CR>")
utils.keymap("n", "<Leader>si", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
-- See `:h lsp-diagnostic`
utils.keymap("n", "]d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_next()<CR>")
utils.keymap("n", "[d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_prev()<CR>")

return M

