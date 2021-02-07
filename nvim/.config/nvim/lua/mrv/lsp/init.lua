local M = {}

function M.goto_next()
  vim.lsp.diagnostic.goto_next{ wrap = false,}
end

function M.goto_prev()
  vim.lsp.diagnostic.goto_prev{ wrap = false,}
end

if not os.getenv("SSH_CONNECTION") then

  local lspconfig = require'lspconfig'

  -- check if this works (can I get rid of the snippets plugin?)
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

  lspconfig.vimls.setup{}
  lspconfig.jedi_language_server.setup{}
  -- lspconfig.bashls.setup{}
  -- lspconfig.texlab.setup{}
  -- lspconfig.cmake.setup{}

  lspconfig.clangd.setup{
    cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
    filetypes = { "c", "cpp", "objc", "objcpp"},
  }

  local lua_lsp_loc = "/home/mroavi/lsp-servers/lua-language-server/"
  lspconfig.sumneko_lua.setup{
    cmd = {lua_lsp_loc .. "bin/Linux/lua-language-server", "-E", lua_lsp_loc .. "/main.lua"},
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

end

return M

