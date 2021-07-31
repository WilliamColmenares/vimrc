" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set path +=**
filetype off
syntax enable
set number
set nohlsearch
set incsearch
set noshowmode
set nocp
set termguicolors
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set smartindent
set autoindent
set scrolloff=10
set autoread
setlocal spelllang=en_us
set nowrap
set relativenumber
" https://jovicailic.org/2017/04/vim-persistent-undo/
" --- remove sounds effects ---
set noerrorbells
" http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
" set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
" --- backup and swap files ---
" I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undodir
set laststatus=2  " always display the status line

" allow buffer switching without saving
set hidden
set ic
set updatetime=50

call plug#begin('~/.vim/plugged')

Plug 'posva/vim-vue'
Plug 'scrooloose/nerdcommenter'
" https://freshman.tech/vim-javascript/#intelligent-code-completion
"
" To install language servers, manually call:
"   CocInstall coc-tsserver coc-json coc-html coc-css
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
"Plug 'MobiusHorizons/fugitive-stash.vim'
Plug 'ap/vim-css-color'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'alvan/vim-closetag'
"Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ervandew/supertab'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-sleuth'
Plug 'pangloss/vim-javascript'
Plug 'voldikss/vim-floaterm'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'HerringtonDarkholme/yats.vim' " TypeScript sintax
Plug 'itchyny/lightline.vim'
Plug 'prettier/vim-prettier', {
      \ 'do': 'npm install' }
Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
"Plug 'moll/vim-node'
Plug 'machakann/vim-highlightedyank'
Plug 'ntpeters/vim-better-whitespace'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'RRethy/vim-illuminate'
"Plug 'rhysd/git-messenger.vim'
"Plug 'antoinemadec/coc-fzf'

" Initialize plugin system
call plug#end()

nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP


" Coc disable
autocmd FileType python let b:coc_suggest_disable=1
autocmd FileType javascript let b:coc_suggest_disable=1
autocmd FileType scss setl iskeyword+=@-@

"kite
let g:kite_supported_languages = ['python', 'javascript', 'go']

colorscheme vim-monokai-tasty

if &filetype == "javascript" || &filetype == "python" || &filetype == "go"
    inoremap <c-space> <C-x><C-u>
else
    inoremap <silent><expr> <c-space> coc#refresh()
endif

let g:SuperTabDefaultCompletionType = "<c-n>"

"Display whitespace color
let g:better_whitespace_ctermcolor='red'

"To enable highlighting and stripping whitespace on save by default, use respectively
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1


let mapleader = "\<Space>"
function! ToggleNERDTree()
  NERDTreeToggle
"  silent NERDTreeMirror
endfunction

nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>nt :NERDTreeFind<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>b :Prettier<CR>
" show hidden whitespace
highlight ExtraWhitespace ctermbg=red guibg=red

au BufNewFile,BufRead & *.py \ "folding on python based on indent
  set foldmethod=indent

" Configuration floaterm
let g:floaterm_keymap_new    = '<leader>/' " '<F5>'
let g:floaterm_keymap_prev   = '<leader>m'
let g:floaterm_keymap_next   = '<leader>n'
let g:floaterm_keymap_toggle = '<leader>,'

"map the folding method
nnoremap <space> za<CR>

let g:fuf_file_exclude = '\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.pyc$'


" FZF key bindings
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>

"Remap keys for goto
map <silent> gd <Plug>(coc-definition)
map <silent> gy <Plug>(coc-type-definition)
map <silent> gi <Plug>(coc-implementation)
map <silent> gr <Plug>(coc-references)

nnoremap <leader>u :UndotreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

let g:ale_python_pylint_options = '--load-plugins pylint-django' "make ale work with python

" hitting jj will jump out of insert mode
inoremap jj <esc>

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.vue'

" quick vertical split
nnoremap <leader>v :vsp<CR><C-w><C-w>

" Make j and k work normally for soft wrapped lines
nnoremap <buffer> j gj
nnoremap <buffer> k gk

" Make the arrow keys work like TextMate in insert mode
inoremap <down> <C-C>gja
inoremap <up> <C-C>gka

nnoremap <leader>R :source ~/.vimrc<CR>

packloadall
