# Save current directory
currentdir="$PWD"

# -----------------------------------------------------------------------------------------
echo "Installing zsh..."
sudo apt install zsh

# -----------------------------------------------------------------------------------------
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# -----------------------------------------------------------------------------------------
echo "Installing Powerlevel9k (or pulling if repo already exists)..."
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 2> /dev/null || git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull

# -----------------------------------------------------------------------------------------
echo "Installing Nerd Fonts..."
# See all Nerd fonts here: 
#    https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts
# See installed mono fonts: 
#    fc-list :scalable=true:spacing=mono: family

mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts && curl -fLo "UbuntuMono-for-Powerline-Nerd-Font-regular-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete%20Mono.ttf

cd ~/.local/share/fonts && curl -fLo "Hack-for-Powerline-Nerd-Font-regular-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf

cd ~/.local/share/fonts && curl -fLo "UbuntuMono-for-Powerline-Nerd-Font-regular-complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf

# -----------------------------------------------------------------------------------------
# Return to originatl directory
cd "$currentdir"
