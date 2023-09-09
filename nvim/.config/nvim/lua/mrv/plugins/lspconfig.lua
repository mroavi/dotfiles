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
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

if not vim.env.SSH_CONNECTION then

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
  lspconfig.pyright.setup {}

  --------------------------------------------------------------------------------
  --- bash
  --------------------------------------------------------------------------------

  -- Manual installation: npm i -g bash-language-server
  lspconfig.bashls.setup {}

  --------------------------------------------------------------------------------
  --- c
  --------------------------------------------------------------------------------

  -- Manual installation: see bootstrap in dotfiles
  lspconfig.clangd.setup {
    autostart = false,
    cmd = { "clangd", "--background-index", "--fallback-style=LLVM" },
    filetypes = { "c", "cpp", "objc", "objcpp" }
  }

  -- Use `bear` to generate the `compile_commands.json` file needed by clangd
  -- Installation: yay -S bear
  -- Github page: https://github.com/rizsotto/Bear

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

  ---- Manual installation: yay -S arduino-language-server-git
  --lspconfig.arduino_language_server.setup({
  --  cmd =  {
  --      -- Required
  --      "arduino-language-server",
  --      "-cli-config", "/home/mroavi/.arduino15/arduino-cli.yaml",
  --      -- Optional
  --      "-cli", "/bin/arduino-cli",
  --      "-clangd", "/bin/clangd"
  --    }
  --    })

  --------------------------------------------------------------------------------
  --- cmake
  --------------------------------------------------------------------------------

  ---- Manual installation: pip install cmake-language-server
  --lspconfig.cmake.setup{}

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

-- See `:h lsp-buf`
vim.keymap.set("n", "<Leader>d", "<Cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<Leader>u", "<Cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<Leader>r", "<Cmd>lua vim.lsp.buf.rename()<CR>")
if not vim.env.SSH_CONNECTION then
  vim.keymap.set("n", "<Leader>=", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>")
else
  vim.keymap.set("n", "<Leader>=", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
end
vim.keymap.set("n", "<Leader>ho", "<Cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<Leader>si", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
-- See `:h lsp-diagnostic`
vim.keymap.set("n", "]d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_next()<CR>")
vim.keymap.set("n", "[d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_prev()<CR>")

local opfunc = "__range_format_opfunc"
vim.keymap.set('x', 'gf', string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })
vim.keymap.set('n', 'gf', string.format("v:lua.require('mrv.utils').operator(v:true, '%s')", opfunc), { expr = true })

return M
