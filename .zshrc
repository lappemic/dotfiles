# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  history-substring-search
  nvm
  zsh-you-should-use
)

source $ZSH/oh-my-zsh.sh

# Enable syntax highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable autosuggestions
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Setup direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom aliases
alias icd='cd $(find * -type d | fzf)'
alias gacp="git add .; git commit -m 'update'; git push"
alias zshconfig="vim ~/dotfiles/.zshrc"
alias vimconfig="vim ~/dotfiles/.vimrc"
alias tmuxconfig="vim ~/dotfiles/.tmux.conf"
alias ghcs="gh copilot suggest"
alias dc="docker compose"
alias dcd="docker compose down"


# Add pyenv to PATH so pyenv python is used instead of system python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pnpm
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS pnpm setup
  export PNPM_HOME="$HOME/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu pnpm setup
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# Conda initialization
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS Conda setup
  __conda_setup="$('/Users/mi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/Users/mi/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/Users/mi/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/Users/mi/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu Conda setup
  __conda_setup="$('/home/mi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/mi/miniconda3/etc/profile.d/conda.sh" ]; then
      . "/home/mi/miniconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/mi/miniconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
fi

# Conditional Homebrew PATH addition
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
fi

# Platform-specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS-specific alias
  alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Ubuntu-specific aliases (if any)
  # Add them here
fi

# create a file in a not yet existing directory
mktouch() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Auto-start tmux if not already inside a tmux session
if command -v tmux &> /dev/null; then
  if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    tmux
  fi
fi
