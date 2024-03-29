# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/.local/bin:$HOME/bin:$PATH

if [ "$SSH_CONNECTION" ]; then

  # mrv: run zsh on Bash startup
  export SHELL=`which zsh`
  [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l

fi
