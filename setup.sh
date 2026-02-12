#!/bin/zsh

# Function to install Vim-Plug
install_vim_plug() {
    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}

# Function to install Gruvbox color scheme for Vim
install_gruvbox() {
    if [ ! -d ~/.vim/pack/default/start/gruvbox ]; then
        mkdir -p ~/.vim/pack/default/start
        git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
    fi
}

# Install direnv if not installed
if ! command -v direnv &> /dev/null; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install direnv
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y direnv
    fi
fi

# Check if Zsh is installed, if not, install it
if ! command -v zsh &> /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y zsh
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    fi
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

# Install various Zsh plugins
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
        git clone https://github.com/zsh-users/$plugin.git $ZSH_CUSTOM/plugins/$plugin
    fi
done

# Create symlinks for dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.fzf.zsh ~/.fzf.zsh
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Ensure .ssh directory exists
mkdir -p ~/.ssh
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config

# Ensure Ghostty config directory exists and link config
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
ln -sf ~/dotfiles/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config

# Install Vim-Plug and Gruvbox
install_vim_plug
install_gruvbox

# Install node and npm if not installed
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS-specific installation
        brew install node
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu-specific installation
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
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

# Setup pyenv in .zshrc if not already present
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