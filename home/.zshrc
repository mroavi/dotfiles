# ▶ mrv: Set theme (use one)
THEME=solarized-dark
#THEME=solarized-light
#THEME=gruvbox8-dark
#THEME=onedark
#THEME=palenight
#THEME=material

# mrv: To cleanly kill all tmux open sessions (and server) run:
# tmux kill-server

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mroavi/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="pygmalion"
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
#DISABLE_LS_COLORS="true"

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

# mrv: go to dotfiles home dir 
alias dotfiles="cd ~/.homesick/repos/dotfiles/home"

# mrv: connect to TU/e's VPN
alias vpn="sudo openconnect --authgroup '2: Tunnel TU/e traffic' --background --pid-file /var/run/tuevpn.pid https://vpn2.tue.nl"

# mrv: cd to the paper I'm currently writing (temp)
alias paper="cd ~/Dropbox/Apps/Overleaf/Martin-2020-SCOPES-Real-Time-Audio-Processing-in-Julia-for-Hearing-Aids" 

# mrv: shortcut for vim
alias v="vim"

# mrv: shortcut to open files
alias o="xdg-open"

# mrv: shortcut to exit files
alias e="exit"

## mrv: use a function to alias ls -al with k -ha
## see: https://superuser.com/questions/105375/bash-spaces-in-alias-name
#ls() { if [[ $@ == "-al" ]]; then k -ha; else k "$@"; fi; }

## mrv (from .bashrc):  enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'

#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

## mrv: Set vi mode! (using oh-my-zsh plugin for now)
#set -o vi

# enable FZF (mrv: installed by FZF installer)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# mrv: Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=2

# mrv: disable auto cd
# see https://unix.stackexchange.com/questions/126719/how-to-disable-auto-cd-in-zsh-with-oh-my-zsh
unsetopt AUTO_CD

# ===============================================
# Configure theme 
# ===============================================

if [ "$THEME" = "solarized-dark" ]; then

    # replace the colorscheme, background and airline config line in .vimrc
    sed -i --follow-symlinks 's/colorscheme.*/colorscheme solarized8_high/g' ~/.vimrc
    sed -i --follow-symlinks 's/set background=.*/set background=dark/g' ~/.vimrc
    sed -i --follow-symlinks "s/let g:airline_theme=.*/let g:airline_theme='solarized'/g" ~/.vimrc

    # mrv: Change zsh-autosuggestions color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

    # Reload .Xresources with the theme's flag
    xrdb -DUSE_SOLARIZED_DARK ~/.Xresources

    # Set the colorscheme in .alacritty.yml
    sed -i --follow-symlinks "s/colors: \*.*/colors: \*solarized-dark/g" ~/.alacritty.yml

    # Set vifm's colorscheme
    sed -i --follow-symlinks "s/colorscheme .*/colorscheme solarized-dark/g" ~/.vifm/vifmrc

elif [ "$THEME" = "solarized-light" ]; then
    
    sed -i --follow-symlinks 's/colorscheme.*/colorscheme solarized8/g' ~/.vimrc
    sed -i --follow-symlinks 's/set background=.*/set background=light/g' ~/.vimrc
    sed -i --follow-symlinks "s/let g:airline_theme=.*/let g:airline_theme='solarized'/g" ~/.vimrc
    sed -i --follow-symlinks "s/colors: \*.*/colors: \*solarized-light/g" ~/.alacritty.yml
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'
    xrdb -DUSE_SOLARIZED_LIGHT ~/.Xresources
    sed -i --follow-symlinks "s/colorscheme .*/colorscheme solarized-dark/g" ~/.vifm/vifmrc

elif [ "$THEME" = "gruvbox8-dark" ]; then
    
    sed -i --follow-symlinks 's/colorscheme.*/colorscheme gruvbox8_hard/g' ~/.vimrc
    sed -i --follow-symlinks 's/set background=.*/set background=dark/g' ~/.vimrc
    sed -i --follow-symlinks "s/let g:airline_theme=.*/let g:airline_theme='base16_gruvbox_dark_hard'/g" ~/.vimrc
    sed -i --follow-symlinks "s/colors: \*.*/colors: \*gruvbox/g" ~/.alacritty.yml
    xrdb -DUSE_GRUVBOX_DARK ~/.Xresources
    sed -i --follow-symlinks "s/colorscheme .*/colorscheme gruvbox/g" ~/.vifm/vifmrc
    
elif [ "$THEME" = "onedark" ]; then

    sed -i --follow-symlinks 's/colorscheme.*/colorscheme onedark/g' ~/.vimrc
    sed -i --follow-symlinks 's/set background=.*/set background=dark/g' ~/.vimrc
    sed -i --follow-symlinks "s/let g:airline_theme=.*/let g:airline_theme='onedark'/g" ~/.vimrc
    sed -i --follow-symlinks "s/colors: \*.*/colors: \*onedark/g" ~/.alacritty.yml
    xrdb -DUSE_ONEDARK ~/.Xresources
    sed -i --follow-symlinks "s/colorscheme .*/colorscheme onedark/g" ~/.vifm/vifmrc
    
elif [ "$THEME" = "palenight" ]; then

    sed -i --follow-symlinks 's/colorscheme.*/colorscheme palenight/g' ~/.vimrc
    sed -i --follow-symlinks 's/set background=.*/set background=dark/g' ~/.vimrc
    sed -i --follow-symlinks "s/let g:airline_theme=.*/let g:airline_theme='palenight'/g" ~/.vimrc
    sed -i --follow-symlinks "s/colors: \*.*/colors: \*palenight/g" ~/.alacritty.yml
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    xrdb -DUSE_PALENIGHT ~/.Xresources
    sed -i --follow-symlinks "s/colorscheme .*/colorscheme palenight/g" ~/.vifm/vifmrc
    
 elif [ "$THEME" = "material" ]; then

    sed -i --follow-symlinks 's/colorscheme.*/colorscheme material-theme/g' ~/.vimrc
    sed -i --follow-symlinks 's/set background=.*/set background=dark/g' ~/.vimrc
    sed -i --follow-symlinks "s/let g:airline_theme=.*/let g:airline_theme='hybrid'/g" ~/.vimrc
    sed -i --follow-symlinks "s/colors: \*.*/colors: \*material/g" ~/.alacritty.yml
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'
    xrdb -DUSE_MATERIAL ~/.Xresources
    sed -i --follow-symlinks "s/colorscheme .*/colorscheme palenight/g" ~/.vifm/vifmrc
    
else
    
    echo "Using default theme"
    xrdb ~/.Xresources
    
fi

# ===============================================
# Custom key binding
# ===============================================

# Important: place this at the end since other commands (such as enabling FZF) override it
#bindkey '	' autosuggest-accept
#bindkey '	' complete-word
setopt noautomenu
setopt nomenucomplete

# Defines behavior of 'Tab' (default in ohmyzsh is 'menu-complete') 
# See: http://zsh.sourceforge.net/Guide/zshguide06.html
#bindkey '^ ' menu-complete
#bindkey '^ ' complete-word
bindkey '^ ' autosuggest-accept

# mrv: Switch to normal mode using 'jk' (specific to zsh(?))
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

# mrv: Disable Ctrl-S from freezing Vim 
# See: https://unix.stackexchange.com/questions/332791/how-to-permanently-disable-ctrl-s-in-terminal
stty -ixon


## mrv: Start up tmux automatically
## If not running interactively, do not do anything
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux a
fi
