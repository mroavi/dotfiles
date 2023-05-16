local vim = vim
local ls = require "luasnip"

ls.config.set_config {
  history = true, -- allows to jump back into last snippet
}

--require("luasnip/loaders/from_vscode").lazy_load() -- to use existing vs-code style snippets from a plugin

-- Expand or jump forward
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- Jump backward
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

--------------------------------------------------------------------------------
-- Custom snippets
--------------------------------------------------------------------------------

-- Simple example of a global snippet (type "expand" followed by <Tab> ) (https://www.youtube.com/watch?v=Dn800rlPIho)
ls.add_snippets("all", { -- available for any filetype
  ls.parser.parse_snippet("expand", "Hello, World!"),
})

--- julia

ls.add_snippets("julia", {
  ls.parser.parse_snippet("pr", "println($0)"),
  ls.parser.parse_snippet("fun", "function $1($2)\n\t$0\nend"),
  ls.parser.parse_snippet("for", "for $1 in $2\n\t$0\nend"),
})

--- lua

ls.add_snippets("lua", {
  ls.parser.parse_snippet("pr", "print($0)"),
  ls.parser.parse_snippet("pp", "vim.print($0)"),
})
