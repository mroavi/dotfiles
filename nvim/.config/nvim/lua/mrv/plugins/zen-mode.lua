local api = vim.api
local fn = vim.fn

--------------------------------------------------------------------------------
--- Vars
--------------------------------------------------------------------------------

local M = {}

local ns = api.nvim_create_namespace('slides')
local date = fn.strftime("%b %d, %Y")

--------------------------------------------------------------------------------
--- Misc
--------------------------------------------------------------------------------

local function cmdline_clear()
  local key = vim.api.nvim_replace_termcodes("<C-l>", true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false) -- clear command line
end

--------------------------------------------------------------------------------
--- Slide status
--------------------------------------------------------------------------------

local function slide_status_update(win)

  local slide_num = 'slide ' .. (fn.argidx() + 1) .. ' / ' .. fn.argc()

  --local line = api.nvim_win_get_height(win) - 1
  local line = 0
  local col = 0
  local opts = {
    end_line = 10,
    id = 1,
    virt_text = { { date, "Conceal" } },
    virt_text_pos = 'overlay',
    --virt_text_pos = 'right_align',
    strict = false, -- allows extmarks to be placed past the `line` and `col` values
  }
  api.nvim_buf_set_extmark(0, ns, line, col, opts) -- :h extmarks
end

local function slide_status_clear()
  local extmarks = api.nvim_buf_get_extmarks(0, ns, 0, -1, {}) -- returns list of [extmark_id, row, col] tuples
  --print(vim.inspect(extmarks))
  for _, extmark in ipairs(extmarks) do
    api.nvim_buf_del_extmark(0, ns, extmark[1])
  end
end

--------------------------------------------------------------------------------
--- On open callback
--------------------------------------------------------------------------------

local function on_open_zen_mode(win)

  vim.cmd("message clear") -- DEBUG (temp)

  cmdline_clear()

  M.augroup_slide_status = vim.api.nvim_create_augroup("slide_status", { clear = true })

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.sld",
    callback = function() slide_status_update(win) end,
    --command = "echom 'BufEnter event'", -- debug
    group = M.augroup_slide_status,
  })

  vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*.sld",
    callback = function() slide_status_clear() end,
    --command = "echom 'BufLeave event'", -- debug
    group = M.augroup_slide_status,
  })

  slide_status_update(win) -- the `BufEnter` event does not trigger when the first slide opens

end

--------------------------------------------------------------------------------
--- On close callback
--------------------------------------------------------------------------------

local function on_close_zen_mode()
  api.nvim_del_augroup_by_id(M.augroup_slide_status)
  slide_status_clear() -- needed since apparently `BufEnter` triggers one last time after closing
end

--------------------------------------------------------------------------------
--- Setup options
--------------------------------------------------------------------------------

local opts = {
  window = {
    backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 80, -- width of the Zen window -- WARNING: the starting column changes for some slides
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
  on_open = on_open_zen_mode,
  -- callback where you can add custom code when the Zen window closes
  on_close = on_close_zen_mode,
}

-- WARNING: fix the ZenBg highlight color. For some reason it gets darken from #282828 to #262626
-- inside config.lua using the `util.darken` function
require("zen-mode").setup(opts)
--require("zen-mode").setup()
