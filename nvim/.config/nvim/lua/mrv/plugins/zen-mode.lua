local function cmdline_clear()
  local key = vim.api.nvim_replace_termcodes("<C-l>", true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false) -- clear command line
end

-- TODO: zen-mode doesn't provide a way to display the status line
local function status_line_refresh()
  local conceal_color = "%#Conceal#" -- set `Conceal` highlight color
  local date = "%{StatuslineDate()}" -- insert date
  local right_align = "%=" -- move to the right side of the status line
  local slide_number = "%{StatuslineSlideNumber()}" -- insert slide number
  return string.format(
    "%s%s%s%s",
    conceal_color,
    date,
    right_align,
    slide_number
  )
end

local function status_line_reset()
  return [[%f %h%w%m%r %=%(%l,%c%V %= %P%)]]
end

local opts = {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = true }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = true,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
    cmdline_clear()
    vim.opt.statusline = status_line_refresh()
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    vim.opt.statusline = status_line_reset()
  end,
}

require("zen-mode").setup(opts)
