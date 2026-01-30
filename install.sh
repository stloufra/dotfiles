#!/bin/bash
install_bare_ALMA(){
    echo "================================================================"
    echo "Installing bare minimimum for ALMA"
    echo "================================================================"

    ./install_vim.sh

    sudo dnf install bash-completion 
    git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --key-bindings --completion --no-update-rc
    git clone https://github.com/dvorka/hstr.git ~/.hstr && cd ~/.hstr && sudo make install
    git clone https://github.com/rcaloras/bash-preexec ~/.bash-preexec && echo 'source ~/.bash-preexec/bash-preexec.sh' >> ~/.bashrc
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.bash-syntax-highlighting
}

configure_git(){
  git config --global user.email "frantisek.stloukal@cern.ch"
  git config --global user.name  "stloufra"
}

echo "================================================================"
echo "Installing dotfiles..."
echo "================================================================"

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
backup_and_link "$DOTFILES_DIR/bat" ~/.config/bat
backup_and_link "$DOTFILES_DIR/vim/.vimrc" ~/.vimrc
backup_and_link "$DOTFILES_DIR/vim/.vim" ~/.vim
backup_and_link "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc
backup_and_link "$DOTFILES_DIR/bash/.inputrc" ~/.inputrc

#backup_and_link "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
#backup_and_link "$DOTFILES_DIR/nvim" ~/.config/nvim
#backup_and_link "$DOTFILES_DIR/i3" ~/.config/i3
#backup_and_link "$DOTFILES_DIR/i3blocks" ~/.config/i3blocks
#backup_and_link "$DOTFILES_DIR/autorandr" ~/.config/autorandr
#backup_and_link "$DOTFILES_DIR/fontconfig" ~/.config/fontconfig
#backup_and_link "$DOTFILES_DIR/git/config" ~/.config/git/config
#backup_and_link "$DOTFILES_DIR/conda/condarc" ~/.config/conda/condarc

echo "================================================================"
echo "Dotfiles installation complete!"
echo "Backups stored in: $BACKUP_DIR"
echo "================================================================"

while true; do
    read -p "Do you wish to install bare minimum for ALMA (Vim9, quality of life, fzf..)[y/n]? " yn
    case $yn in
        [Yy]* ) install_bare_ALMA; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "================================================================"
while true; do
    read -p "Do you want to configure git for FS[y/n]?" yn
    case $yn in
        [Yy]* ) configure_git; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


echo "================================================================"
echo "Please run following commands"
echo " source ~/.bashrc && bind -f ~/.inputrc"
echo "================================================================"
