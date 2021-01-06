# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH
export VISUAL=nvim
export EDITOR="$VISUAL"
export LANG="en_US.UTF-8"
# export ARCHFLAGS="-arch x86_64"

# =============================================================================
# History
# =============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# =============================================================================
# Completion
# =============================================================================

autoload -U compinit

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files.

#bindkey '  ' autosuggest-accept
#bindkey '  ' complete-word
setopt noautomenu
setopt nomenucomplete

# Defines behavior of 'Tab'
# See: http://zsh.sourceforge.net/Guide/zshguide06.html
#bindkey '^ ' menu-complete
#bindkey '^ ' complete-word
bindkey '^ ' autosuggest-accept

# =============================================================================
# Prompt
# =============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"

# =============================================================================
# Plugins
# =============================================================================

if [ "$SSH_CONNECTION" ]; then
  echo TODO
else
  source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source "/usr/share/z/z.sh"
  [[ -s "/home/mroavi/.autojump/etc/profile.d/autojump.sh" ]] && source "/home/mroavi/.autojump/etc/profile.d/autojump.sh"
fi

#export ZSH="/home/mroavi/.oh-my-zsh"
#plugins=(
#  zsh-autosuggestions
#  zsh-syntax-highlighting
#)
#source $ZSH/oh-my-zsh.sh

# =============================================================================
# Colors
# =============================================================================

autoload -U colors && colors

# For GNU ls, we use the default ls color theme. They can later be overwritten by themes.
(( $+commands[dircolors] )) && eval "$(dircolors -b)"
ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
# vi-mode
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
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# =============================================================================
# Aliases
# =============================================================================

alias c="cd"
alias v="nvim"
alias jl="julia"
alias o="xdg-open"
alias l="ls -1"
alias lsa="ls -lah"
alias ll='ls -lh'
alias vpn="sudo openconnect --authgroup '2: Tunnel TU/e traffic' --background --pid-file /var/run/tuevpn.pid https://vpn2.tue.nl"
alias sz="source ~/.zshrc"
alias j="z"

# Dir bookmarks
alias dotfiles="cd ~/dotfiles"
alias phd="cd ~/Dropbox/TUe/PhD"

# Color schemes
alias off="base16_onedark"
alias on="base16_solarized-light"

# Git
alias g='git'
alias gst='git status'
alias ga='git add'
alias gc='git commit -v'
alias gp='git push'
alias gl='git pull'
alias glg='git log --stat'
alias gd='git diff'
alias gco='git checkout'

# =============================================================================
# Dir navigation
# =============================================================================
# Change directories without typing `cd`
setopt auto_cd

# Use Ctrl+u to go up one dir
bindkey -s '^u' 'cd ..^M'

# Directory stack navigation (use `popd` to go back in history)
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
bindkey -s '^p' 'popd^M' # Use Ctrl+p to go back one dir in history

# =============================================================================
# Miscellaneous
# =============================================================================

# Prompt at the bottom of the terminal (https://github.com/romkatv/powerlevel10k/issues/563)
clr () {
  printf '\n%.0s' {1..100}
}
clr

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
# z
# =============================================================================

unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

# =============================================================================
# FZF
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
export FZF_DEFAULT_OPTS='--height 40% --layout=default --multi'
#export FZF_DEFAULT_OPTS='--no-height --no-reverse'

# -----------------------------------------------------------------------------
# Configure shell key bindings
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# -----------------------------------------------------------------------------

# Use highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_CTRL_T_OPTS="--min-height 30 --preview-window down:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"

# Add preview to Alt-C
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# -----------------------------------------------------------------------------
# Integrate with ripgrep
# -----------------------------------------------------------------------------

# using ripgrep combined with preview
# usage: rg-fzf <searchTerm>
# https://github.com/junegunn/fzf/wiki/examples#searching-file-contents
rg-fzf() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# -----------------------------------------------------------------------------
# Integrate with Git (https://github.com/junegunn/fzf/wiki/Examples#git)
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
# Integrate with kill
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
# Integrate with pacman
# -----------------------------------------------------------------------------

# fuzzy-search through all available packages, with package info shown in a preview window, and then install selected packages:
# https://wiki.archlinux.org/index.php/Fzf
pacman-install() {
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

# browse all installed packages with an instant preview of each package
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks
pacman-installed() {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

# =============================================================================
# nnn
# =============================================================================

# Bookmarks
export NNN_BMS='r:~/repos/;D:~/Downloads/;s:~/Dropbox/TUe/PhD/software/;d:~/dotfiles/;P:~/Dropbox/TUe/PhD/;p:~/.local/share/nvim/plugged/'
export NNN_PLUG='j:fzz'
export NNN_COLORS='4321'

# =============================================================================
# Base16 Shell
# =============================================================================

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

## =============================================================================
## >>> conda initialize >>>
## =============================================================================
## !! Contents within this block are managed by 'conda init' !!
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
## <<< conda initialize <<<

# =============================================================================
# Start tmux automatically
# If not running interactively, do not do anything
# =============================================================================

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux a
  exec tmux
fi
