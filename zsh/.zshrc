## Uncomment this and the last line in this file to profile 
## See https://stevenvanbael.com/profiling-zsh-startup
#zmodload zsh/zprof

if [ "$SSH_CONNECTION" ]; then
  # Used to run Tamaki's tool
  export JAVA_HOME=/home/20180043/jdk
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# =============================================================================
## History
# =============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_EXPIRE_DUPS_FIRST # expire duplicate entries first when trimming history
setopt HIST_IGNORE_ALL_DUPS # delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS # ignore duplicates when searching through history (e.g., with Ctrl+R)
setopt HIST_REDUCE_BLANKS # remove superfluous blanks before recording entry

# =============================================================================
## Plugins
# =============================================================================

# zsh-autosuggestions paths
zsh_autosuggestions_local_path="$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
zsh_autosuggestions_system_path="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
zsh_autosuggestions_ubuntu_path="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Check for zsh-autosuggestions and source the appropriate file
if [ -f "$zsh_autosuggestions_local_path" ]; then
  source "$zsh_autosuggestions_local_path"
elif [ -f "$zsh_autosuggestions_system_path" ]; then
  source "$zsh_autosuggestions_system_path"
elif [ -f "$zsh_autosuggestions_ubuntu_path" ]; then
  source "$zsh_autosuggestions_ubuntu_path"
else
  echo "zsh_autosuggestions not found to source"
fi

# zsh-syntax-highlighting paths
zsh_syntax_highlighting_local_path="$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
zsh_syntax_highlighting_system_path="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
zsh_syntax_highlighting_ubuntu_path="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Check for zsh-syntax-highlighting and source the appropriate file
if [ -f "$zsh_syntax_highlighting_local_path" ]; then
  source "$zsh_syntax_highlighting_local_path"
elif [ -f "$zsh_syntax_highlighting_system_path" ]; then
  source "$zsh_syntax_highlighting_system_path"
elif [ -f "$zsh_syntax_highlighting_ubuntu_path" ]; then
  source "$zsh_syntax_highlighting_ubuntu_path"
else
  echo "zsh_syntax_highlighting not found to source"
fi

# =============================================================================
## Colors
# =============================================================================

autoload -U colors && colors

# For GNU ls, we use the default ls color theme. They can later be overwritten by themes.
(( $+commands[dircolors] )) && eval "$(dircolors -b)"
ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
## vi-mode
# =============================================================================

bindkey -v

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=2

# Change cursor shape for different vi modes.
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # use beam shape cursor for each new prompt.

# =============================================================================
## Completion
# =============================================================================

autoload -U compinit

zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files.

# Accept autosuggestions with Ctrl+j
bindkey '^j' autosuggest-accept

# Auto complete with case insenstivity
zstyle ':completion:*' menu select=1
bindkey -M menuselect '' .send-break # break from menu with escape

# Use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Defines behavior of 'Tab'
#bindkey '  ' autosuggest-accept
#bindkey '  ' complete-word

#setopt noautomenu
#setopt nomenucomplete

# See: http://zsh.sourceforge.net/Guide/zshguide06.html
#bindkey '^ ' menu-complete
#bindkey '^ ' complete-word

# =============================================================================
## Prompt
# =============================================================================

fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure

zstyle :prompt:pure:prompt:success  color green
zstyle :prompt:pure:git:branch      color green
zstyle :prompt:pure:git:arrow       color yellow

zstyle :prompt:pure:git:stash show yes

# =============================================================================
## Dir navigation
# =============================================================================

# Change directories without typing `cd`
setopt auto_cd

# Move up one dir with Ctrl-k
bindkey -s '^k' 'cd ..^M'

# Navigate through command history with Ctrl-P and Ctrl-N
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Directory stack navigation (use `popd` to go back in history)
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
bindkey -s '^o' 'popd^M' # Use Ctrl+o to go back one dir in history

# =============================================================================
## Miscellaneous
# =============================================================================

# Prompt at the bottom of the terminal (https://github.com/romkatv/powerlevel10k/issues/563)
clr () {
  printf '\n%.0s' {1..100}
}
clr

