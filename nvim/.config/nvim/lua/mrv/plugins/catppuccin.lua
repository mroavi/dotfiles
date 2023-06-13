require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- force no italic
  no_bold = true, -- force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = function(colors)
    return {
      ["StatusLine"] = { fg = colors.text, bg = colors.surface0, style = {} },
      ["TelescopeSelection"] = { fg = colors.text, bg = colors.surface0, style = {} },
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = false,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- Setup must be called before loading
vim.cmd.colorscheme "catppuccin"

-- Mocha palette:
-- Rosewater #f5e0dc
-- Flamingo  #f2cdcd
-- Pink      #f5c2e7
-- Mauve     #cba6f7
-- Red       #f38ba8
-- Maroon    #eba0ac
-- Peach     #fab387
-- Yellow    #f9e2af
-- Green     #a6e3a1
-- Teal      #94e2d5
-- Sky       #89dceb
-- Sapphire  #74c7ec
-- Blue      #89b4fa
-- Lavender  #b4befe
-- Text      #cdd6f4
-- Subtext1  #bac2de
-- Subtext0  #a6adc8
-- Overlay2  #9399b2
-- Overlay1  #7f849c
-- Overlay0  #6c7086
-- Surface2  #585b70
-- Surface1  #45475a
-- Surface0  #313244
-- Base      #1e1e2e
-- Mantle    #181825
-- Crust     #11111b
