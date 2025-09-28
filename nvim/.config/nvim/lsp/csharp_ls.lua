-- Dependencies: sudo pacman -S dotnet-sdk dotnet-runtime aspnet-runtime

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  capabilities = capabilities,
}
