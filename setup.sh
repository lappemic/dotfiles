#!/bin/bash

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Define ZSH_CUSTOM if not already set
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Install zsh-completions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
fi

# Install zsh-history-substring-search
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]; then
  git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
fi

# Install zsh-vi-mode
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-vi-mode" ]; then
  git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
fi

# Install zsh-z
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ]; then
  git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
fi

# Check if already a vscode settings.json file exists
if [ ! -L ~/Library/Application\ Support/Code/User/settings.json ]; then
    # Backup existing settings.json if it exists
    mv ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json.backup

    # Create a symlink
    ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
fi


# Create symlinks for dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.fzf.zsh ~/.fzf.zsh
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux-dracula ~/tmux-dracula
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config


# Install vim-plug for Vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install node and npm if not installed
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
   curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
   sudo apt-get install -y nodejs
fi

# Install GitHub Copilot plugin for Vim
if [ ! -d ~/.vim/plugged/copilot.vim ]; then
    vim -c 'PlugInstall github/copilot.vim' -c 'qa!'
fi

# let zsh use the pyenv python
# https://opensource.com/article/19/5/python-3-default-mac
# Check if the command exists in ~/.zshrc
if ! grep -q 'if command -v pyenv 1>/dev/null 2>&1; then' ~/.zshrc; then
  echo 'if command -v pyenv 1>/dev/null 2>&1; then' >> ~/.zshrc
  echo '  eval "$(pyenv init -)"' >> ~/.zshrc
  echo 'fi' >> ~/.zshrc
  # Source the ~/.zshrc file to apply changes immediately
  source ~/.zshrc
fi

echo "Dotfiles setup completed. Please restart your terminal."
