"
" since you always forget - reload config file with ':so %' or path to config
"
set nocompatible " still needed in nvim?
syntax enable
"set mouse=a

set modelines=5

" decent defaults for most stuff
set tabstop=4 shiftwidth=4 softtabstop=4

"Show all sorts of good information
set number
set showmode
set showcmd
set ruler
"Searching options
set hlsearch
set incsearch
set ignorecase
set smartcase

" plugins via https://github.com/junegunn/vim-plug
" Installation:
" vim:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" neovim:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" run :PlugInstall to load them after installing plug.vim

filetype plugin indent on

call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'beeender/Comrade' " IntelliJ integration via ComradeNeovim
Plug 'tpope/vim-commentary'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'sheerun/vim-polyglot'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ciaranm/inkpot'
Plug 'editorconfig/editorconfig-vim'
"Plug 'itchyny/lightline.vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'mxw/vim-jsx'
Plug 'nanotech/jellybeans.vim'
"Plug 'pangloss/vim-javascript'
"Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
"Plug 'udalov/kotlin-vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/wombat256.vim' " color name is wombat256mod
Plug 'godlygeek/tabular' " vim-markdown dep
"Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'glepnir/spaceline.vim'
Plug 'ryanoasis/vim-devicons' " spaceline dep
Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

nnoremap <leader>v <cmd>CHADopen<cr>

let g:vim_markdown_folding_disabled = 1

" make :Gbrowse work - open current file in browser on our gitlab!
let g:fugitive_gitlab_domains = ['https://prod-gitlab.sprinklr.com']

"let g:lightline = {
"	\ 'colorscheme': 'jellybeans',
"	\ }

let g:spaceline_seperate_style = 'curve'
let g:spaceline_colorscheme = 'one'

set termguicolors
set background = "dark"
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

color jellybeans

"color palenight

let g:jellybeans_use_term_italics = 1
let g:jellybeans_overrides = {
	\    'background': { 'guibg': '000000' },
	\}

" for pangloss/vim-javascript
let g:javascript_plugin_flow = 1

filetype plugin indent on

" NERDTree
" https://medium.com/@victormours/a-better-nerdtree-setup-3d3921abc0b9
"nnoremap <Leader>f :NERDTreeToggle<Enter>
"nnoremap <silent> <Leader>v :NERDTreeFind<CR>
"let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
