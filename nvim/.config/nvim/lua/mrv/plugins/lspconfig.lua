local M = {}

-- ==============================================================================
--- General
-- ==============================================================================

function M.goto_next() vim.diagnostic.goto_next {wrap = false} end

function M.goto_prev() vim.diagnostic.goto_prev {wrap = false} end

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

-- Signs
local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- Virtual text prefix
vim.diagnostic.config({
  virtual_text = {
    prefix = '■' -- Could be '●', '▎', 'x'
  }
})

-- Enable logging, open the log with :lua vim.cmd('e'..vim.lsp.get_log_path())
-- vim.lsp.set_log_level("debug")

-- ==============================================================================
--- LSP Servers Config
-- ==============================================================================

local lspconfig = require 'lspconfig'

--------------------------------------------------------------------------------
--- julia
--------------------------------------------------------------------------------

-- Installation:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/63?u=mroavi
--  $ julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- Instant startup with PackageCompiler:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/72?u=mroavi

-- Makes use of the julia bin generated using PackageCompiler to remove startup time
require'lspconfig'.julials.setup {
  autostart = true,
  on_new_config = function(new_config, _)
    local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
    if require'lspconfig'.util.path.is_file(julia) then
      new_config.cmd[1] = julia
    end
  end
}

-- -- Does not make use of the julia bin generated using PackageCompiler
-- require'lspconfig'.julials.setup{
--  capabilities = capabilities,
-- }

if not vim.env.SSH_CONNECTION then

  --------------------------------------------------------------------------------
  --- efm
  --------------------------------------------------------------------------------

  -- Installation: sudo pacman -S efm-langserver
  require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    settings = {
      rootMarkers = {".git/"},
      languages = {
        lua = {
          {
            --  Repo: https://github.com/Koihik/LuaFormatter
            --  Style config: https://github.com/Koihik/LuaFormatter/blob/master/docs/Style-Config.md
            formatCommand = "lua-format --indent-width=2 --tab-width=2 \z
            --continuation-indent-width=2",
            formatStdin = true
          }
        }
      }
    }
  }

  --------------------------------------------------------------------------------
  --- vim
  --------------------------------------------------------------------------------

  -- Installation: npm install -g vim-language-server
  lspconfig.vimls.setup {
    capabilities = capabilities,
  }

  --------------------------------------------------------------------------------
  --- python
  --------------------------------------------------------------------------------

  -- Installation: sudo pacman -S pyright
  lspconfig.pyright.setup {}

  --------------------------------------------------------------------------------
  --- bash
  --------------------------------------------------------------------------------

  -- Installation: npm i -g bash-language-server
  lspconfig.bashls.setup {}

  --------------------------------------------------------------------------------
  --- c
  --------------------------------------------------------------------------------

  -- Installation: see bootstrap in dotfiles
  lspconfig.clangd.setup {
    autostart = false,
    cmd = {"clangd", "--background-index", "--fallback-style=LLVM"},
    filetypes = {"c", "cpp", "objc", "objcpp"}
  }

  -- Use `bear` to generate the `compile_commands.json` file needed by clangd
  -- Installation: yay -S bear
  -- Github page: https://github.com/rizsotto/Bear

  --------------------------------------------------------------------------------
  --- texlab
  --------------------------------------------------------------------------------

  -- Installation: sudo pacman -S texlab
  lspconfig.texlab.setup {}

  --------------------------------------------------------------------------------
  --- rust
  --------------------------------------------------------------------------------

  -- Installation: sudo pacman -S rust-analyzer
  require'lspconfig'.rust_analyzer.setup{}

  --------------------------------------------------------------------------------
  --- lua
  --------------------------------------------------------------------------------

  --local lua_lsp_dir = vim.fn.expand("~/lsp-servers/lua-language-server/")
  --lspconfig.sumneko_lua.setup {
    --  cmd = {
      --    lua_lsp_dir .. "bin/Linux/lua-language-server", "-E",
      --    lua_lsp_dir .. "/main.lua"
      --  },
      --  capabilities = capabilities,
      --  settings = {
        --    Lua = {
          --      runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
          --      diagnostics = {globals = {"vim"}},
          --      workspace = {
            --        -- Make the server aware of Neovim runtime files
            --        library = {
              --          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              --          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
              --        }
              --      }
              --    }
              --  }
              --}

              --------------------------------------------------------------------------------
              --- lua-dev (dev setup for init.lua and plugin development)
              --------------------------------------------------------------------------------

              -- -- Installation: sudo pacman -S lua-language-server
              -- local lua_lsp_dir = "/home/mroavi/lsp-servers/lua-language-server/"
              -- local luadev = require("lua-dev").setup({
                --  lspconfig = {
                  --  cmd = {lua_lsp_dir .. "bin/Linux/lua-language-server", "-E", lua_lsp_dir .. "/main.lua"}
                  --  },
                  -- })
                  -- lspconfig.sumneko_lua.setup(luadev)

                  --------------------------------------------------------------------------------
                  --- arduino
                  --------------------------------------------------------------------------------

                  -- -- Installation: yay -S arduino-language-server-git
                  -- lspconfig.arduino_language_server.setup({
                    --  cmd =  {
                      --    -- Required
                      --    "arduino-language-server",
                      --    "-cli-config", "/home/mroavi/.arduino15/arduino-cli.yaml",
                      --    -- Optional
                      --    "-cli", "/bin/arduino-cli",
                      --    "-clangd", "/bin/clangd"
                      --  }
                      -- })

                      --------------------------------------------------------------------------------
                      --- cmake
                      --------------------------------------------------------------------------------

                      -- Installation: pip install cmake-language-server
                      -- lspconfig.cmake.setup{}

                      -- -- Example of how to run code depending on a environment variable
                      -- if not os.getenv("SSH_CONNECTION") then
                      --  -- <CODE>
                      -- end

end

-- ==============================================================================
--- Custom format operator WIP: works flaky at the moment
-- ==============================================================================

function M.format_operator()
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local opts = {
      range = { 
        ['start'] = vim.api.nvim_buf_get_mark(0, '['),
        ['end'] = vim.api.nvim_buf_get_mark(0, ']'),
      }
    }
    vim.lsp.buf.format(opts)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

-- ==============================================================================
--- Mappings
-- ==============================================================================

-- See `:h lsp-buf`
vim.keymap.set("n", "<Leader>d", "<Cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<Leader>u", "<Cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<Leader>cw", "<Cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<Leader>f", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>")
vim.keymap.set("n", "gf", "<Cmd>lua require('mrv.plugins.lspconfig').format_operator()<CR>")
vim.keymap.set("n", "<Leader>ho", "<Cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<Leader>si", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
-- See `:h lsp-diagnostic`
vim.keymap.set("n", "]d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_next()<CR>")
vim.keymap.set("n", "[d", "<Cmd>lua require('mrv.plugins.lspconfig').goto_prev()<CR>")

return M
