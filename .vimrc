" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Add plugins here
Plug 'morhetz/gruvbox'          " Gruvbox theme
Plug 'tpope/vim-sensible'       " Sensible defaults for Vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'         " FZF integration for Vim
Plug 'scrooloose/nerdtree'      " File explorer
Plug 'airblade/vim-gitgutter'   " Git integration
Plug 'davidhalter/jedi-vim'     " Python autocompletion
" Plug 'github/copilot.vim'       " Github copilot (disabled)
Plug 'tpope/vim-surround'       " Surround text objects
Plug 'christoomey/vim-tmux-navigator'  " Seamless vim/tmux navigation

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
set clipboard=unnamed       " Use system clipboard (macOS)
set cursorline              " Highlight the current line
set termguicolors           " Enable 24-bit RGB colors
set hidden                  " Switch buffers without saving
set undofile                " Persistent undo across sessions
set undodir=~/.vim/undodir  " Store undo files here
set backupdir=~/.vim/backupdir  " Store backup files here
set directory=~/.vim/swapdir    " Store swap files here
set scrolloff=8             " Keep 8 lines visible above/below cursor
set signcolumn=yes          " Prevent layout shift from gitgutter
set updatetime=300          " Faster updates (default 4000ms)

" Set leader key to space
let mapleader = " "

" NERDTree settings
" -> Toggle NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>   

" FZF settings
" -> " Open FZF file finder with Ctrl+p
map <C-p> :Files<CR>


" Enable jedi autocompletion, auto initialization and show call signatures
" dynamically
let g:jedi#completions_enabled = 1
let g:jedi#auto_initialization = 1
let g:jedi#show_call_signatures = "1"

" Open NERDTree on startup: focus file if given, else focus NERDTree
autocmd VimEnter * if argc() > 0 | NERDTreeFind | wincmd p | else | NERDTree | endif

" Close vim if NERDTree is the only window left
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Jump to current file in tree
nnoremap <leader>n :NERDTreeFind<CR>
