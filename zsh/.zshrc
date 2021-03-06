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

zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files.

# Accept autosuggestions with Ctrl+Space
bindkey '^ ' autosuggest-accept

# Auto complete with case insenstivity
zstyle ':completion:*' menu select=1
bindkey -M menuselect '' .send-break # break from menu with tab

# Defines behavior of 'Tab'
#bindkey '  ' autosuggest-accept
#bindkey '  ' complete-word

#setopt noautomenu
#setopt nomenucomplete

# See: http://zsh.sourceforge.net/Guide/zshguide06.html
#bindkey '^ ' menu-complete
#bindkey '^ ' complete-word

# =============================================================================
# Prompt
# =============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [ "$SSH_CONNECTION" ]; then
  source "$HOME/.local/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme"
else
  source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
fi

# =============================================================================
# Plugins
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
echo -ne '\e[5 q' # use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # use beam shape cursor for each new prompt.

# =============================================================================
# Aliases
# =============================================================================

alias v="nvim"
alias jl="julia"
alias o="xdg-open"
alias l="ls -1"
alias lsa="ls -lah"
alias ll='ls -lh'
alias vpn="sudo openconnect --authgroup '2: Tunnel TU/e traffic' --background --pid-file /var/run/tuevpn.pid https://vpn2.tue.nl"

# Dir bookmarks
alias dotfiles="cd ~/dotfiles"
alias phd="cd ~/Dropbox/TUe/PhD"

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

## Move up one dir with Alt-h
#bindkey -s '^[h' 'cd ..^M'

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
# fasd
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
# Integrate with fasd
# -----------------------------------------------------------------------------
z() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

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

## =============================================================================
## pip zsh completion start (generated with `pip completion -z`)
## =============================================================================
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
# Start tmux automatically
# If not running interactively, do not do anything
# =============================================================================

if [ "$SSH_CONNECTION" ]; then
  # https://unix.stackexchange.com/a/552619/184227
  if [[ -z $TMUX ]] && [[ -n $SSH_TTY ]]; then
    exec tmux new-session -A -s ssh
  fi
else
  # https://unix.stackexchange.com/a/113768/184227
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux a
    #exec tmux
  fi
fi

