export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export VISUAL=nvim
export EDITOR="$VISUAL"
export TERMINFO=/lib/terminfo
export MANPAGER='nvim +Man!'
export LANG="en_US.UTF-8"
export LUA_INIT="@${HOME}/.config/lua/startup.lua"
# export ARCHFLAGS="-arch x86_64"
export BAT_THEME="Catppuccin Mocha"
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
