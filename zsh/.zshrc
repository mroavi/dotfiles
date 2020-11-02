# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH
export VISUAL=nvim
export EDITOR="$VISUAL"
export LANG="en_US.UTF-8"

# Path to your oh-my-zsh installation.
if [ "$SSH_CONNECTION" ]; then
  export ZSH="/home/20180043/.oh-my-zsh"
else
  export ZSH="/home/mroavi/.oh-my-zsh"
fi

# Set name of the theme to load
#ZSH_THEME="pygmalion"
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Prompt at the bottom of the terminal (https://github.com/romkatv/powerlevel10k/issues/563)
clr () {
  printf '\n%.0s' {1..100}
}
clr

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  vi-mode
  z
  autojump
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias v="nvim"
alias jl="julia"
alias o="xdg-open"
alias l="ls -1"
alias vpn="sudo openconnect --authgroup '2: Tunnel TU/e traffic' --background --pid-file /var/run/tuevpn.pid https://vpn2.tue.nl"
alias dotfiles="cd ~/dotfiles"
alias phd="cd ~/Dropbox/TUe/PhD"
alias sz="source ~/.zshrc"
alias off="base16_material"
alias on="base16_solarized-light"

alias cs1="base16_material"
alias cs2="base16_tomorrow"
alias cs3="base16_github"
alias cs4="base16_oceanicnext"
alias cs5="base16_tomorrow-night"
alias cs6="base16_onedark"
alias cs7="base16_gruvbox-dark-hard"
alias cs8="base16_dracula"
alias cs9="base16_solarized-dark"
alias cs0="base16_seti"

# Handy clear and list all
cls () {
  clr
  lsa
}

# mrv: Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=2

# mrv: disable auto cd
# see https://unix.stackexchange.com/questions/126719/how-to-disable-auto-cd-in-zsh-with-oh-my-zsh
unsetopt AUTO_CD

# =============================================================================
# Configure FZF
# =============================================================================

# Enable FZF (mrv: installed by FZF installer)
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
# j - Integrate with autojump
# -----------------------------------------------------------------------------

# Like normal autojump when used with arguments but displays an fzf prompt when used without
j() {
  if [[ "$#" -ne 0 ]]; then
    cd $(autojump $@)
    return
  fi
  cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
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
# Configure nnn
# =============================================================================

# Bookmarks
export NNN_BMS='r:~/repos/;D:~/Downloads/;s:~/Dropbox/TUe/PhD/software/;d:~/dotfiles/;P:~/Dropbox/TUe/PhD/;p:~/.local/share/nvim/plugged/'
export NNN_PLUG='j:fzz'
export NNN_COLORS='4321'

# =============================================================================
# Custom key bindings
# =============================================================================

# Important: place this at the end since other commands (such as enabling FZF) override it
#bindkey '  ' autosuggest-accept
#bindkey '  ' complete-word
setopt noautomenu
setopt nomenucomplete

# Defines behavior of 'Tab' (default in ohmyzsh is 'menu-complete')
# See: http://zsh.sourceforge.net/Guide/zshguide06.html
#bindkey '^ ' menu-complete
#bindkey '^ ' complete-word
bindkey '^ ' autosuggest-accept

# mrv: Disable Ctrl-S from freezing Vim
# See: https://unix.stackexchange.com/questions/332791/how-to-permanently-disable-ctrl-s-in-terminal
stty -ixon

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
# Change cursor shape for different vi modes.
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# =============================================================================

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
# mrv: Start up tmux automatically
# If not running interactively, do not do anything
# =============================================================================
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux a
  exec tmux
fi
