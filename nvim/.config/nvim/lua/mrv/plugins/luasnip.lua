local vim = vim
local ls = require "luasnip"

ls.config.set_config {
  history = true, -- allows to jump back into last snippet
}

require("luasnip/loaders/from_vscode").lazy_load() -- to use existing vs-code style snippets from a plugin

vim.keymap.set({"i"}, "<C-k>", function() ls.expand() end, {silent = true})

-- Key mappings for jumping forward and backward in snippets 
-- are now handled by the `blink.cmp` plugin (Tab and S-Tab).

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

--- c

ls.add_snippets("c", {
  ls.parser.parse_snippet("pr", "printf(\"$1\\n\"$0);"),
})

--- csharp

ls.add_snippets("cs", {
  ls.parser.parse_snippet("pr", "Console.WriteLine($0);"),
})

--- java

ls.add_snippets("java", {
  ls.parser.parse_snippet("pr", "System.out.println($0);"),
})

--- javascript

ls.add_snippets("javascript", {
  ls.parser.parse_snippet("pr", "console.log($0);"),
})

-- react

for _, ft in ipairs({ "typescriptreact", "javascriptreact" }) do
  ls.add_snippets(ft, {
    ls.parser.parse_snippet("<", "<$1 />$0"),
  })
end
