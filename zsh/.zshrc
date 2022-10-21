## Uncomment this and the last line in this file to profile 
## See https://stevenvanbael.com/profiling-zsh-startup
#zmodload zsh/zprof

export VISUAL=nvim
export EDITOR="$VISUAL"
export MANPAGER='nvim +Man!'
export LANG="en_US.UTF-8"
# export ARCHFLAGS="-arch x86_64"

if [ "$SSH_CONNECTION" ]; then
  export DISPLAY=:0
  # Used to run Tamaki's tool
  export JAVA_HOME=/home/20180043/jdk
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# =============================================================================
## History
# =============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# =============================================================================
## Completion
# =============================================================================

autoload -U compinit

zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files.

# Accept autosuggestions with Ctrl+Space
bindkey '^ ' autosuggest-accept

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
## Plugins
# =============================================================================

if [ "$SSH_CONNECTION" ]; then
  source "$HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
  source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

#export ZSH="/home/mroavi/.oh-my-zsh"
#plugins=(
#  zsh-autosuggestions
#  zsh-syntax-highlighting
#)
#source $ZSH/oh-my-zsh.sh

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

# Move up one dir with Ctrl-u
bindkey -s '^u' 'cd ..^M'

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

# Automatically run ls after every cd
# Source: https://stackoverflow.com/a/3964198/1706778
function chpwd() {
  emulate -L zsh
  ls -1 --color
}

# Disable Ctrl-S from freezing Vim
# See: https://unix.stackexchange.com/questions/332791/how-to-permanently-disable-ctrl-s-in-terminal
stty -ixon

# =============================================================================
## z
# =============================================================================

# Make sure that sourcing z.sh is placed after the fasd config where z is unaliased
if [ "$SSH_CONNECTION" ]; then
  source "$HOME/Downloads/z/z.sh"
else
  source "/usr/share/z/z.sh"
fi

# =============================================================================
## FZF
# =============================================================================

# Enable FZF (mrv: generated by FZF installer)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Custom FZF command that uses ripgrep (invoked by `:Files` command in fzf.vim)
# List of ripgrep options:
# - https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#common-options
# - https://github.com/junegunn/fzf#tips
# - https://www.reddit.com/r/linux4noobs/comments/egb644/fzf_newcomer_fd_or_ripgrep/
if [ ! "$SSH_CONNECTION" ]; then
  # export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
  export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Layout options
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --multi'
#export FZF_DEFAULT_OPTS='--no-height --no-reverse'

# -----------------------------------------------------------------------------
## Configure shell key bindings
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# -----------------------------------------------------------------------------

# Use highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_CTRL_T_OPTS="--min-height 30 --preview-window down:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"

# Add preview to Alt-C
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# -----------------------------------------------------------------------------
## Integrate with fasd
# -----------------------------------------------------------------------------
fasd-fzf() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
# Use Alt+j to call the function above
bindkey -s '^[j' 'fasd-fzf^M' 

# -----------------------------------------------------------------------------
## Integrate with ripgrep
# -----------------------------------------------------------------------------

# using ripgrep combined with preview
# usage: rg-fzf <searchTerm>
# https://github.com/junegunn/fzf/wiki/examples#searching-file-contents
rg-fzf() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# -----------------------------------------------------------------------------
## Integrate with Git (https://github.com/junegunn/fzf/wiki/Examples#git)
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
## Integrate with kill
# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------
## Integrate with pacman
# -----------------------------------------------------------------------------

# fuzzy-search through all available packages, with package info shown in a preview window, and then install selected packages:
# https://wiki.archlinux.org/index.php/Fzf
fzf-pacman-install() {
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

# browse all installed packages with an instant preview of each package
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks
fzf-pacman-list() {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

# =============================================================================
## fasd
# =============================================================================

eval "$(fasd --init auto)"

unalias a
unalias s
unalias d
unalias f
unalias sd
unalias sf
unalias z
unalias zz

alias j='fasd_cd -d' 

# =============================================================================
## Aliases
# =============================================================================

alias v="nvim"
alias vs="nvim -S"
alias jl="julia --project=@."
alias ijulia="julia --project=@. -e \"using IJulia; notebook(dir=pwd())\""
alias o="xdg-open"
alias t="tmux"
alias l="ls -1"
alias lsa="ls -lah"
alias ll='ls -lh'
alias vpn="sudo openconnect --authgroup '2: Tunnel TU/e traffic' --background --pid-file /var/run/tuevpn.pid https://vpn2.tue.nl"
alias pac="sudo pacman"
#alias bye="systemctl poweroff"
alias sz="du -h --max-depth=1 ."
alias temp="curl wttr.in/Eindhoven"

# Configuration managers
alias vol="alsamixer"
alias audio="pavucontrol"
alias blue="blueman-manager"
alias disp="arandr"
alias appearance="lxappearance"
alias wifiscan="nmcli dev wifi list"

# Dir bookmarks
alias d="cd ~/dotfiles"

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

# Audio
alias port1='pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-speaker'
alias port2='pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones'
alias sink1='pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo'
alias sink2='pactl set-default-sink bluez_output.38_18_4C_BC_F1_AC.a2dp-sink'

# Keyboard layout
alias en='setxkbmap -layout us -variant altgr-intl'
alias es='setxkbmap -layout es'

# =============================================================================
## >>> conda initialize >>> (contents within this block are managed by 'conda init' !!)
# =============================================================================

#__conda_setup="$('/home/mroavi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/mroavi/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/mroavi/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/mroavi/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup

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

# =============================================================================
## Start tmux automatically (if running interactively)
# =============================================================================

#if [ ! "$SSH_CONNECTION" ]; then
#  # https://unix.stackexchange.com/a/113768/184227
#  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#    #exec tmux a
#    exec tmux
#  fi
#fi

#if [ "$SSH_CONNECTION" ]; then
#  # https://unix.stackexchange.com/a/552619/184227
#  if [[ -z $TMUX ]] && [[ -n $SSH_TTY ]]; then
#    exec tmux new-session -A -s ssh
#  fi
#fi

## MRV: rvm increases the zsh startup time considerably
## Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Uncomment to profile
#zprof
