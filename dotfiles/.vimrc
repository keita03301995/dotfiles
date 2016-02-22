set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" コピペモード用のキーバインド
set pastetoggle=<C-E>

" 自動的にコメントアウトされないように
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" コメントの色を緑色に
hi Comment ctermfg=green
