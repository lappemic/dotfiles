# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
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
eval "$(direnv hook zsh)"

# Uncomment to enable command auto-correction.
ENABLE_CORRECTION="true"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom aliases
# Use fzf for interactive cd
alias icd='cd $(find * -type d | fzf)'
alias gacp="git add .; git commit -m 'update'; git push"
# https://github.com/pyenv/pyenv#homebrew-in-macos 
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias zshconfig="vim ~/dotfiles/.zshrc"

# Uncomment to enable command auto-correction.
ENABLE_CORRECTION="true"

# let zsh use the pyenv python
# https://opensource.com/article/19/5/python-3-default-mac
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
