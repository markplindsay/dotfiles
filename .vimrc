" https://github.com/junegunn/vim-plug
set nocompatible
filetype off
call plug#begin()
Plug 'VundleVim/Vundle.vim'
" Plugs here vvv
Plug 'alampros/vim-styled-jsx'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lumiliet/vim-twig'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'prettier/vim-prettier'
Plug 'sickill/vim-monokai'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/BufOnly.vim'
Plug 'w0rp/ale'
Plug 'warbear0129/vim-qtpl'
" Plugs here ^^^
call plug#end()
filetype plugin indent on

autocmd BufNewFile,BufRead *.py
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

autocmd BufNewFile,BufRead .vimrc,*.js,*.html,*.css,*.sass,*.yml,*.scss,*.json,*.ts,*.tsx,*.jsx,*.conf,*.php,*.theme,*.module,*.sh
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

autocmd BufNewFile,BufRead *.go
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set noexpandtab

autocmd BufNewFile,BufRead *.ts
  \ set filetype=typescript

autocmd BufNewFile,BufRead *.tsx
  \ set filetype=typescript.tsx

autocmd BufNewFile,BufRead *.js
  \ set filetype=javascript

autocmd BufNewFile,BufRead *.jsx
  \ set filetype=javascript.jsx

autocmd BufNewFile,BufRead *.theme,*.module
  \ set filetype=php

" Don't throw away buffers when switching out of them
set hidden

" let python_highlight_all=1
syntax enable
colorscheme monokai
set number
set colorcolumn=80
set cursorline

" https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
nnoremap <silent> <leader>T :enew<CR>
nnoremap <silent> <leader>l :bnext<CR>
nnoremap <silent> <leader>h :bprevious<CR>
nnoremap <silent> <leader>bq :bp <BAR> bd #<CR>
nnoremap <silent> <leader>bl :ls<CR>
nnoremap <silent> <leader>q :BufOnly<CR>

" https://github.com/pangloss/vim-javascript
let g:javascript_plugin_flow = 1

" https://github.com/scrooloose/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
let NERDTreeWinSize=60

" https://github.com/w0rp/ale
nnoremap <silent> <leader>d :ALEDetail<CR>
nnoremap <silent> <leader>g :ALEGoToDefinition<CR>
let g:ale_completion_enabled = 1
let g:ale_fixers = {
  \ 'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']
  \ }
let g:ale_fix_on_save = 1
let g:ale_linters = {
  \ 'javascript': ['eslint', 'flow', 'flow-language-server']
  \ }
let g:ale_sign_column_always = 1
" https://github.com/w0rp/ale/issues/1700
set completeopt+=noinsert

" https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1

" https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <silent> <leader>w :call TrimWhitespace()<CR>

" https://github.com/prettier/vim-prettier
" Installation w/ vundle:
" https://gist.github.com/remarkablemark/23669b32afad86d32b1084f6abc4a9b5
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.yml PrettierAsync
