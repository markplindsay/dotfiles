set nocompatible
call plug#begin()
" Plugs here vvv
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'leafgarland/typescript-vim'
Plug 'warbear0129/vim-qtpl'
Plug 'sickill/vim-monokai'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/BufOnly.vim'
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} " Need to :call coc#util#install() after
Plug 'hashivim/vim-terraform'
" Plugs here ^^^
call plug#end()

autocmd BufNewFile,BufRead *.py
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

autocmd BufNewFile,BufRead .vimrc,*.js,*.html,*.css,*.sass,*.yml,*.scss,*.json,*.ts,*.tsx,*.jsx,*.conf,*.tf
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

autocmd BufNewFile,BufRead *.graphql,*.php,*.theme,*.module,*.twig,*.inc
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set expandtab |
  \ set fileformat=unix

autocmd BufNewFile,BufRead *.go,*.qtpl
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set noexpandtab

autocmd BufNewFile,BufRead /var/www/slackdesign/*.php
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set expandtab |
  \ set fileformat=unix

autocmd BufNewFile,BufRead /var/www/slackdesign/*.less
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set expandtab |
  \ set fileformat=unix

autocmd BufNewFile,BufRead *.ts
  \ set filetype=typescript

autocmd BufNewFile,BufRead *.tsx
  \ set filetype=typescript.tsx

autocmd BufNewFile,BufRead *.js
  \ set filetype=javascript

autocmd BufNewFile,BufRead *.jsx
  \ set filetype=javascript.jsx

autocmd BufNewFile,BufRead *.theme,*.module,*.inc
  \ set filetype=php

autocmd BufNewFile,BufRead *.twig
  \ set filetype=html

autocmd BufNewFile,BufRead Jenkinsfile
  \ set filetype=groovy

autocmd BufNewFile,BufRead *.md,*.mdx
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2 |
  \ set expandtab |
  \ set fileformat=unix

" Don't throw away buffers when switching out of them
set hidden

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

"
" https://github.com/neoclide/coc.nvim
"

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" vim-go
let g:go_def_mapping_enabled = 0

" https://github.com/scrooloose/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
let NERDTreeWinSize=33

" https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 2

" https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <silent> <leader>w :call TrimWhitespace()<CR>

" https://github.com/neoclide/coc-prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.yml,*.html Prettier

" Stop obnoxiously highlighting reserved words in typescript.tsx
highlight link typescriptReserved Keyword

" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_fenced_languages = ['ts=typescript', 'tsx=typescript.tsx']

set mouse=
