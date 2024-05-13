#!/bin/bash

# Symlink dotfiles to home directory
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

echo "Dotfiles setup completed"
