local ls = require "luasnip"
local vim = vim

--require("luasnip/loaders/from_vscode").lazy_load() -- to use existing vs-code style snippets from a plugin

-- Simple example of a global snippet (type "expand" followed by <Tab> ) (https://www.youtube.com/watch?v=Dn800rlPIho)
ls.add_snippets("all", {
    -- Available for any filetype
    ls.parser.parse_snippet("expand", "Hello, World!"),
  }
)

-- Expand
vim.keymap.set({ "i", "s" }, "<C-j>", "<Plug>luasnip-expand-snippet")

-- Expand or jump forward (TODO: do not expand with tab)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
    vim.api.nvim_feedkeys(key, 'n', false)
  end
end, { silent = true })

-- Jump backwards
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
