-- Manual installation: sudo pacman -S lua-language-server
vim.lsp.config("lua_ls", {
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
})

