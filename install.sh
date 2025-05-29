#!/bin/bash

echo "Installing dotfiles..."

# Create backup directory
mkdir -p ~/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)

# Function to backup and link
backup_and_link() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ]; then
        echo "Backing up existing $target"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    echo "Linked $source -> $target"
}

# Get the dotfiles directory (where this script is located)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link dotfiles
backup_and_link "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
backup_and_link "$DOTFILES_DIR/vim/.vimrc" ~/.vimrc
backup_and_link "$DOTFILES_DIR/vim/.vim" ~/.vim
backup_and_link "$DOTFILES_DIR/nvim" ~/.config/nvim
backup_and_link "$DOTFILES_DIR/i3" ~/.config/i3
backup_and_link "$DOTFILES_DIR/i3blocks" ~/.config/i3blocks
backup_and_link "$DOTFILES_DIR/autorandr" ~/.config/autorandr
backup_and_link "$DOTFILES_DIR/bat" ~/.config/bat
backup_and_link "$DOTFILES_DIR/fontconfig" ~/.config/fontconfig
backup_and_link "$DOTFILES_DIR/git/config" ~/.config/git/config
backup_and_link "$DOTFILES_DIR/conda/condarc" ~/.config/conda/condarc

echo "Dotfiles installation complete!"
echo "Backups stored in: $BACKUP_DIR"
