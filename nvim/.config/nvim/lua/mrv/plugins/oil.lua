require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
  keymaps = {
    ["<Esc>"] = { callback = "actions.close", mode = "n" },
    ["<Leader>:"] = { callback = "actions.open_cmdline", mode = "n" },
    ["<Leader>yy"] = { callback = "actions.copy_entry_path", mode = "n" },
    ---------------------------------------------------------------------------
    -- Create a new mapping, gs, to search and replace in the current directory
    -- Source: https://github.com/MagicDuck/grug-far.nvim?tab=readme-ov-file
    -- TODO: move this keymap to grug-far config
    gs = {
      callback = function()
        -- get the current directory
        local oil = require "oil"
        local prefills = { paths = oil.get_current_dir() }
        -- instance check
        local grug_far = require "grug-far"
        if not grug_far.has_instance "explorer" then
          grug_far.open {
            instanceName = "explorer",
            prefills = prefills,
            staticTitle = "Find and Replace from Explorer",
          }
        else
          grug_far.get_instance('explorer'):open()
          -- updating the prefills without clearing the search and other fields
          grug_far.get_instance('explorer'):update_input_values(prefills, false)
        end
      end,
      desc = "oil: Search in directory",
    },
    ---------------------------------------------------------------------------
  }
})

vim.keymap.set("n", "-", function() require("oil").open() end, { desc = "Open parent directory" })
vim.keymap.set("n", "<Leader>-", function() require("oil").open(".") end, { desc = "Open current working directory" })
