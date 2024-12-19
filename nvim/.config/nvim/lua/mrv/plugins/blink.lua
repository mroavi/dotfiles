require("blink.cmp").setup({
  keymap = {
    preset = 'default',
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-p>'] = { 'show', 'select_prev', 'fallback' },
    ['<C-n>'] = { 'show', 'select_next', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  },
  snippets = {
    expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
    active = function(filter)
      if filter and filter.direction then
        return require('luasnip').jumpable(filter.direction)
      end
      return require('luasnip').in_snippet()
    end,
    jump = function(direction) require('luasnip').jump(direction) end,
  },
  completion = {
    trigger = {
      -- When false, will not show the completion window automatically when in a snippet
      show_in_snippet = false,
      -- When true, will show the completion window after typing a character that matches the `keyword.regex`
      show_on_keyword = false,
      -- When true, will show the completion window after typing a trigger character
      show_on_trigger_character = false,
      -- LSPs can indicate when to show the completion window via trigger characters
      -- however, some LSPs (i.e. tsserver) return characters that would essentially
      -- always show the window. We block these by default.
      show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
      -- When both this and show_on_trigger_character are true, will show the completion window
      -- when the cursor comes after a trigger character after accepting an item
      show_on_accept_on_trigger_character = false,
      -- When both this and show_on_trigger_character are true, will show the completion window
      -- when the cursor comes after a trigger character when entering insert mode
      show_on_insert_on_trigger_character = false,
      -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
      -- the completion window when the cursor comes after a trigger character when
      -- entering insert mode/accepting an item
      show_on_x_blocked_trigger_characters = { "'", '"', '(' },
    },
    menu = {
      border = 'single',
      --  draw = {
      --    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      --  },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        border = 'single',
      }
    },
    -- Displays a preview of the selected item on the current line
    ghost_text = {
      enabled = true,
    },
  },
  -- default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, via `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'luasnip', 'buffer' },
  },
  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- will be removed in a future release
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },
  -- experimental signature help support
  --signature = { enabled = true }
})
