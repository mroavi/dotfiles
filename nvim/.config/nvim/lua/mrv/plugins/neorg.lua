require('neorg').setup {
  load = {
    ["core.defaults"] = {}, -- loads default behaviour
    ["core.norg.concealer"] = { -- adds pretty icons to your documents
      config = {
        icon_preset = "diamond", -- other options are "basic" and "varied"
      }
    },
    ["core.norg.dirman"] = { -- manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
      },
    },
  },
}
