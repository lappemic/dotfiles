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

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom aliases
alias icd='cd $(find * -type d | fzf)'
alias gacp="git add . && git commit && git push"
alias zshconfig="vim ~/dotfiles/.zshrc"
alias vimconfig="vim ~/dotfiles/.vimrc"
alias tmuxconfig="vim ~/dotfiles/.tmux.conf"
alias ghcs="gh copilot suggest"
alias dc="docker compose"
alias dcd="docker compose down"
alias e="exit"
alias c="clear"
alias ll="ls -lah"
alias pnd="pnpm dev"
alias pni="pnpm install"

# Semantic commit helper: gc <type> <message> (e.g., gc feat "add login")
gc() {
  if [ $# -lt 2 ]; then
    echo "Usage: gc <type> <message>"
    echo "Types: feat, fix, docs, style, refactor, test, chore"
    return 1
  fi
  git commit -m "$1: $2"
}

# Stage all and semantic commit: gac <type> <message>
gac() {
  if [ $# -lt 2 ]; then
    echo "Usage: gac <type> <message>"
    echo "Types: feat, fix, docs, style, refactor, test, chore"
    return 1
  fi
  git add . && git commit -m "$1: $2"
}


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

# Load private tokens from ~/.secrets (not tracked by git)
[[ -f ~/.secrets ]] && source ~/.secrets

# fzf shell integration (Ctrl+R history, Ctrl+T files, Alt+C cd)
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# Setup direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Lazy-load conda (faster shell startup)
conda() {
  unfunction conda
  if [[ "$OSTYPE" == "darwin"* ]]; then
    __conda_setup="$('/Users/mi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then eval "$__conda_setup"; else
      [ -f "/Users/mi/miniconda3/etc/profile.d/conda.sh" ] && . "/Users/mi/miniconda3/etc/profile.d/conda.sh"
    fi
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    __conda_setup="$('/home/mi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then eval "$__conda_setup"; else
      [ -f "/home/mi/miniconda3/etc/profile.d/conda.sh" ] && . "/home/mi/miniconda3/etc/profile.d/conda.sh"
    fi
  fi
  unset __conda_setup
  conda "$@"
}

# Auto-start tmux if not already inside a tmux session
if [[ $- == *i* ]] && [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ -t 1 ]]; then
  tmux
fi  
. "$HOME/.local/bin/env"

# Homebrew Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
