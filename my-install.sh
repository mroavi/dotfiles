# Save current directory
currentdir="$PWD"

# -----------------------------------------------------------------------------------------
echo "Installing zsh..."
sudo apt install zsh

# -----------------------------------------------------------------------------------------
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# -----------------------------------------------------------------------------------------
echo "Installing Powerlevel10k (or pulling if repo already exists)..."
# Add powerlevel10k to the list of Oh My Zsh themes.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k 2> /dev/null || git -C $ZSH_CUSTOM/themes/powerlevel10k pull 

#git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 2> /dev/null || git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull

# -----------------------------------------------------------------------------------------
echo "Installing Fonts..."
# See installed mono fonts: 
# fc-list :scalable=true:spacing=mono: family

mkdir -p ~/.local/share/fonts

# Hack Nerd Font
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
cd ~/.local/share/fonts && curl -fLo "Hack-for-Powerline-Nerd-Font-regular-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
cd ~/.local/share/fonts && curl -fLo "Hack-for-Powerline-Nerd-Font-bold-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf
cd ~/.local/share/fonts && curl -fLo "Hack-for-Powerline-Nerd-Font-italic-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf
cd ~/.local/share/fonts && curl -fLo "Hack-for-Powerline-Nerd-Font-bold-italic-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf

# MesloLGS NF font (recommended for Powerlevel10k)
# https://github.com/romkatv/powerlevel10k#powerlevel9k-compatibility
cd ~/.local/share/fonts && curl -fLo "MesloLGS-NF-Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
cd ~/.local/share/fonts && curl -fLo "MesloLGS-NF-Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
cd ~/.local/share/fonts && curl -fLo "MesloLGS-NF-Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
cd ~/.local/share/fonts && curl -fLo "MesloLGS-NF-Bold-Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Awesome Terminal font
# https://github.com/gabrielelana/awesome-terminal-fonts/tree/patching-strategy/patched
cd ~/.local/share/fonts && curl -fLo "Droid-Sans-Mono-Awesome.ttf" https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Droid%2BSans%2BMono%2BAwesome.ttf
cd ~/.local/share/fonts && curl -fLo "Inconsolata-Awesome.ttf" https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf
cd ~/.local/share/fonts && curl -fLo "SourceCodePro-Powerline-Awesome-Regular.ttf" https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf

# -----------------------------------------------------------------------------------------
echo "Installing clangd and YouCompleteMe..."

sudo apt-get install clangd-9
sudo apt install build-essential cmake vim python3-dev
#cd ~/.vim/bundle/YouCompleteMe
#python3 install.py --clangd-completer

# -----------------------------------------------------------------------------------------
echo "Installing ripgrep..."
sudo curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo sudo dpkg -i ripgrep_11.0.2_amd64.deb

# -----------------------------------------------------------------------------------------
# https://computingforgeeks.com/bat-cat-command-with-syntax-highlighting-and-git-integration/ 
echo "Installing bat..."

sudo apt-get install wget
export VER="0.13.0"
wget https://github.com/sharkdp/bat/releases/download/v${VER}/bat_${VER}_amd64.deb
sudo dpkg -i bat_${VER}_amd64.deb


# Return to original directory
cd "$currentdir"

# TODO: install xclip
