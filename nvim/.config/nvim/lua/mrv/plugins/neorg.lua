require('neorg').setup {
  load = {
    ["core.defaults"] = {}, -- loads default behaviour
    ["core.norg.concealer"] = {}, -- adds pretty icons to your documents
    ["core.norg.dirman"] = { -- manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/notes",
        },
      },
    },
  },
}
