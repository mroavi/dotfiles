-- TODO: Refactor LSP config for Neovim 0.11 and after using the new syntax:
-- - https://www.reddit.com/r/neovim/comments/1jn6eib/blink_neovim_011/
-- - https://gpanders.com/blog/whats-new-in-neovim-0-11/#lsp

-- Documentation for all configs can be found at:
--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local my_utils = require 'mrv.utils'

local M = {}

-- ==============================================================================
--- General
-- ==============================================================================

function M.goto_next() vim.diagnostic.goto_next { wrap = false } end
function M.goto_prev() vim.diagnostic.goto_prev { wrap = false } end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Configure diagnostic options
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = false,
      underline = true,
      update_in_insert = false,
      severity_sort = false
    })

-- Hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- Signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Virtual text prefix
vim.diagnostic.config({
  float = { border = "rounded" },
  virtual_text = {
    prefix = '■' -- could be '●', '▎', 'x'
  },
})

-- LspInfo window border
require('lspconfig.ui.windows').default_options.border = 'single'

-- Enable logging, open the log with :lua vim.cmd('e'..vim.lsp.get_log_path())
-- vim.lsp.set_log_level("debug")

-- ==============================================================================
--- LSP Servers Config
-- ==============================================================================

local lspconfig = require 'lspconfig'

--------------------------------------------------------------------------------
--- julia (LanguageServer.jl)
--------------------------------------------------------------------------------

-- Manual installation: https://discourse.julialang.org/t/neovim-languageserver-jl/37286/63
--    $ julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- Instant startup with PackageCompiler: https://discourse.julialang.org/t/neovim-languageserver-jl/37286/72?u=mroavi

-- Based on Fredrik's config:
-- https://github.com/fredrikekre/.dotfiles/blob/2c141f6b574af1faae2ac718bce3bbe1152f083b/.config/nvim/init.vim#L74
local REVISE_LANGUAGESERVER = false -- configure me!
require 'lspconfig'.julials.setup({
  on_new_config = function(new_config, _)
    if REVISE_LANGUAGESERVER then
      -- Use a setup that uses Revise to debug LanguageServer.jl
      new_config.cmd[5] = (new_config.cmd[5]):gsub("using LanguageServer", "using Revise; using LanguageServer; if isdefined(LanguageServer, :USE_REVISE); LanguageServer.USE_REVISE[] = true; end")
    else
      -- Use the julia bin generated with PackageCompiler to remove startup time
      local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
      if require 'lspconfig'.util.path.is_file(julia) then
        new_config.cmd[1] = julia
      end
    end
  end,
  capabilities = capabilities,
})

--------------------------------------------------------------------------------
--- lua
--------------------------------------------------------------------------------

