if !exists('g:loaded_gitgutter') | finish | endif

set updatetime=100 " responsive status update

" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk) " git previous
