set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'posva/vim-vue'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1
syntax on
set hlsearch
let g:python_host_prog = '/opt/local/bin/python2.7'
let g:python3_host_prog = '/opt/local/bin/python3'

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

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

