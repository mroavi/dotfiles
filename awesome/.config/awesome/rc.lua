-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- mrv: Info on how to test and debug rc.lua
-- https://stackoverflow.com/a/70503451/1706778

--------------------------------------------------------------------------------
--- Error handling
--------------------------------------------------------------------------------

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

--------------------------------------------------------------------------------
--- Variable definitions
--------------------------------------------------------------------------------

-- Themes define colours, icons, font and wallpapers.
local my_theme = os.getenv("HOME").."/.config/awesome/theme.lua"
beautiful.init(my_theme)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    --awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

--------------------------------------------------------------------------------
--- Wibar
--------------------------------------------------------------------------------

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
                            if client.focus then
                                client.focus:move_to_tag(t)
                            end
                        end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
                            if client.focus then
                                client.focus:toggle_tag(t)
                            end
                        end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                s.mypromptbox,
            },
            nil,
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                s.mylayoutbox,
            },
        },
        {
            -- Middle widget
            mytextclock,
            valign = "center",
            halign = "center",
            layout = wibox.container.place
        },
    }
end)

--------------------------------------------------------------------------------
--- Mouse bindings
--------------------------------------------------------------------------------

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))

--------------------------------------------------------------------------------
--- Global key bindings
--------------------------------------------------------------------------------

