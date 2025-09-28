-- TODO: currently not working

local lspconfig = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Manual installation: https://discourse.julialang.org/t/neovim-languageserver-jl/37286/63
--    $ julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- Instant startup with PackageCompiler: https://discourse.julialang.org/t/neovim-languageserver-jl/37286/72?u=mroavi

-- Based on Fredrik's config:
-- https://github.com/fredrikekre/.dotfiles/blob/2c141f6b574af1faae2ac718bce3bbe1152f083b/.config/nvim/init.vim#L74
local REVISE_LANGUAGESERVER = false -- configure me!

return {
  on_new_config = function(new_config, _)
    if REVISE_LANGUAGESERVER then
      -- Use a setup that uses Revise to debug LanguageServer.jl
      new_config.cmd[5] = (new_config.cmd[5]):gsub("using LanguageServer", "using Revise; using LanguageServer; if isdefined(LanguageServer, :USE_REVISE); LanguageServer.USE_REVISE[] = true; end")
    else
      -- Use the julia bin generated with PackageCompiler to remove startup time
      local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
      if lspconfig.util.path.is_file(julia) then
        new_config.cmd[1] = julia
      end
    end
  end,
  capabilities = capabilities,
}
