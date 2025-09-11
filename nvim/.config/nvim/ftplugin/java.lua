local vim = vim
local utils = require('mrv.utils')

-- Define cell_delimeter
vim.b.cell_delimeter = '/// '

-- Use 4 spaces for indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

---------------------------------------------------------------------------------
--- Debug utilities
---------------------------------------------------------------------------------

local print_fun = 'System.out.println'
--local print_fun = 'LOGGER.info'

vim.keymap.set('n', '<Leader>pr', function()
  utils.insert_string(print_fun .. [[(\"'%s': \" + %s); // DEBUG]], 'o')
end, { buffer = true })

---------------------------------------------------------------------------------
--- vim-tomux
---------------------------------------------------------------------------------

-- Default config
vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }

vim.g.tomux_use_clipboard = 0

-- Split the current window vertically, adding a new pane to the right
-- The new pane starts in Vim's current working directory
vim.keymap.set('n', '<Leader>tl', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{right-of}" }
  vim.cmd [[TomuxCommand("split-window -h -d -c " . getcwd())]]
end, { buffer = true })

-- Split the current window horizontally, adding a new pane to the bottom
-- The new pane starts in Vim's current working directory
vim.keymap.set('n', '<Leader>tj', function()
  vim.b.tomux_config = { socket_name = "default", target_pane = "{down-of}" }
  vim.cmd [[TomuxCommand("split-window -v -d -l 20% -c "  . getcwd())]]
end, { buffer = true })

-- Kill pane
vim.keymap.set('n', '<Leader>tk', function()
  vim.cmd [[TomuxCommand("kill-pane -t " . shellescape(b:tomux_config["target_pane"]))]]
end, { buffer = true })

-- Build
vim.keymap.set('n', '<Leader>tb', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("./gradlew build\n")]]
end, { buffer = true })

-- Run (send first CTRL-c and then execute)
vim.keymap.set('n', '<Leader>e', function()
  vim.cmd.write()
  vim.cmd[[TomuxCommand("send-keys -t " . shellescape(b:tomux_config["target_pane"]) . " C-c")]]
  vim.cmd [[TomuxSend("./gradlew bootRun\n")]]
end, { buffer = true })

-- Clean
vim.keymap.set('n', '<Leader>tc', function()
  vim.cmd.write()
  vim.cmd [[TomuxSend("./gradlew clean\n")]]
end, { buffer = true })

-- Test
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd [[TomuxSend("./gradlew test\n")]]
end, { buffer = true })

---------------------------------------------------------------------------------
--- nvim-jdtls
---------------------------------------------------------------------------------

-- Sources: 
--  - https://youtu.be/C7juSZsM2Fg?si=cA9O4sks4KL3L6I-
--  - https://raw.githubusercontent.com/exosyphon/nvim/refs/heads/main/ftplugin/java.lua

local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
  },

  -- Fixed the `LSP[jdtls] Security Warning! The Gradle wrapper ... could be
    -- malicious.` warning using the solution from:
    -- https://github.com/mfussenegger/nvim-jdtls/discussions/249#discussioncomment-3159367
  init_options = {
    settings = {
      java = {
        implementationsCodeLens = { enabled = true },
        imports = {
          gradle = {
            enabled = true,
            wrapper = {
              enabled = true,
              checksums = {
                {
                  sha256 = '7d3a4ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172',
                  allowed = true
                }
              },
            }
          }
        }
      }
    },
  }
}
require('jdtls').start_or_attach(config)

--vim.keymap.set('n', '<Leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
--vim.keymap.set('n', '<Leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
--vim.keymap.set('v', '<Leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
--vim.keymap.set('n', '<Leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
--vim.keymap.set('v', '<Leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
--vim.keymap.set('v', '<Leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })
