# Dotfiles

This repository holds my personal dotfiles and the small setup script I use to bootstrap a new machine.

Supported platforms:
- macOS
- Ubuntu

Feel free to copy whatever is useful for you.

Learn more about my workflow at [michaelscheiwiller.com](https://michaelscheiwiller.com)

## Repository overview

| Path | Purpose |
| ---- | ------- |
| `setup.sh` | Bootstrap script to install packages, set up shell plugins, Vim/VS Code extensions, and create the required symlinks for all dotfiles. |
| `vscode/settings.json` | Opinionated VS Code configuration (themes, linting & formatting rules, terminal settings, etc.). |
| `LICENSE` | MIT license for this repo. |

Additional hidden files (e.g. `.zshrc`, `.gitconfig`, `.vimrc`, `.tmux.conf`, etc.) will be symlinked into place by `setup.sh` once you clone this repo into `~/dotfiles`.