# Clear screen with Ctrl-L and leave prompt at the bottom of the terminal
bindkey -s '^l' 'clr^M'

# Automatically run eza or ls after every cd
# Source: https://stackoverflow.com/a/3964198/1706778
function chpwd() {
  emulate -L zsh
  if command -v eza &> /dev/null; then
    eza -1 --icons=auto
  else
    ls -1 --color
  fi
}

# Disable Ctrl-S from freezing Vim
# See: https://unix.stackexchange.com/questions/332791/how-to-permanently-disable-ctrl-s-in-terminal
stty -ixon

# Function to easily extract files from CLI
# https://bbs.archlinux.org/viewtopic.php?id=89216
# Usage: extract foo.bar
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *.exe)       cabextract $1  ;;
      *)           echo "\`$1': unrecognized file compression" ;;
    esac
  else
    echo "\`$1' is not a valid file"
  fi
}

# =============================================================================
## FZF
# =============================================================================

# Enable optional FZF key-bindings in arch (https://wiki.archlinux.org/title/Fzf)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
# Enable optional FZF key-bindings in Ubuntu
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# Use fd as backend
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --multi'
#export FZF_DEFAULT_OPTS='--no-height --no-reverse'

#export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
#export FZF_CTRL_T_OPTS="--min-height 30 --preview-window down:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"
#export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

## Configure theme ------------------------------------------------------------

fg="#cdd6f4"
bg_highlight="#313244"
purple="#b4befe"
blue="#89b4fa"
cyan="#89dceb"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:${fg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},\
info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

## Integrate with ripgrep -----------------------------------------------------

# using ripgrep combined with preview
# usage: fzf-rg <searchTerm>
# https://github.com/junegunn/fzf/wiki/examples#searching-file-contents
fzf-rg() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" |\
    fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