-- Manual installation: sudo pacman -S lua-language-server
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
        -- Ignore Lua_LS's noisy `missing-fields` warnings
        -- See: https://github.com/nvim-lua/kickstart.nvim/issues/543
        disable = { 'missing-fields' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = "Disable",
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

--------------------------------------------------------------------------------
--- vim
--------------------------------------------------------------------------------

-- Manual installation: npm install -g vim-language-server
lspconfig.vimls.setup {
  capabilities = capabilities,
}

--------------------------------------------------------------------------------
--- python
--------------------------------------------------------------------------------

-- Manual installation: sudo pacman -S pyright
--lspconfig.pyright.setup {}

--require'lspconfig'.pylsp.setup{}

require'lspconfig'.jedi_language_server.setup{}

--------------------------------------------------------------------------------
--- c
--------------------------------------------------------------------------------

-- Manual installation: see bootstrap in dotfiles
lspconfig.clangd.setup {
  autostart = true,
  cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
  filetypes = { "c", "cpp", "objc", "objcpp" }
}

-- Use `bear` to generate the `compile_commands.json` file needed by clangd
-- Installation: yay -S bear
-- Github page: https://github.com/rizsotto/Bear

if not vim.env.SSH_CONNECTION then

  --------------------------------------------------------------------------------
  --- bash
  --------------------------------------------------------------------------------

  -- Manual installation: npm i -g bash-language-server
  lspconfig.bashls.setup {}

  --------------------------------------------------------------------------------
  --- texlab
  --------------------------------------------------------------------------------

  -- Manual installation: sudo pacman -S texlab
  lspconfig.texlab.setup {}

  --------------------------------------------------------------------------------
  --- rust
  --------------------------------------------------------------------------------

  -- Manual installation: sudo pacman -S rust-analyzer
  require 'lspconfig'.rust_analyzer.setup {}

  --------------------------------------------------------------------------------
  --- emmet
  --------------------------------------------------------------------------------

  lspconfig.emmet_language_server.setup {}

  --------------------------------------------------------------------------------
  --- html
  --------------------------------------------------------------------------------

  lspconfig.html.setup {
    capabilities = capabilities,
  }

  --------------------------------------------------------------------------------
  --- css
  --------------------------------------------------------------------------------

  lspconfig.cssls.setup {
    capabilities = capabilities,
  }

  --------------------------------------------------------------------------------
  --- tailwind
  --------------------------------------------------------------------------------

  --lspconfig.tailwindcss.setup{
  --  capabilities = capabilities,
  --}

  --------------------------------------------------------------------------------
  --- csharp
  --------------------------------------------------------------------------------

  -- Dependencies: sudo pacman -S dotnet-sdk dotnet-runtime aspnet-runtime
  lspconfig.csharp_ls.setup{
    capabilities = capabilities,
  }

  --------------------------------------------------------------------------------
  --- sql
  --------------------------------------------------------------------------------

  lspconfig.sqlls.setup{}

  --------------------------------------------------------------------------------
  --- typst
  --------------------------------------------------------------------------------

  --lspconfig.tinymist.setup{}

  --------------------------------------------------------------------------------
  --- lua-dev (dev setup for init.lua and plugin development)
  --------------------------------------------------------------------------------

  ---- Manual installation: sudo pacman -S lua-language-server
  --local lua_lsp_dir = "/home/mroavi/lsp-servers/lua-language-server/"
  --local luadev = require("lua-dev").setup({
  --  lspconfig = {
  --    cmd = {lua_lsp_dir .. "bin/Linux/lua-language-server", "-E", lua_lsp_dir .. "/main.lua"}
  --    },
  --    })
  --    lspconfig.sumneko_lua.setup(luadev)

  --------------------------------------------------------------------------------
  --- efm
  --------------------------------------------------------------------------------

  -- Manual installation: go install github.com/mattn/efm-langserver@latest
  --require"lspconfig".efm.setup {
  --  init_options = {documentFormatting = true},
  --  filetypes = {"lua"},
  --  settings = {
  --    rootMarkers = {".git/"},
  --    languages = {
  --      lua = {
  --        {
  --          --  Repo: https://github.com/Koihik/LuaFormatter
  --          --  Style config: https://github.com/Koihik/LuaFormatter/blob/master/docs/Style-Config.md
  --          formatCommand = "lua-format --indent-width=2 --tab-width=2 \z
  --          --continuation-indent-width=2",
  --          formatStdin = true
  --        }
  --      }
  --    }
  --  }
  --}

  --------------------------------------------------------------------------------
  --- arduino
  --------------------------------------------------------------------------------

  -- Manual installation: yay -S arduino-language-server-git
  -- WARNING: This LSP is broken. See https://github.com/arduino/arduino-language-server/issues/202
  lspconfig.arduino_language_server.setup({
    cmd = {
      "arduino-language-server",
      "-clangd", vim.fn.expand("~/.local/share/nvim/mason/packages/clangd/clangd_20.1.0/bin/clangd"), -- WARNING: this path may change after updating clangd
      "-cli", "/bin/arduino-cli",
      "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
    }
  })

  --------------------------------------------------------------------------------
  --- lemminx
  --------------------------------------------------------------------------------

  lspconfig.lemminx.setup{}

  --------------------------------------------------------------------------------
  --- cmake
  --------------------------------------------------------------------------------

  ---- Manual installation: pip install cmake-language-server
  --lspconfig.cmake.setup{}

  --------------------------------------------------------------------------------
  --- java
  --------------------------------------------------------------------------------

  -- NOTE: Do not use lspconfig for jdtls!
  -- jdtls must be started manually per project using `require('jdtls').start_or_attach(config)`
  -- See: https://github.com/mfussenegger/nvim-jdtls

end

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
    return v:lua.require('mrv.plugins.lspconfig').range_format_opfunc(a:motion_type)
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

-- See `:h lsp-buf`
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>=", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("n", "<Leader>ho", vim.lsp.buf.hover)
-- See `:h lsp-diagnostic`
vim.keymap.set("n", "]d", function() require('mrv.plugins.lspconfig').goto_next() end)
vim.keymap.set("n", "[d", function() require('mrv.plugins.lspconfig').goto_prev() end)
vim.keymap.set('n', 'crs', function() vim.cmd('LspStop') end)

local opfunc = "__range_format_opfunc"
vim.keymap.set('x', 'gf', string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })
vim.keymap.set('n', 'gf', string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })

return M
