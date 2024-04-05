local cmp = require("cmp")

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  completion = {
    completeopt = "menu,menuone,noselect",
    autocomplete = false, -- open autocompletion menu manually
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end
    }),
    ['<C-p>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end
    }),
    ["<C-j>"] = cmp.mapping.confirm({ select = true }), -- accept currently selected item
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
  }),
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      --vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- The order of these sources determine their priority in cmp's results
    { name = "path" },
    { name = 'nvim_lsp' }, -- WARNING: slows down `cmp.complete()`
    --{ name = "nvim_lsp",
    --  entry_filter = function(entry, ctx)
    --    return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind() -- filter 'Text' entries from nvim_lsp source
    --  end },
    { name = 'luasnip' },
    --{ name = "buffer", keyword_length = 2 },
  },
  experimental = {
    ghost_text = true, -- use virtual text to preview the completion
  },
  ---- Limit number of displayed entries
  --performance = {
  --  max_view_entries = 20,
  --},
}
