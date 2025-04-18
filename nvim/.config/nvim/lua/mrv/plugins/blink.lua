-- For more configuration details about blink.nvim, check out:
-- Docs: https://cmp.saghen.dev/ 
-- YouTube: https://www.youtube.com/@linkarzu (great tutorials!)
-- Blink.nvim config: https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/blink-cmp.lua
-- Reddit thread: https://www.reddit.com/r/neovim/comments/1hwxaot/blinkcmp_updates_remove_luasnip_emoji_and/

require("blink.cmp").setup({
  keymap = {
    preset = 'default',
    ['<C-e>'] = { 'hide' },
    ['<C-j>'] = { 'select_and_accept' },
    ['<C-p>'] = { 'show', 'select_prev', 'fallback' },
    ['<C-n>'] = { 'show', 'select_next', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  },
  snippets = { preset = 'luasnip' },
  completion = {
    menu = {
      auto_show = false,
      border = 'rounded',
      --draw = {
      --  columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      --},
    },
    documentation = {
      auto_show = false,
      --auto_show_delay_ms = 0,
      window = {
        border = 'rounded',
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
    default = { 'lsp', 'path', 'snippets' },
    per_filetype = {
      lua = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  cmdline = {
    enabled = false,
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
  signature = {
    enabled = false,
    window = {
      border = 'rounded',
    },
  },
})
