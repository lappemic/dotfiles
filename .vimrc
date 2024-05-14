" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Add plugins here
Plug 'morhetz/gruvbox'          " Gruvbox theme
Plug 'tpope/vim-sensible'       " Sensible defaults for Vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'         " FZF integration for Vim
Plug 'scrooloose/nerdtree'      " File explorer
Plug 'airblade/vim-gitgutter'   " Git integration

" Initialize plugin system
call plug#end()

" Set Gruvbox as the colorscheme
syntax enable
set background=dark
colorscheme gruvbox

" General settings
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set expandtab               " Use spaces instead of tabs
set tabstop=4               " Number of spaces tabs count for
set shiftwidth=4            " Number of spaces to use for each step of (auto)indent
set softtabstop=4           " Number of spaces that a <Tab> counts for while performing editing operations
set autoindent              " Copy indent from current line when starting a new line
set smartindent             " Do smart autoindenting when starting a new line
set hlsearch                " Highlight search matches
set incsearch               " Show search matches as you type
set ignorecase              " Ignore case when searching
set smartcase               " Override ignorecase if search contains capitals
set clipboard=unnamedplus   " Use system clipboard
set cursorline              " Highlight the current line
set termguicolors           " Enable 24-bit RGB colors

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>    " Toggle NERDTree with Ctrl+n

" FZF settings
map <C-p> :Files<CR>             " Open FZF file finder with Ctrl+p

" Automatically activate Python virtual environments
autocmd BufEnter * if isdirectory('.venv') | execute '!source .venv/bin/activate' | endif
autocmd BufEnter * if isdirectory('venv') | execute '!source venv/bin/activate' | endif
