#!/bin/bash

# Define colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting dotfiles setup...${NC}"

# 1. Check for Homebrew, install if missing
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e "${GREEN}Homebrew is already installed.${NC}"
fi

# 2. Install necessary tools
echo -e "${GREEN}Installing Stow, WezTerm, Neovim, and Starship...${NC}"
brew install stow wezterm nvim starship

# 3. Create .config directory if it doesn't exist
mkdir -p ~/.config

# 4. PRE-CLEANUP: Remove any default configs or .DS_Store junk
# This prevents the "Conflicts" error you saw earlier
echo -e "${GREEN}Cleaning up existing config paths to avoid conflicts...${NC}"
rm -rf ~/.config/wezterm
rm -rf ~/.config/nvim
rm -f ~/.config/starship.toml
rm -f ~/.config/.DS_Store
rm -f ~/.DS_Store

# 5. Use Stow to symlink the configs
echo -e "${GREEN}Symlinking configurations...${NC}"
cd ~/dotfiles
stow wezterm
stow nvim
stow starship

echo -e "${GREEN}Setup complete! Restart WezTerm or run 'source ~/.zshrc' to see changes.${NC}"
