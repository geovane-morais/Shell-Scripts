set mouse=a " Habilita o mouse no vim

set wildmode=longest,list " para completar com TAB igualzinho o bash faz
set shiftwidth=4 " se mudar o valor eu te mato :-P, numero de espaço usado quando rolar o autoindent
set wildmode=longest,list " para completar com TAB igualzinho o bash faz
set ai " auto indent
set tabstop=4 " por favor, também nao mude isso! numero de espações que deve-se voltando quando apertar o backspace num tab
set bs=2 " para o backspace se comportar como a gente gosta

set termencoding=utf8 " UTF-8 Habilitado

set is hls ic scs " opções de busca

source $VIMRUNTIME/mswin.vim
behave mswin
map <C-a> ggVG
map <C-c> "+y

set number
syntax on

call plug#begin()

" Procure por plugins em
" https://vimawesome.com

" ******** Plugin que melhora o visual ********
Plug 'vim-airline/vim-airline'
" *********************************************


" ******Acrescenta navegação de arquivos*******
Plug 'preservim/nerdtree'
autocmd vimenter * NERDTree
" *********************************************


call plug#end()