## Integrate with Git (https://github.com/junegunn/fzf/wiki/Examples#git) -----

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# Checkout git commit with previews
fzf-gco() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi --height 100% \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# Git commit browser with previews
fzf-glg() {
  glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi --height 100% \
      --ansi --preview="$_viewGitLogLine" \
      --header "enter to view, alt-y to copy hash" \
      --bind "enter:execute:$_viewGitLogLine   | less -R" \
      --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

## Integrate with kill --------------------------------------------------------

# List only the ones you can kill
fzf-kill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

## Integrate with pacman ------------------------------------------------------

# Fuzzy-search through all available packages, with package info shown in a preview window, and then install selected packages:
# https://wiki.archlinux.org/index.php/Fzf
fzf-pacman-install() {
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

# Browse all installed packages with an instant preview of each package
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks
fzf-pacman-list() {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

# =============================================================================
## Color terminal background in an SSH connection based on the hostname
# https://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/
# =============================================================================

color-ssh() {
  trap "colorterm.sh" INT EXIT
  colorterm.sh "$@"
  ssh "$@"
}
compdef _ssh color-ssh=ssh
alias ssh=color-ssh

# =============================================================================
## zoxide
# =============================================================================

# Database file located at ~/.local/share/zoxide/db.zo

eval "$(zoxide init zsh)"

alias cd="z" 

# =============================================================================
## lf
# =============================================================================

# Source: https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh
# Change working dir in shell to last dir in lf on exit (adapted from ranger).

lfcd () {
#lf () {
  tmp="$(mktemp)"
  # `command` is needed in case `lfcd` is aliased to `lf`
  command lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}

# =============================================================================
## Aliases
# =============================================================================

alias v="nvim"
alias vs="nvim -S"
alias jl="julia --project=@."
alias ijulia="julia --project=@. -e \"using IJulia; notebook(dir=pwd())\""
alias o="xdg-open"
alias t="tmux"
alias ta="tmux attach"
#alias vpn-tue="sudo openconnect --authgroup '2: Tunnel TU/e traffic' --background --pid-file /var/run/tuevpn.pid https://vpn2.tue.nl"
alias vpn-tue="eduvpn-gui"
alias vpn-fontys="/opt/cisco/anyconnect/bin/vpnui"
alias pac="sudo pacman"
alias sz="sudo du -h --max-depth=1 . | sort -hr"
alias temperature="curl wttr.in/Eindhoven"
alias clean-onedrive='find ~/OneDrive/fontys/ -iname "bin" -o -iname "obj" -o -iname ".vs" | xargs rm -rf'

# Use eza if installed, fallback to ls otherwise
if command -v eza &> /dev/null; then
  alias l="eza -1 --icons=auto"
  alias lsa="eza -lah --icons=auto"
  alias ll="eza -lh --icons=auto"
else
  alias l="ls -1"
  alias lsa="ls -lah"
  alias ll="ls -lh"
fi

# Configuration managers
alias vol="alsamixer"
alias audio="pavucontrol"
alias bt="bluetoothctl"
alias disp="arandr"
alias appearance="lxappearance"
alias wifiscan="nmcli dev wifi list"
alias venv="python -m venv venv && source ./venv/bin/activate"
alias venvr="python -m venv venv && source ./venv/bin/activate && pip install -r requirements.txt"

# Dir bookmarks
alias d="cd ~/dotfiles"
alias n="cd ~/notes"

# Git
alias g='git'
alias gst='git status'
alias ga='git add'
alias gc='git commit -v'
alias gp='git push'
alias gl='git pull'
alias glg='git log'
alias gd='git diff'
alias gco='git checkout'
alias gca='git commit -v --amend'
alias gb='git branch'
alias gm='git merge'
alias gop='git open'

# Audio
alias port1='pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-speaker'
alias port2='pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones'
alias sink1='pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo'
alias sink2='pactl set-default-sink bluez_output.38_18_4C_BC_F1_AC.a2dp-sink'

# Keyboard layout
alias en='setxkbmap -layout us -variant altgr-intl'
alias es='setxkbmap -layout es'

# =============================================================================
## pyenv
# =============================================================================

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# =============================================================================
## ros2
# =============================================================================

# Source ROS setup file if it exists
#[ -f /opt/ros/humble/setup.zsh ] && source /opt/ros/humble/setup.zsh
[ -f /opt/ros/foxy/setup.zsh ] && source /opt/ros/foxy/setup.zsh

# Check if inside a distrobox container
if [ -n "$CONTAINER_ID" ]; then
  # Change the Pure prompt symbol to indicate a distrobox container
  export PURE_PROMPT_SYMBOL="📦"
fi

## ---------------------------------------------------------------------------
## Enable autocompletion for Humble ROS 2 and Colcon
## This approach fixes the problem described in:
## https://answers.ros.org/question/417373/
#_enable_ros2_colcon_autocomplete() {
#  if command -v register-python-argcomplete3 &> /dev/null; then
#    eval "$(register-python-argcomplete3 ros2)"
#    eval "$(register-python-argcomplete3 colcon)"
#  fi
#}

## Function to source install/setup.zsh and restore autocompletion
#source_install_setup_and_fix_autocomplete() {
#  if [ -f install/setup.zsh ]; then
#    source install/setup.zsh
#    _enable_ros2_colcon_autocomplete
#  else
#    echo "install/setup.zsh not found in the current directory."
#  fi
#}

## Enable autocompletion initially
#_enable_ros2_colcon_autocomplete
## ---------------------------------------------------------------------------

# =============================================================================
## pip zsh completion start (generated with `pip completion -z`)
# =============================================================================

#function _pip_completion {
#  local words cword
#  read -Ac words
#  read -cn cword
#  reply=( $( COMP_WORDS="$words[*]" \
#             COMP_CWORD=$(( cword-1 )) \
#             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
#}
#compctl -K _pip_completion pip

## mrv: rvm increases the zsh startup time considerably
## Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Run pokemon-colorscripts if installed
if command -v pokemon-colorscripts &> /dev/null; then
  pokemon-colorscripts -r 1 --no-title
fi

## Uncomment to profile
#zprof
