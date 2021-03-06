set nocompatible              " required
filetype off                  " required

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
if has('python')
Plugin 'vim-scripts/indentpython.vim'
" Bundle 'Valloric/YouCompleteMe'
endif
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'posva/vim-vue'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8

" switch solarized
call togglebg#map("<F5>")

let python_highlight_all=1
syntax on
set hlsearch
let g:pythonLocation = system("which python2")
if strlen(g:pythonLocation) > 0
  let g:python_host_prog = g:pythonLocation[:-2]
endif
let g:pythonLocation = system("which python3")
if strlen(g:pythonLocation) > 0
  let g:python3_host_prog = g:pythonLocation[:-2]
endif
let g:airline_solarized_bg='dark'

if has('gui_running')
  set background=dark
  colorscheme solarized
  AirlineTheme solarized
else
  colorscheme zenburn
endif

highlight Comment cterm=italic

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave ?* silent! mkview
  autocmd BufWinEnter ?* silent! loadview
augroup END

highlight BadWhitespace ctermbg=red guibg=red
set foldenable
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" crontab configuration
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
autocmd filetype crontab setlocal nobackup nowritebackup


" Printing
set printexpr=PrintFile(v:fname_in)
function PrintFile(fname)
  call system("a2ps " . a:fname)
  call delete(a:fname)
  return v:shell_error
endfunc

highlight Comment cterm=italic