globalkeys = gears.table.join(

    -- General
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Tag focus
    awful.key({ modkey,           }, "j",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "k",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "l", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Client focus
    awful.key({ modkey, altkey    }, "j", function ()
      awful.client.focus.global_bydirection("down")
    end,
              {description = "focus next window up", group = "client"}),
    awful.key({ modkey, altkey    }, "k", function ()
      awful.client.focus.global_bydirection("up")
    end,
              {description = "focus next window down", group = "client"}),
    awful.key({ modkey, altkey    }, "l", function ()
      awful.client.focus.global_bydirection("right")
    end,
              {description = "focus next window right", group = "client"}),
    awful.key({ modkey, altkey    }, "h", function ()
      awful.client.focus.global_bydirection("left")
    end,
              {description = "focus next window left", group = "client"}),
    awful.key({ modkey,           }, ";",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
              {description = "go back", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Swapping clients
    awful.key({ modkey, "Control" }, "h", function ()
      awful.client.swap.global_bydirection("left")
    end,
              {description = "swap with left client", group = "client"}),
    awful.key({ modkey, "Control" }, "l", function ()
      awful.client.swap.global_bydirection("right")
    end,
              {description = "swap with right client", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function ()
      awful.client.swap.global_bydirection("down")
    end,
              {description = "swap with down client", group = "client"}),
    awful.key({ modkey, "Control" }, "k", function ()
      awful.client.swap.global_bydirection("up")
    end,
              {description = "swap with up client", group = "client"}),

    -- Screen focus
    awful.key({ modkey, altkey    }, "o", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    ---- Master and column manipulation
    --awful.key({ modkey, "Shift"            }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --          {description = "increase the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Shift"            }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --          {description = "decrease the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Control"          }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --          {description = "increase the number of columns", group = "layout"}),
    --awful.key({ modkey, "Control"          }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --          {description = "decrease the number of columns", group = "layout"}),

    -- Swap layout
    awful.key({ modkey, "Control"          }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift", "Control" }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Restore minimized client
    awful.key({ modkey, "Shift", "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Terminal
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    -- Dmenu
    awful.key({ modkey            }, "space", function () awful.util.spawn("dmenu_run") end,
                    {description = "launch dmenu", group = "launcher"}),

    -- Launch nvim
    awful.key({ modkey, altkey }, "v", function () awful.util.spawn("alacritty -e nvim") end,
              {description = "launch nvim", group = "launcher"}),

    -- Launch flameshot
    awful.key({                }, "Print", function () awful.util.spawn("flameshot gui") end,
              {description = "launch flameshot", group = "launcher"}),

    -- Launch file manager
    awful.key({ modkey, altkey }, "f", function () awful.util.spawn("thunar") end,
              {description = "launch thunar", group = "launcher"}),

    -- Launch chrome
    awful.key({ modkey, altkey }, "b", function () awful.util.spawn("google-chrome-stable") end,
              {description = "launch chrome", group = "launcher"}),

    -- View screen 2, tag 4 (where normally chrome will be opened)
    awful.key({ modkey         }, "b" ,
              function ()
                    awful.screen.focus(2)                 -- change focus to screen 2
                    local screen = awful.screen.focused() -- get the focused screen object
                    local tag = screen.tags[4]            -- get the tag 4 object
                    if tag then
                        tag:view_only()                   -- change focus to tag 4
                    end
              end,
              {description = "view chrome tag", group = "tag"}),

    -- Execute Lua code
    awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    -- Enable keyboard volume control
    awful.key({}, "XF86AudioRaiseVolume", function ()
      awful.util.spawn("amixer -D pulse sset Master 2%+", false)
    end),
    awful.key({}, "XF86AudioLowerVolume", function ()
      awful.util.spawn("amixer -D pulse sset Master 2%-", false)
    end),
    awful.key({}, "XF86AudioMute", function ()
      awful.util.spawn("amixer -D pulse sset Master toggle", false)
    end),

    -- Lock system
    awful.key({ altkey, "Control" }, "l", function ()
      awful.util.spawn("xscreensaver-command -lock")
    end,
              {description = "launch xscreensaver", group = "launcher"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- View the first three tags on the focused screen with `modkey + {h,k,l}`
local tag_keys = {"m", ",", ".", "/"}
for i,v in ipairs(tag_keys) do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, v,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

--------------------------------------------------------------------------------
--- Client key bindings
--------------------------------------------------------------------------------

clientkeys = gears.table.join(

    -- Window states
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
              {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "x",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),

    -- Layout control
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),

    -- Move to screen
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    -- Resize windows
    awful.key({ modkey, "Shift", "Control" }, "k", function (c)
      if c.floating then
        c:relative_move( 0, 0, 0, -10)
      else
        awful.client.incwfact(-0.025)
      end
    end,
              {description = "Floating Resize Vertical -", group = "client"}),
    awful.key({ modkey, "Shift", "Control" }, "j", function (c)
      if c.floating then
        c:relative_move( 0, 0, 0,  10)
      else
        awful.client.incwfact(0.025)
      end
    end,
              {description = "Floating Resize Vertical +", group = "client"}),
    awful.key({ modkey, "Shift", "Control" }, "h", function (c)
      if c.floating then
        c:relative_move( 0, 0, -10, 0)
      else
        awful.tag.incmwfact(-0.025)
      end
    end,
              {description = "Floating Resize Horizontal -", group = "client"}),
    awful.key({ modkey, "Shift", "Control" }, "l", function (c)
      if c.floating then
        c:relative_move( 0, 0,  10, 0)
      else
        awful.tag.incmwfact(0.025)
      end
    end,
              {description = "Floating Resize Horizontal +", group = "client"}),

    -- Maximize/Unmaximize clients
    awful.key({ modkey, "Shift" }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
              {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Shift" }, "k",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
              {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift" }, "j",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
              {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "l",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
              {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modkey, "Shift"   }, "h",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
              {description = "(un)maximize horizontally", group = "client"}),

    -- Minimize client
    awful.key({ modkey, "Control" }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
              {description = "minimize", group = "client"}),

    -- Toggle keep on top
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"})

)

--------------------------------------------------------------------------------
--- Rules
--------------------------------------------------------------------------------

-- Rules to apply to new clients (through the "manage" signal).
-- mrv: see the `xprop` command line application to query properties for a client
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 0, -- beautiful.border_width, -- mrv: disable borders
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    ---- Set chrome to always map on the tag named "2" on screen 1.
    --{ rule = { class = "Google-chrome" },
    --  properties = { screen = 2, tag = "9", switch_to_tags = true,} },

}

--------------------------------------------------------------------------------
--- Signals
--------------------------------------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
     if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--------------------------------------------------------------------------------
--- Autostart applications
--------------------------------------------------------------------------------
awful.spawn.with_shell("picom --experimental-backends") -- enables transparency
awful.spawn.with_shell("dropbox")
awful.spawn.with_shell("xscreensaver -no-splash &") -- locks the system
awful.spawn.with_shell("blueman-applet") -- start bluetooth
awful.spawn.with_shell("flameshot") -- screenshot software

-- Change key repeat frequency
os.execute("xset r rate 260 60")
