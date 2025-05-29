# My Dotfiles

Personal configuration files for my development environment.

## Installation

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

## What's included

- **zsh/**: Zsh configuration and Oh My Zsh setup
- **vim/**: Vim configuration and plugins
- **nvim/**: Neovim configuration 
- **i3/**: i3 window manager configuration
- **git/**: Git configuration
- **conda/**: Conda configuration
- **scripts/**: Useful shell scripts

## Manual steps after installation

1. Install Oh My Zsh: `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
2. Install vim plugins (if using vim-plug): `:PlugInstall`
3. Configure git user: `git config --global user.name "Your Name"`

## Updating

To update dotfiles:
```bash
cd ~/dotfiles
# Copy any new configs
cp ~/.zshrc zsh/
git add .
git commit -m "Update configs"
git push
```
