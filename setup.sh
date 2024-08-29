#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Zsh if not installed (Ubuntu-specific)
if ! command_exists zsh; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y zsh
    fi
fi

# Set Zsh as the default shell
if [[ "$SHELL" != */zsh ]]; then
    chsh -s $(which zsh)
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Define ZSH_CUSTOM if not already set
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Install Powerlevel10k theme for Oh My Zsh
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Install tmux-dracula theme
if [ ! -d "$HOME/.tmux/tmux-dracula" ]; then
  git clone https://github.com/dracula/tmux.git $HOME/.tmux/tmux-dracula
fi

# Install zsh plugins
plugins=(
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "zsh-completions"
    "zsh-history-substring-search"
    "zsh-vi-mode"
    "zsh-z"
)

for plugin in "${plugins[@]}"; do
    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
        git clone "https://github.com/zsh-users/$plugin" "$ZSH_CUSTOM/plugins/$plugin"
    fi
done

# VSCode settings
vscode_settings_dir=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    vscode_settings_dir="$HOME/Library/Application Support/Code/User"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    vscode_settings_dir="$HOME/.config/Code/User"
fi

if [ ! -L "$vscode_settings_dir/settings.json" ]; then
    # Backup existing settings.json if it exists
    [ -f "$vscode_settings_dir/settings.json" ] && mv "$vscode_settings_dir/settings.json" "$vscode_settings_dir/settings.json.backup"

    # Create a symlink
    mkdir -p "$vscode_settings_dir"
    ln -s ~/dotfiles/vscode/settings.json "$vscode_settings_dir/settings.json"
fi

# Create symlinks for dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.fzf.zsh ~/.fzf.zsh
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config

# Install vim-plug for Vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install node and npm if not installed
if ! command_exists node || ! command_exists npm; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS-specific installation
        brew install node
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu-specific installation
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
fi

# Install GitHub Copilot plugin for Vim
if [ ! -d ~/.vim/plugged/copilot.vim ]; then
    vim -c 'PlugInstall github/copilot.vim' -c 'qa!'
    # Authenticate with GitHub Copilot
    echo "Please authenticate with GitHub Copilot in Vim"
    vim -c 'Copilot setup' -c 'qa!'
fi

# Pyenv setup
if ! grep -q 'if command -v pyenv 1>/dev/null 2>&1; then' ~/.zshrc; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS-specific pyenv setup
        echo 'if command -v pyenv 1>/dev/null 2>&1; then' >> ~/.zshrc
        echo '  eval "$(pyenv init -)"' >> ~/.zshrc
        echo 'fi' >> ~/.zshrc
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu-specific pyenv setup
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
        echo 'if command -v pyenv 1>/dev/null 2>&1; then' >> ~/.zshrc
        echo '  eval "$(pyenv init -)"' >> ~/.zshrc
        echo 'fi' >> ~/.zshrc
    fi
    # Source the ~/.zshrc file to apply changes immediately
    source ~/.zshrc
fi

# Update .tmux.conf to include the dracula theme
if ! grep -q 'run-shell "~/.tmux/tmux-dracula/dracula.tmux"' ~/.tmux.conf; then
  echo 'run-shell "~/.tmux/tmux-dracula/dracula.tmux"' >> ~/.tmux.conf
  echo 'run-shell "tmux source ~/.tmux.conf"'
fi

echo "Dotfiles setup completed. Please restart your terminal."