#!/bin/bash

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# zsh-completions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
fi

# Install zsh-history-substring-search
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]; then
  git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search
fi

# Install zsh-you-should-use
if [ ! -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
  git clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use
fi

# Install zsh-direnv
if [ ! -d "$ZSH_CUSTOM/plugins/direnv" ]; then
  git clone https://github.com/direnv/direnv $ZSH_CUSTOM/plugins/direnv
fi

# Install zsh-interactive-cd
if [ ! -d "$ZSH_CUSTOM/plugins/interactive-cd" ]; then
  git clone https://github.com/changyuheng/zsh-interactive-cd $ZSH_CUSTOM/plugins/interactive-cd
fi

# Install zsh-z
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ]; then
  git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
fi

# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Symlink dotfiles to home directory
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

echo "Dotfiles setup completed, don't forget to restart the terminal."
